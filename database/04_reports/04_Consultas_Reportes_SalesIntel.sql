/*
================================================================================
PROYECTO: SalesIntel DW
FASE 04: Consultas, vistas y procedimientos para reportes BI
AUTOR: Jairo Matías

Objetivo:
- Crear consultas finales para cumplir los puntos del proyecto original.
- Crear vistas reutilizables para SSRS, Excel, Power BI o consultas directas.
- Crear procedimientos almacenados para reportes con parámetros.
- Preparar la salida para gráficos de ventas por ciudad y producto por año.

Requisitos previos:
1. Ejecutar 01_Crear_Modelo_SalesIntel_DW.sql
2. Ejecutar 02_Insertar_Datos_Prueba_SalesIntel_DW.sql
3. Ejecutar 03_ETL_Cargar_DW_SalesIntel.sql
================================================================================
*/

SET NOCOUNT ON;
GO

USE SalesIntel_DW;
GO

/* ============================================================================
   1. ELIMINAR OBJETOS SI EXISTEN
============================================================================ */

IF OBJECT_ID('dbo.vw_VentasDetalleDW', 'V') IS NOT NULL
    DROP VIEW dbo.vw_VentasDetalleDW;
GO

IF OBJECT_ID('dbo.vw_VentasPorCiudad', 'V') IS NOT NULL
    DROP VIEW dbo.vw_VentasPorCiudad;
GO

IF OBJECT_ID('dbo.vw_VentasProductoAnio', 'V') IS NOT NULL
    DROP VIEW dbo.vw_VentasProductoAnio;
GO

IF OBJECT_ID('dbo.vw_VentasUltimos3MesesProductoCiudad', 'V') IS NOT NULL
    DROP VIEW dbo.vw_VentasUltimos3MesesProductoCiudad;
GO

