/*
================================================================================
PROYECTO: SalesIntel DW
FASE 05: Preparación del modelo para Cubo de Ventas / SSAS
AUTOR: Jairo Matías

Objetivo:
- Crear vistas limpias para usarlas como origen del cubo en SQL Server Analysis Services.
- Separar dimensiones y tabla de hechos.
- Crear consultas de validación para verificar medidas y relaciones.

Requisitos previos:
1. Ejecutar 01_Crear_Modelo_SalesIntel_DW.sql
2. Ejecutar 02_Insertar_Datos_Prueba_SalesIntel_DW.sql
3. Ejecutar 03_ETL_Cargar_DW_SalesIntel.sql
4. Ejecutar 04_Consultas_Reportes_SalesIntel.sql

Uso:
Estas vistas se pueden usar en Visual Studio / SSDT para crear el Data Source View
del cubo de ventas.
================================================================================
*/

SET NOCOUNT ON;
GO

USE SalesIntel_DW;
GO

/* ============================================================================
   1. ELIMINAR VISTAS DEL MODELO ANALÍTICO SI EXISTEN
============================================================================ */

IF OBJECT_ID('dbo.vw_Cubo_DimProducto', 'V') IS NOT NULL
    DROP VIEW dbo.vw_Cubo_DimProducto;
GO

IF OBJECT_ID('dbo.vw_Cubo_DimCiudad', 'V') IS NOT NULL
    DROP VIEW dbo.vw_Cubo_DimCiudad;
GO

IF OBJECT_ID('dbo.vw_Cubo_DimCliente', 'V') IS NOT NULL
    DROP VIEW dbo.vw_Cubo_DimCliente;
GO

IF OBJECT_ID('dbo.vw_Cubo_DimTiempo', 'V') IS NOT NULL
    DROP VIEW dbo.vw_Cubo_DimTiempo;
GO

IF OBJECT_ID('dbo.vw_Cubo_FactVentas', 'V') IS NOT NULL
    DROP VIEW dbo.vw_Cubo_FactVentas;
GO

/* ============================================================================
   2. DIMENSIÓN PRODUCTO
============================================================================ */

CREATE VIEW dbo.vw_Cubo_DimProducto
AS
SELECT
    ProductoKey,
    IdProducto,
    NombreProducto,
    Categoria,
    PrecioBase,
    CASE 
        WHEN Estado = 1 THEN 'Activo'
        ELSE 'Inactivo'
    END AS EstadoProducto
FROM dbo.DimProducto;
GO

/* ============================================================================
   3. DIMENSIÓN CIUDAD
============================================================================ */

CREATE VIEW dbo.vw_Cubo_DimCiudad
AS
SELECT
    CiudadKey,
    IdCiudad,
    NombreCiudad,
    Provincia,
    Region
FROM dbo.DimCiudad;
GO

/* ============================================================================
   4. DIMENSIÓN CLIENTE
============================================================================ */

CREATE VIEW dbo.vw_Cubo_DimCliente
AS
SELECT
    ClienteKey,
    IdCliente,
    NombreCliente,
    TipoCliente
FROM dbo.DimCliente;
GO

/* ============================================================================
   5. DIMENSIÓN TIEMPO
   Incluye campos para jerarquías: Año > Trimestre > Mes > Día
============================================================================ */

CREATE VIEW dbo.vw_Cubo_DimTiempo
AS
SELECT
    TiempoKey,
    Fecha,
    Anio,
    Trimestre,
    CONCAT('T', Trimestre) AS NombreTrimestre,
    Mes,
    NombreMes,
    Dia,
    DiaSemana
FROM dbo.DimTiempo;
GO

/* ============================================================================
   6. TABLA DE HECHOS PARA CUBO
   Medidas principales:
   - CantidadVendida
   - PrecioUnitario
   - Descuento
   - TotalVendido
============================================================================ */

CREATE VIEW dbo.vw_Cubo_FactVentas
AS
SELECT
    VentaKey,
    ProductoKey,
    CiudadKey,
    ClienteKey,
    TiempoKey,
    IdFactura,
    IdDetalleFactura,
    Cantidad AS CantidadVendida,
    PrecioUnitario,
    Descuento,
    TotalVenta AS TotalVendido
FROM dbo.FactVentas;
GO

/* ============================================================================
   7. VALIDACIÓN DE RELACIONES DEL MODELO ESTRELLA
============================================================================ */

PRINT 'Validación de registros por vista del cubo';

