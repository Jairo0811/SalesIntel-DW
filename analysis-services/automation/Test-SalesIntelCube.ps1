param(
    [string]$AnalysisServer = "localhost\SSAS2022",
    [string]$SsasDatabase = "SalesIntel_DW_Cubo"
)

$ErrorActionPreference = "Stop"

function Import-Adomd {
    try {
        Add-Type -AssemblyName "Microsoft.AnalysisServices.AdomdClient" -ErrorAction Stop
        return
    }
    catch {
        $roots = @(
            "$env:ProgramFiles\Microsoft SQL Server",
            "$env:ProgramFiles(x86)\Microsoft SQL Server",
            "$env:ProgramFiles\Microsoft SQL Server Management Studio 20",
            "$env:ProgramFiles(x86)\Microsoft SQL Server Management Studio 20"
        ) | Where-Object { $_ -and (Test-Path $_) }

        foreach ($root in $roots) {
            $candidate = Get-ChildItem -Path $root -Filter "Microsoft.AnalysisServices.AdomdClient.dll" -File -Recurse -ErrorAction SilentlyContinue |
                Select-Object -First 1

            if ($candidate) {
                Add-Type -Path $candidate.FullName
                return
            }
        }

        throw "No se pudo cargar Microsoft.AnalysisServices.AdomdClient.dll. Verifica la instalación de SSMS."
    }
}

Import-Adomd

$expected = [ordered]@{
    "Total Vendido"    = 222995.00
    "Cantidad Vendida" = 183
    "Descuento"        = 3150.00
}

$connectionString = "Data Source=$AnalysisServer;Initial Catalog=$SsasDatabase;Integrated Security=SSPI"
$conn = [Microsoft.AnalysisServices.AdomdClient.AdomdConnection]::new($connectionString)

Write-Host "== SalesIntel DW / SSAS Smoke Test ==" -ForegroundColor Cyan
Write-Host "Servidor: $AnalysisServer"
Write-Host "Base SSAS: $SsasDatabase"
Write-Host ""

$conn.Open()
try {
    $cmd = $conn.CreateCommand()
    $cmd.CommandText = @"
SELECT
{
    [Measures].[Total Vendido],
    [Measures].[Cantidad Vendida],
    [Measures].[Descuento]
} ON COLUMNS
FROM [CuboVentasSalesIntel]
"@

    $reader = $cmd.ExecuteReader()
    try {
        if (-not $reader.Read()) {
            throw "La consulta MDX no devolvió filas."
        }

        $actual = [ordered]@{
            "Total Vendido"    = [decimal]$reader.GetValue(0)
            "Cantidad Vendida" = [decimal]$reader.GetValue(1)
            "Descuento"        = [decimal]$reader.GetValue(2)
        }

        $failed = $false
        foreach ($key in $expected.Keys) {
            $ok = [decimal]$actual[$key] -eq [decimal]$expected[$key]
            $status = if ($ok) { "OK" } else { "FAIL" }
            Write-Host ("{0,-20} esperado={1,12} actual={2,12} [{3}]" -f $key, $expected[$key], $actual[$key], $status)
            if (-not $ok) { $failed = $true }
        }

        if ($failed) {
            throw "El cubo respondió, pero uno o más KPIs no coinciden con el dataset de referencia."
        }
    }
    finally {
        $reader.Close()
    }

    $cmd = $conn.CreateCommand()
    $cmd.CommandText = @"
SELECT
    {[Measures].[Total Vendido]} ON COLUMNS,
    NON EMPTY [Dim Ciudad].[Nombre Ciudad].[Nombre Ciudad].Members ON ROWS
FROM [CuboVentasSalesIntel]
"@

    $cellSet = $cmd.ExecuteCellSet()
    if ($cellSet.Axes.Count -lt 2 -or $cellSet.Axes[1].Set.Tuples.Count -eq 0) {
        throw "La prueba de navegación por ciudad no devolvió miembros."
    }

    Write-Host ""
    Write-Host "Navegación por ciudad: OK ($($cellSet.Axes[1].Set.Tuples.Count) miembros)" -ForegroundColor Green
    Write-Host "Smoke test SSAS completado correctamente." -ForegroundColor Green
}
finally {
    $conn.Close()
}