IF OBJECT_ID('dbo.sp_ReporteVentasUltimos3MesesProductoCiudad', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ReporteVentasUltimos3MesesProductoCiudad;
GO

IF OBJECT_ID('dbo.sp_ReporteVentasPorRangoFecha', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ReporteVentasPorRangoFecha;
GO

/* ============================================================================
   2. VISTA BASE: DETALLE GENERAL DEL DATA WAREHOUSE
============================================================================ */

CREATE VIEW dbo.vw_VentasDetalleDW
AS
SELECT
    fv.VentaKey,
    fv.IdFactura,
    fv.IdDetalleFactura,

    dt.TiempoKey,
    dt.Fecha,
    dt.Dia,
    dt.Mes,
    dt.NombreMes,
    dt.Trimestre,
    dt.Anio,
    dt.DiaSemana,

    dc.CiudadKey,
    dc.IdCiudad,
    dc.NombreCiudad,
    dc.Provincia,
    dc.Region,

    dp.ProductoKey,
    dp.IdProducto,
    dp.NombreProducto,
    dp.Categoria,

    dcl.ClienteKey,
    dcl.IdCliente,
    dcl.NombreCliente,
    dcl.TipoCliente,

    fv.Cantidad,
    fv.PrecioUnitario,
    fv.Descuento,
    fv.TotalVenta,
    fv.FechaCarga
FROM dbo.FactVentas fv
INNER JOIN dbo.DimTiempo dt
    ON dt.TiempoKey = fv.TiempoKey
INNER JOIN dbo.DimCiudad dc
    ON dc.CiudadKey = fv.CiudadKey
INNER JOIN dbo.DimProducto dp
    ON dp.ProductoKey = fv.ProductoKey
INNER JOIN dbo.DimCliente dcl
    ON dcl.ClienteKey = fv.ClienteKey;
GO

/* ============================================================================
   3. VISTA: TOTAL VENDIDO POR PRODUCTO EN LOS ÚLTIMOS 3 MESES POR CIUDAD
============================================================================ */

CREATE VIEW dbo.vw_VentasUltimos3MesesProductoCiudad
AS
SELECT
    NombreCiudad,
    NombreProducto,
    SUM(Cantidad) AS CantidadVendida,
    SUM(TotalVenta) AS TotalVendido
FROM dbo.vw_VentasDetalleDW
WHERE Fecha >= DATEADD(MONTH, -3, CAST(GETDATE() AS DATE))
GROUP BY
    NombreCiudad,
    NombreProducto;
GO

/* ============================================================================
   4. VISTA: VENTAS POR CIUDAD
============================================================================ */

CREATE VIEW dbo.vw_VentasPorCiudad
AS
SELECT
    NombreCiudad,
    Provincia,
    Region,
    SUM(Cantidad) AS CantidadVendida,
    SUM(TotalVenta) AS TotalVendido
FROM dbo.vw_VentasDetalleDW
GROUP BY
    NombreCiudad,
    Provincia,
    Region;
GO

/* ============================================================================
   5. VISTA: VENTAS DE CADA PRODUCTO POR AÑO
============================================================================ */

CREATE VIEW dbo.vw_VentasProductoAnio
AS
SELECT
    Anio,
    IdProducto,
    NombreProducto,
    Categoria,
    SUM(Cantidad) AS CantidadVendida,
    SUM(TotalVenta) AS TotalVendido
FROM dbo.vw_VentasDetalleDW
GROUP BY
    Anio,
    IdProducto,
    NombreProducto,
    Categoria;
GO

/* ============================================================================
   6. PROCEDIMIENTO: REPORTE CON TOTALES POR CIUDAD Y TOTAL GENERAL

   Cumple:
   "Crea un reporte que muestre el total vendido de cada producto en los tres
    últimos meses, por ciudad. Incluya sus respectivos totales."

   Niveles:
   - DETALLE: Ciudad + Producto
   - TOTAL CIUDAD: subtotal de cada ciudad
   - TOTAL GENERAL: total completo del reporte
============================================================================ */

CREATE PROCEDURE dbo.sp_ReporteVentasUltimos3MesesProductoCiudad
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        CASE
            WHEN GROUPING(NombreCiudad) = 1 THEN 'TOTAL GENERAL'
            ELSE NombreCiudad
        END AS Ciudad,

        CASE
            WHEN GROUPING(NombreCiudad) = 1 THEN 'TODOS LOS PRODUCTOS'
            WHEN GROUPING(NombreProducto) = 1 THEN 'TOTAL CIUDAD'
            ELSE NombreProducto
        END AS Producto,

        SUM(Cantidad) AS CantidadVendida,
        SUM(TotalVenta) AS TotalVendido,

        CASE
            WHEN GROUPING(NombreCiudad) = 1 THEN 3
            WHEN GROUPING(NombreProducto) = 1 THEN 2
            ELSE 1
        END AS NivelReporte
    FROM dbo.vw_VentasDetalleDW
    WHERE Fecha >= DATEADD(MONTH, -3, CAST(GETDATE() AS DATE))
    GROUP BY ROLLUP(NombreCiudad, NombreProducto)
    ORDER BY
        GROUPING(NombreCiudad),
        NombreCiudad,
        GROUPING(NombreProducto),
        NombreProducto;
END;
GO

/* ============================================================================
   7. PROCEDIMIENTO: REPORTE DE VENTAS POR RANGO DE FECHA

   Este procedimiento sirve para SSRS o Power BI con parámetros.
============================================================================ */

CREATE PROCEDURE dbo.sp_ReporteVentasPorRangoFecha
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Fecha,
        Anio,
        NombreMes,
        NombreCiudad,
        NombreProducto,
        NombreCliente,
        Cantidad,
        PrecioUnitario,
        Descuento,
        TotalVenta
    FROM dbo.vw_VentasDetalleDW
    WHERE Fecha BETWEEN @FechaInicio AND @FechaFin
    ORDER BY
        Fecha,
        NombreCiudad,
        NombreProducto;
END;
GO

/* ============================================================================
   8. CONSULTAS FINALES PARA EJECUTAR Y COPIAR A EXCEL / SSRS / POWER BI
============================================================================ */

PRINT '1. Reporte principal: productos vendidos en los últimos 3 meses por ciudad con totales';
EXEC dbo.sp_ReporteVentasUltimos3MesesProductoCiudad;
GO

PRINT '2. Gráfico: ventas por ciudad';
SELECT
    NombreCiudad,
    TotalVendido
FROM dbo.vw_VentasPorCiudad
ORDER BY TotalVendido DESC;
GO

PRINT '3. Gráfico: ventas de cada producto por año';
SELECT
    Anio,
    NombreProducto,
    TotalVendido
FROM dbo.vw_VentasProductoAnio
ORDER BY
    Anio,
    NombreProducto;
GO

PRINT '4. Reporte parametrizado de ejemplo';
EXEC dbo.sp_ReporteVentasPorRangoFecha
    @FechaInicio = '2024-01-01',
    @FechaFin = '2026-12-31';
GO

/* ============================================================================
   9. VALIDACIÓN DE OBJETOS CREADOS
============================================================================ */

SELECT
    'Vista' AS TipoObjeto,
    name AS NombreObjeto
FROM sys.views
WHERE name IN (
    'vw_VentasDetalleDW',
    'vw_VentasPorCiudad',
    'vw_VentasProductoAnio',
    'vw_VentasUltimos3MesesProductoCiudad'
)
UNION ALL
SELECT
    'Procedimiento',
    name
FROM sys.procedures
WHERE name IN (
    'sp_ReporteVentasUltimos3MesesProductoCiudad',
    'sp_ReporteVentasPorRangoFecha'
)
ORDER BY
    TipoObjeto,
    NombreObjeto;
GO
