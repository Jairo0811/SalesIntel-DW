# SalesIntel DW
## Guía para crear el Cubo de Ventas en Visual Studio / SSDT

### Objetivo

Crear un cubo analítico de ventas basado en el Data Warehouse `SalesIntel_DW`.

El proyecto original pedía completar el DW, formar el cubo de ventas, hacer Browse de la data y luego graficar las ventas por ciudad y producto/año en Excel.

---

## 1. Requisito previo

Antes de crear el cubo, ejecuta estos scripts en SQL Server Management Studio:

1. `01_Crear_Modelo_SalesIntel_DW.sql`
2. `02_Insertar_Datos_Prueba_SalesIntel_DW.sql`
3. `03_ETL_Cargar_DW_SalesIntel.sql`
4. `04_Consultas_Reportes_SalesIntel.sql`
5. `05_Preparar_Cubo_SalesIntel.sql`

La base que se usará para el cubo es:

```text
SalesIntel_DW
```

---

## 2. Crear proyecto de Analysis Services

En Visual Studio / SQL Server Data Tools:

1. File / Archivo
2. New / Nuevo
3. Project / Proyecto
4. Buscar: **Analysis Services Multidimensional and Data Mining Project**
5. Nombre del proyecto:

```text
SalesIntel_DW_Cubo
```

6. Nombre de la solución:

```text
SalesIntel_DW
```

---

## 3. Crear Data Source

En el proyecto:

1. Clic derecho en **Data Sources**
2. New Data Source
3. Crear conexión hacia SQL Server
4. Seleccionar la base de datos:

```text
SalesIntel_DW
```

5. Nombre sugerido del Data Source:

```text
DS_SalesIntel_DW
```

---

## 4. Crear Data Source View

En el proyecto:

1. Clic derecho en **Data Source Views**
2. New Data Source View
3. Seleccionar `DS_SalesIntel_DW`
4. Agregar estas vistas:

```text
vw_Cubo_DimProducto
vw_Cubo_DimCiudad
vw_Cubo_DimCliente
vw_Cubo_DimTiempo
vw_Cubo_FactVentas
```

5. Nombre sugerido:

```text
DSV_SalesIntel_DW
```

---

## 5. Definir relaciones en el Data Source View

Asegúrate de que existan estas relaciones:

```text
vw_Cubo_FactVentas.ProductoKey  -> vw_Cubo_DimProducto.ProductoKey
vw_Cubo_FactVentas.CiudadKey    -> vw_Cubo_DimCiudad.CiudadKey
vw_Cubo_FactVentas.ClienteKey   -> vw_Cubo_DimCliente.ClienteKey
vw_Cubo_FactVentas.TiempoKey    -> vw_Cubo_DimTiempo.TiempoKey
```

---

## 6. Crear dimensiones

Crear estas dimensiones:

### DimProducto

Tabla origen:

```text
vw_Cubo_DimProducto
```

Key:

```text
ProductoKey
```

Atributos:

```text
IdProducto
NombreProducto
Categoria
EstadoProducto
PrecioBase
```

---

### DimCiudad

Tabla origen:

```text
vw_Cubo_DimCiudad
```

Key:

```text
CiudadKey
```

Atributos:

```text
NombreCiudad
Provincia
Region
```

Jerarquía sugerida:

```text
Region > Provincia > NombreCiudad
```

---

### DimCliente

Tabla origen:

```text
vw_Cubo_DimCliente
```

Key:

```text
ClienteKey
```

Atributos:

```text
NombreCliente
TipoCliente
```

Jerarquía sugerida:

```text
TipoCliente > NombreCliente
```

---

### DimTiempo

Tabla origen:

```text
vw_Cubo_DimTiempo
```

Key:

```text
TiempoKey
```

Atributos:

```text
Fecha
Anio
NombreTrimestre
NombreMes
Dia
DiaSemana
```

Jerarquía sugerida:

```text
Anio > NombreTrimestre > NombreMes > Dia
```

---

## 7. Crear cubo

1. Clic derecho en **Cubes**
2. New Cube
3. Use existing tables
4. Measure group table:

```text
vw_Cubo_FactVentas
```

5. Medidas recomendadas:

```text
CantidadVendida
Descuento
TotalVendido
PrecioUnitario
```

Configuración recomendada:

| Medida | Agregación recomendada |
|---|---|
| CantidadVendida | Sum |
| Descuento | Sum |
| TotalVendido | Sum |
| PrecioUnitario | Average |

Nombre del cubo:

```text
CuboVentasSalesIntel
```

---

## 8. Agregar dimensiones al cubo

Agregar:

```text
DimProducto
DimCiudad
DimCliente
DimTiempo
```

---

## 9. Deploy y Process

1. Clic derecho sobre el proyecto
2. Properties
3. Configurar servidor de Analysis Services
4. Clic derecho sobre el proyecto
5. Deploy
6. Clic derecho sobre el cubo
7. Process

---

## 10. Browse del cubo

En la pestaña **Browser**, probar:

### Ventas por ciudad

Filas:

```text
DimCiudad.NombreCiudad
```

Medida:

```text
TotalVendido
```

---

### Ventas por producto y año

Filas:

```text
DimProducto.NombreProducto
```

Columnas:

```text
DimTiempo.Anio
```

Medida:

```text
TotalVendido
```

---

### Ventas por ciudad y producto en los últimos meses

Filas:

```text
DimCiudad.NombreCiudad
DimProducto.NombreProducto
```

Medida:

```text
TotalVendido
CantidadVendida
```

Filtro:

```text
DimTiempo.Fecha
```

---

## 11. Consultas MDX de ejemplo

### Ventas por ciudad

```mdx
SELECT
    {[Measures].[Total Vendido]} ON COLUMNS,
    [Dim Ciudad].[Nombre Ciudad].Members ON ROWS
FROM [CuboVentasSalesIntel];
```

### Ventas por producto y año

```mdx
SELECT
    [Dim Tiempo].[Anio].Members ON COLUMNS,
    [Dim Producto].[Nombre Producto].Members ON ROWS
FROM [CuboVentasSalesIntel]
WHERE ([Measures].[Total Vendido]);
```

### Total vendido general

```mdx
SELECT
    {[Measures].[Total Vendido], [Measures].[Cantidad Vendida]} ON COLUMNS
FROM [CuboVentasSalesIntel];
```

---

## 12. Evidencias para entregar

Para documentar el proyecto, toma capturas de:

1. Tablas del Data Warehouse.
2. Vistas `vw_Cubo_*`.
3. Data Source del cubo.
4. Data Source View.
5. Dimensiones creadas.
6. Medidas del cubo.
7. Process exitoso.
8. Browse del cubo.
9. Gráfico de ventas por ciudad en Excel.
10. Gráfico de ventas por producto y año en Excel.