SELECT 'vw_Cubo_DimProducto' AS Vista, COUNT(*) AS TotalRegistros FROM dbo.vw_Cubo_DimProducto
UNION ALL
SELECT 'vw_Cubo_DimCiudad', COUNT(*) FROM dbo.vw_Cubo_DimCiudad
UNION ALL
SELECT 'vw_Cubo_DimCliente', COUNT(*) FROM dbo.vw_Cubo_DimCliente
UNION ALL
SELECT 'vw_Cubo_DimTiempo', COUNT(*) FROM dbo.vw_Cubo_DimTiempo
UNION ALL
SELECT 'vw_Cubo_FactVentas', COUNT(*) FROM dbo.vw_Cubo_FactVentas;
GO

/* ============================================================================
   8. VALIDACIÓN DE INTEGRIDAD ENTRE HECHOS Y DIMENSIONES
============================================================================ */

PRINT 'Validación de hechos sin dimensión relacionada';

SELECT
    SUM(CASE WHEN dp.ProductoKey IS NULL THEN 1 ELSE 0 END) AS VentasSinProducto,
    SUM(CASE WHEN dc.CiudadKey IS NULL THEN 1 ELSE 0 END) AS VentasSinCiudad,
    SUM(CASE WHEN dcl.ClienteKey IS NULL THEN 1 ELSE 0 END) AS VentasSinCliente,
    SUM(CASE WHEN dt.TiempoKey IS NULL THEN 1 ELSE 0 END) AS VentasSinTiempo
FROM dbo.vw_Cubo_FactVentas fv
LEFT JOIN dbo.vw_Cubo_DimProducto dp
    ON dp.ProductoKey = fv.ProductoKey
LEFT JOIN dbo.vw_Cubo_DimCiudad dc
    ON dc.CiudadKey = fv.CiudadKey
LEFT JOIN dbo.vw_Cubo_DimCliente dcl
    ON dcl.ClienteKey = fv.ClienteKey
LEFT JOIN dbo.vw_Cubo_DimTiempo dt
    ON dt.TiempoKey = fv.TiempoKey;
GO

/* ============================================================================
   9. MEDIDAS PRINCIPALES DEL CUBO
============================================================================ */

PRINT 'Medidas principales del cubo';

SELECT
    SUM(CantidadVendida) AS CantidadVendida,
    SUM(Descuento) AS DescuentoTotal,
    SUM(TotalVendido) AS TotalVendido,
    AVG(PrecioUnitario) AS PrecioUnitarioPromedio,
    COUNT(DISTINCT IdFactura) AS FacturasProcesadas,
    COUNT(*) AS LineasDeVenta
FROM dbo.vw_Cubo_FactVentas;
GO

/* ============================================================================
   10. CONSULTA TIPO CUBO: VENTAS POR AÑO, CIUDAD Y PRODUCTO
============================================================================ */

PRINT 'Consulta tipo cubo: Año > Ciudad > Producto';

SELECT
    dt.Anio,
    dc.NombreCiudad,
    dp.NombreProducto,
    SUM(fv.CantidadVendida) AS CantidadVendida,
    SUM(fv.TotalVendido) AS TotalVendido
FROM dbo.vw_Cubo_FactVentas fv
INNER JOIN dbo.vw_Cubo_DimTiempo dt
    ON dt.TiempoKey = fv.TiempoKey
INNER JOIN dbo.vw_Cubo_DimCiudad dc
    ON dc.CiudadKey = fv.CiudadKey
INNER JOIN dbo.vw_Cubo_DimProducto dp
    ON dp.ProductoKey = fv.ProductoKey
GROUP BY
    dt.Anio,
    dc.NombreCiudad,
    dp.NombreProducto
ORDER BY
    dt.Anio,
    dc.NombreCiudad,
    dp.NombreProducto;
GO

/* ============================================================================
   11. CONSULTA TIPO CUBO: JERARQUÍA DE TIEMPO
============================================================================ */

PRINT 'Consulta tipo cubo: Año > Trimestre > Mes';

SELECT
    dt.Anio,
    dt.NombreTrimestre,
    dt.Mes,
    dt.NombreMes,
    SUM(fv.CantidadVendida) AS CantidadVendida,
    SUM(fv.TotalVendido) AS TotalVendido
FROM dbo.vw_Cubo_FactVentas fv
INNER JOIN dbo.vw_Cubo_DimTiempo dt
    ON dt.TiempoKey = fv.TiempoKey
GROUP BY
    dt.Anio,
    dt.NombreTrimestre,
    dt.Mes,
    dt.NombreMes
ORDER BY
    dt.Anio,
    dt.Mes;
GO

/* ============================================================================
   12. LISTADO DE VISTAS CREADAS
============================================================================ */

SELECT
    name AS VistaCreada
FROM sys.views
WHERE name LIKE 'vw_Cubo_%'
ORDER BY name;
GO
