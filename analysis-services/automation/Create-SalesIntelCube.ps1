param(
    [string]$AnalysisServer = "localhost\SSAS2022",
    [string]$SqlServer = "DESKTOP-5QBHCJS",
    [string]$SqlDatabase = "SalesIntel_DW",
    [string]$SsasDatabase = "SalesIntel_DW_Cubo",
    [switch]$SkipProcess
)

$ErrorActionPreference = "Stop"

function Import-Assembly {
    param(
        [Parameter(Mandatory = $true)][string]$AssemblyName,
        [Parameter(Mandatory = $true)][string]$FileName
    )

    try {
        Add-Type -AssemblyName $AssemblyName -ErrorAction Stop
        return
    }
    catch {
        $roots = @(
            "$env:ProgramFiles\Microsoft SQL Server",
            "$env:ProgramFiles(x86)\Microsoft SQL Server",
            "$env:ProgramFiles\Microsoft SQL Server Management Studio 20",
            "$env:ProgramFiles(x86)\Microsoft SQL Server Management Studio 20",
            "$env:ProgramFiles\Microsoft Visual Studio\2022"
        ) | Where-Object { $_ -and (Test-Path $_) }

        foreach ($root in $roots) {
            $candidate = Get-ChildItem -Path $root -Filter $FileName -File -Recurse -ErrorAction SilentlyContinue |
                Select-Object -First 1

            if ($candidate) {
                Add-Type -Path $candidate.FullName
                return
            }
        }

        throw "No se pudo cargar $AssemblyName ($FileName). Verifica que SSMS/Analysis Services Projects estén instalados."
    }
}

function New-DataItem {
    param(
        [Parameter(Mandatory = $true)]$Dsv,
        [Parameter(Mandatory = $true)][string]$TableName,
        [Parameter(Mandatory = $true)][string]$ColumnName
    )

    $column = $Dsv.Schema.Tables[$TableName].Columns[$ColumnName]
    if (-not $column) {
        throw "No existe la columna $TableName.$ColumnName en el DSV."
    }

    $oleType = [Microsoft.AnalysisServices.OleDbTypeConverter]::GetRestrictedOleDbType($column.DataType)
    return [Microsoft.AnalysisServices.DataItem]::new($TableName, $ColumnName, $oleType)
}

function Add-DimensionAttribute {
    param(
        [Parameter(Mandatory = $true)]$Dimension,
        [Parameter(Mandatory = $true)]$Dsv,
        [Parameter(Mandatory = $true)][string]$AttributeName,
        [Parameter(Mandatory = $true)][string]$TableName,
        [Parameter(Mandatory = $true)][string]$KeyColumn,
        [string]$NameColumn,
        [switch]$IsKey
    )

    $attr = $Dimension.Attributes.Add($AttributeName)
    if ($IsKey) {
        $attr.Usage = [Microsoft.AnalysisServices.AttributeUsage]::Key
    }

    [void]$attr.KeyColumns.Add((New-DataItem -Dsv $Dsv -TableName $TableName -ColumnName $KeyColumn))

    if ($NameColumn) {
        $attr.NameColumn = New-DataItem -Dsv $Dsv -TableName $TableName -ColumnName $NameColumn
    }

    return $attr
}

function Add-RegularMeasureGroupDimension {
    param(
        [Parameter(Mandatory = $true)]$Cube,
        [Parameter(Mandatory = $true)]$MeasureGroup,
        [Parameter(Mandatory = $true)]$Dsv,
        [Parameter(Mandatory = $true)][string]$DimensionName,
        [Parameter(Mandatory = $true)][string]$GranularityAttributeName,
        [Parameter(Mandatory = $true)][string]$FactKeyColumn
    )

    $cubeDim = $Cube.Dimensions.GetByName($DimensionName)
    $reg = [Microsoft.AnalysisServices.RegularMeasureGroupDimension]::new($cubeDim.ID)
    [void]$MeasureGroup.Dimensions.Add($reg)

    $dimAttr = $cubeDim.Dimension.Attributes.GetByName($GranularityAttributeName)
    $mgAttr = $reg.Attributes.Add($dimAttr.ID)
    $mgAttr.Type = [Microsoft.AnalysisServices.MeasureGroupAttributeType]::Granularity
    [void]$mgAttr.KeyColumns.Add((New-DataItem -Dsv $Dsv -TableName "vw_Cubo_FactVentas" -ColumnName $FactKeyColumn))
}

Import-Assembly -AssemblyName "Microsoft.AnalysisServices" -FileName "Microsoft.AnalysisServices.dll"
Add-Type -AssemblyName System.Data

