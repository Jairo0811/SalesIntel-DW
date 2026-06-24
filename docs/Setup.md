# Guía rápida de instalación

## 1. Crear bases de datos

Ejecutar en SQL Server Management Studio:

```text
database/01_model/01_Crear_Modelo_SalesIntel_DW.sql
database/02_seed/02_Insertar_Datos_Prueba_SalesIntel_DW.sql
database/03_etl/03_ETL_Cargar_DW_SalesIntel.sql
database/04_reports/04_Consultas_Reportes_SalesIntel.sql
database/05_cube/05_Preparar_Cubo_SalesIntel.sql
```

## 2. Crear cubo en Visual Studio

Crear proyecto:

```text
Proyecto multidimensional de Analysis Services
```

Nombre:

```text
SalesIntel_DW_Cubo
```

Origen de datos:

```text
SalesIntel_DW
```

Vistas incluidas:

```text
vw_Cubo_DimProducto
vw_Cubo_DimCiudad
vw_Cubo_DimCliente
vw_Cubo_DimTiempo
vw_Cubo_FactVentas
```

## 3. Relaciones del DSV

```text
vw_Cubo_FactVentas.ProductoKey → vw_Cubo_DimProducto.ProductoKey
vw_Cubo_FactVentas.CiudadKey   → vw_Cubo_DimCiudad.CiudadKey
vw_Cubo_FactVentas.ClienteKey  → vw_Cubo_DimCliente.ClienteKey
vw_Cubo_FactVentas.TiempoKey   → vw_Cubo_DimTiempo.TiempoKey
```

## 4. Cubo

Nombre:

```text
CuboVentasSalesIntel
```

Servidor de implementación:

```text
localhost
```

o:

```text
localhost\SSAS2022
```

## 5. Dashboard

Abrir:

```text
excel/SalesIntel_DW_Dashboard_Excel.xlsx
```