$sqlConnectionString = "Provider=MSOLEDBSQL19.1;Data Source=$SqlServer;Integrated Security=SSPI;Initial Catalog=$SqlDatabase;Encrypt=Mandatory;TrustServerCertificate=True"

Write-Host "== SalesIntel DW / SSAS Cube Builder ==" -ForegroundColor Cyan
Write-Host "SQL Server:       $SqlServer"
Write-Host "SQL Database:     $SqlDatabase"
Write-Host "Analysis Server:  $AnalysisServer"
Write-Host "SSAS Database:    $SsasDatabase"
Write-Host ""

$views = [ordered]@{
    "vw_Cubo_DimProducto" = "ProductoKey"
    "vw_Cubo_DimCiudad"   = "CiudadKey"
    "vw_Cubo_DimCliente"  = "ClienteKey"
    "vw_Cubo_DimTiempo"   = "TiempoKey"
    "vw_Cubo_FactVentas"  = "VentaKey"
}

Write-Host "[1/7] Validando acceso al Data Warehouse..." -ForegroundColor Yellow
$sql = [System.Data.OleDb.OleDbConnection]::new($sqlConnectionString)
$sql.Open()
try {
    foreach ($view in $views.Keys) {
        $cmd = $sql.CreateCommand()
        $cmd.CommandText = "SELECT TOP (1) * FROM dbo.[$view];"
        [void]$cmd.ExecuteReader().Close()
        Write-Host "  OK dbo.$view"
    }
}
finally {
    $sql.Close()
}

Write-Host "[2/7] Conectando a Analysis Services..." -ForegroundColor Yellow
$server = [Microsoft.AnalysisServices.Server]::new()
$server.Connect($AnalysisServer)

try {
    $existing = $server.Databases.FindByName($SsasDatabase)
    if ($existing) {
        Write-Host "  Eliminando versión anterior de $SsasDatabase..."
        $existing.Drop()
    }

    $db = [Microsoft.AnalysisServices.Database]::new()
    $db.Name = $SsasDatabase
    $db.ID = $SsasDatabase
    [void]$server.Databases.Add($db)
    $db.Update()

    Write-Host "[3/7] Creando Data Source y Data Source View..." -ForegroundColor Yellow

    $ds = [Microsoft.AnalysisServices.RelationalDataSource]::new()
    $ds.Name = "SalesIntel DW"
    $ds.ID = "SalesIntel_DW"
    $ds.ConnectionString = $sqlConnectionString
    $ds.ImpersonationInfo.ImpersonationMode = [Microsoft.AnalysisServices.ImpersonationMode]::ImpersonateCurrentUser
    [void]$db.DataSources.Add($ds)
    $ds.Update()

    $schema = [System.Data.DataSet]::new("SalesIntel_DW_DSV")

    $sql = [System.Data.OleDb.OleDbConnection]::new($sqlConnectionString)
    $sql.Open()
    try {
        foreach ($view in $views.Keys) {
            $adapter = [System.Data.OleDb.OleDbDataAdapter]::new("SELECT TOP (0) * FROM dbo.[$view]", $sql)
            $tmp = [System.Data.DataSet]::new()
            [void]$adapter.FillSchema($tmp, [System.Data.SchemaType]::Source)

            if ($tmp.Tables.Count -ne 1) {
                throw "No se pudo obtener el esquema de dbo.$view."
            }

            $table = $tmp.Tables[0].Copy()
            $table.TableName = $view
            $table.ExtendedProperties["DbSchemaName"] = "dbo"
            $table.ExtendedProperties["DbTableName"] = $view
            $table.ExtendedProperties["FriendlyName"] = $view
            $table.ExtendedProperties["TableType"] = "View"
            [void]$schema.Tables.Add($table)
        }
    }
    finally {
        $sql.Close()
    }

    foreach ($entry in $views.GetEnumerator()) {
        $table = $schema.Tables[$entry.Key]
        $table.PrimaryKey = [System.Data.DataColumn[]]@($table.Columns[$entry.Value])
    }

    [void]$schema.Relations.Add([System.Data.DataRelation]::new(
        "FK_Producto_FactVentas",
        $schema.Tables["vw_Cubo_DimProducto"].Columns["ProductoKey"],
        $schema.Tables["vw_Cubo_FactVentas"].Columns["ProductoKey"],
        $false
    ))
    [void]$schema.Relations.Add([System.Data.DataRelation]::new(
        "FK_Ciudad_FactVentas",
        $schema.Tables["vw_Cubo_DimCiudad"].Columns["CiudadKey"],
        $schema.Tables["vw_Cubo_FactVentas"].Columns["CiudadKey"],
        $false
    ))
    [void]$schema.Relations.Add([System.Data.DataRelation]::new(
        "FK_Cliente_FactVentas",
        $schema.Tables["vw_Cubo_DimCliente"].Columns["ClienteKey"],
        $schema.Tables["vw_Cubo_FactVentas"].Columns["ClienteKey"],
        $false
    ))
    [void]$schema.Relations.Add([System.Data.DataRelation]::new(
        "FK_Tiempo_FactVentas",
        $schema.Tables["vw_Cubo_DimTiempo"].Columns["TiempoKey"],
        $schema.Tables["vw_Cubo_FactVentas"].Columns["TiempoKey"],
        $false
    ))

    $dsv = [Microsoft.AnalysisServices.DataSourceView]::new()
    $dsv.Name = "SalesIntel DW DSV"
    $dsv.ID = "SalesIntel_DW_DSV"
    $dsv.DataSourceID = $ds.ID
    $dsv.Schema = $schema
    [void]$db.DataSourceViews.Add($dsv)
    $dsv.Update()

    Write-Host "[4/7] Creando dimensiones..." -ForegroundColor Yellow

    # Dim Producto
    $dimProducto = [Microsoft.AnalysisServices.Dimension]::new()
    $dimProducto.Name = "Dim Producto"
    $dimProducto.ID = "DimProducto"
    $dimProducto.Source = [Microsoft.AnalysisServices.DataSourceViewBinding]::new($dsv.ID)
    $dimProducto.StorageMode = [Microsoft.AnalysisServices.DimensionStorageMode]::Molap
    [void]$db.Dimensions.Add($dimProducto)
    [void](Add-DimensionAttribute -Dimension $dimProducto -Dsv $dsv -AttributeName "Nombre Producto" -TableName "vw_Cubo_DimProducto" -KeyColumn "ProductoKey" -NameColumn "NombreProducto" -IsKey)
    [void](Add-DimensionAttribute -Dimension $dimProducto -Dsv $dsv -AttributeName "Categoria" -TableName "vw_Cubo_DimProducto" -KeyColumn "Categoria")
    [void](Add-DimensionAttribute -Dimension $dimProducto -Dsv $dsv -AttributeName "Estado Producto" -TableName "vw_Cubo_DimProducto" -KeyColumn "EstadoProducto")
    $dimProducto.Update()

    # Dim Ciudad
    $dimCiudad = [Microsoft.AnalysisServices.Dimension]::new()
    $dimCiudad.Name = "Dim Ciudad"
    $dimCiudad.ID = "DimCiudad"
    $dimCiudad.Source = [Microsoft.AnalysisServices.DataSourceViewBinding]::new($dsv.ID)
    $dimCiudad.StorageMode = [Microsoft.AnalysisServices.DimensionStorageMode]::Molap
    [void]$db.Dimensions.Add($dimCiudad)
    [void](Add-DimensionAttribute -Dimension $dimCiudad -Dsv $dsv -AttributeName "Nombre Ciudad" -TableName "vw_Cubo_DimCiudad" -KeyColumn "CiudadKey" -NameColumn "NombreCiudad" -IsKey)
    [void](Add-DimensionAttribute -Dimension $dimCiudad -Dsv $dsv -AttributeName "Provincia" -TableName "vw_Cubo_DimCiudad" -KeyColumn "Provincia")
    [void](Add-DimensionAttribute -Dimension $dimCiudad -Dsv $dsv -AttributeName "Region" -TableName "vw_Cubo_DimCiudad" -KeyColumn "Region")
    $dimCiudad.Update()

    # Dim Cliente
    $dimCliente = [Microsoft.AnalysisServices.Dimension]::new()
    $dimCliente.Name = "Dim Cliente"
    $dimCliente.ID = "DimCliente"
    $dimCliente.Source = [Microsoft.AnalysisServices.DataSourceViewBinding]::new($dsv.ID)
    $dimCliente.StorageMode = [Microsoft.AnalysisServices.DimensionStorageMode]::Molap
    [void]$db.Dimensions.Add($dimCliente)
    [void](Add-DimensionAttribute -Dimension $dimCliente -Dsv $dsv -AttributeName "Nombre Cliente" -TableName "vw_Cubo_DimCliente" -KeyColumn "ClienteKey" -NameColumn "NombreCliente" -IsKey)
    [void](Add-DimensionAttribute -Dimension $dimCliente -Dsv $dsv -AttributeName "Tipo Cliente" -TableName "vw_Cubo_DimCliente" -KeyColumn "TipoCliente")
    $dimCliente.Update()

    # Dim Tiempo
    $dimTiempo = [Microsoft.AnalysisServices.Dimension]::new()
    $dimTiempo.Name = "Dim Tiempo"
    $dimTiempo.ID = "DimTiempo"
    $dimTiempo.Source = [Microsoft.AnalysisServices.DataSourceViewBinding]::new($dsv.ID)
    $dimTiempo.StorageMode = [Microsoft.AnalysisServices.DimensionStorageMode]::Molap
    $dimTiempo.Type = [Microsoft.AnalysisServices.DimensionType]::Time
    [void]$db.Dimensions.Add($dimTiempo)

    [void](Add-DimensionAttribute -Dimension $dimTiempo -Dsv $dsv -AttributeName "Fecha" -TableName "vw_Cubo_DimTiempo" -KeyColumn "TiempoKey" -NameColumn "Fecha" -IsKey)
    [void](Add-DimensionAttribute -Dimension $dimTiempo -Dsv $dsv -AttributeName "Anio" -TableName "vw_Cubo_DimTiempo" -KeyColumn "Anio")
    [void](Add-DimensionAttribute -Dimension $dimTiempo -Dsv $dsv -AttributeName "Trimestre" -TableName "vw_Cubo_DimTiempo" -KeyColumn "Trimestre")
    [void](Add-DimensionAttribute -Dimension $dimTiempo -Dsv $dsv -AttributeName "Nombre Trimestre" -TableName "vw_Cubo_DimTiempo" -KeyColumn "Trimestre" -NameColumn "NombreTrimestre")
    [void](Add-DimensionAttribute -Dimension $dimTiempo -Dsv $dsv -AttributeName "Mes" -TableName "vw_Cubo_DimTiempo" -KeyColumn "Mes")
    [void](Add-DimensionAttribute -Dimension $dimTiempo -Dsv $dsv -AttributeName "Nombre Mes" -TableName "vw_Cubo_DimTiempo" -KeyColumn "Mes" -NameColumn "NombreMes")
    [void](Add-DimensionAttribute -Dimension $dimTiempo -Dsv $dsv -AttributeName "Dia" -TableName "vw_Cubo_DimTiempo" -KeyColumn "Dia")
    [void](Add-DimensionAttribute -Dimension $dimTiempo -Dsv $dsv -AttributeName "Dia Semana" -TableName "vw_Cubo_DimTiempo" -KeyColumn "DiaSemana")

    $hier = $dimTiempo.Hierarchies.Add("Calendario")
    $hier.AllMemberName = "Todos los Periodos"
    $hier.Levels.Add("Anio").SourceAttributeID = $dimTiempo.Attributes.GetByName("Anio").ID
    $hier.Levels.Add("Trimestre").SourceAttributeID = $dimTiempo.Attributes.GetByName("Nombre Trimestre").ID
    $hier.Levels.Add("Mes").SourceAttributeID = $dimTiempo.Attributes.GetByName("Nombre Mes").ID
    $hier.Levels.Add("Fecha").SourceAttributeID = $dimTiempo.Attributes.GetByName("Fecha").ID
    $dimTiempo.Update()

    Write-Host "[5/7] Creando CuboVentasSalesIntel..." -ForegroundColor Yellow

    $cube = [Microsoft.AnalysisServices.Cube]::new()
    $cube.Name = "CuboVentasSalesIntel"
    $cube.ID = "CuboVentasSalesIntel"
    $cube.Source = [Microsoft.AnalysisServices.DataSourceViewBinding]::new($dsv.ID)
    $cube.StorageMode = [Microsoft.AnalysisServices.StorageMode]::Molap
    $cube.DefaultMeasure = "[Total Vendido]"
    [void]$db.Cubes.Add($cube)

    foreach ($dim in @($dimProducto, $dimCiudad, $dimCliente, $dimTiempo)) {
        [void]$cube.Dimensions.Add($dim.ID)
    }

    $mg = $cube.MeasureGroups.Add("Ventas")
    $mg.StorageMode = [Microsoft.AnalysisServices.StorageMode]::Molap
    $mg.ProcessingMode = [Microsoft.AnalysisServices.ProcessingMode]::LazyAggregations
    $mg.Type = [Microsoft.AnalysisServices.MeasureGroupType]::Sales

    $measure = $mg.Measures.Add("Total Vendido")
    $measure.AggregateFunction = [Microsoft.AnalysisServices.AggregationFunction]::Sum
    $measure.FormatString = "#,##0.00"
    $measure.Source = New-DataItem -Dsv $dsv -TableName "vw_Cubo_FactVentas" -ColumnName "TotalVendido"

    $measure = $mg.Measures.Add("Cantidad Vendida")
    $measure.AggregateFunction = [Microsoft.AnalysisServices.AggregationFunction]::Sum
    $measure.FormatString = "#,##0"
    $measure.Source = New-DataItem -Dsv $dsv -TableName "vw_Cubo_FactVentas" -ColumnName "CantidadVendida"

    $measure = $mg.Measures.Add("Descuento")
    $measure.AggregateFunction = [Microsoft.AnalysisServices.AggregationFunction]::Sum
    $measure.FormatString = "#,##0.00"
    $measure.Source = New-DataItem -Dsv $dsv -TableName "vw_Cubo_FactVentas" -ColumnName "Descuento"

    $measure = $mg.Measures.Add("Precio Unitario")
    $measure.AggregateFunction = [Microsoft.AnalysisServices.AggregationFunction]::Sum
    $measure.FormatString = "#,##0.00"
    $measure.Source = New-DataItem -Dsv $dsv -TableName "vw_Cubo_FactVentas" -ColumnName "PrecioUnitario"

    $measure = $mg.Measures.Add("Lineas de Venta")
    $measure.AggregateFunction = [Microsoft.AnalysisServices.AggregationFunction]::Count
    $measure.FormatString = "#,##0"
    $measure.Source = New-DataItem -Dsv $dsv -TableName "vw_Cubo_FactVentas" -ColumnName "VentaKey"

    Add-RegularMeasureGroupDimension -Cube $cube -MeasureGroup $mg -Dsv $dsv -DimensionName "Dim Producto" -GranularityAttributeName "Nombre Producto" -FactKeyColumn "ProductoKey"
    Add-RegularMeasureGroupDimension -Cube $cube -MeasureGroup $mg -Dsv $dsv -DimensionName "Dim Ciudad" -GranularityAttributeName "Nombre Ciudad" -FactKeyColumn "CiudadKey"
    Add-RegularMeasureGroupDimension -Cube $cube -MeasureGroup $mg -Dsv $dsv -DimensionName "Dim Cliente" -GranularityAttributeName "Nombre Cliente" -FactKeyColumn "ClienteKey"
    Add-RegularMeasureGroupDimension -Cube $cube -MeasureGroup $mg -Dsv $dsv -DimensionName "Dim Tiempo" -GranularityAttributeName "Fecha" -FactKeyColumn "TiempoKey"

    $partition = $mg.Partitions.Add("FactVentas")
    $partition.StorageMode = [Microsoft.AnalysisServices.StorageMode]::Molap
    $partition.Source = [Microsoft.AnalysisServices.QueryBinding]::new(
        $ds.ID,
        "SELECT VentaKey, ProductoKey, CiudadKey, ClienteKey, TiempoKey, IdFactura, IdDetalleFactura, CantidadVendida, PrecioUnitario, Descuento, TotalVendido FROM dbo.vw_Cubo_FactVentas"
    )

    $cube.Update([Microsoft.AnalysisServices.UpdateOptions]::ExpandFull)

    Write-Host "[6/7] Validando metadatos creados..." -ForegroundColor Yellow
    Write-Host "  Dimensiones: $($db.Dimensions.Count)"
    Write-Host "  Cubos:       $($db.Cubes.Count)"
    Write-Host "  Medidas:     $($cube.MeasureGroups['Ventas'].Measures.Count)"
    Write-Host "  Particiones: $($cube.MeasureGroups['Ventas'].Partitions.Count)"

    if (-not $SkipProcess) {
        Write-Host "[7/7] Procesando cubo..." -ForegroundColor Yellow
        $db.Process([Microsoft.AnalysisServices.ProcessType]::ProcessFull)
        Write-Host "  Procesamiento completado." -ForegroundColor Green
    }
    else {
        Write-Host "[7/7] Procesamiento omitido (-SkipProcess)." -ForegroundColor DarkYellow
    }

    Write-Host ""
    Write-Host "Cubo creado correctamente:" -ForegroundColor Green
    Write-Host "  Servidor: $AnalysisServer"
    Write-Host "  Base SSAS: $SsasDatabase"
    Write-Host "  Cubo: CuboVentasSalesIntel"
    Write-Host ""
    Write-Host "Siguiente paso: ejecutar Test-SalesIntelCube.ps1."
}
finally {
    if ($server.Connected) {
        $server.Disconnect()
    }
}
