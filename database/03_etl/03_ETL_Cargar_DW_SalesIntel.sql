/*
================================================================================
PROYECTO: SalesIntel DW
FASE 03: Proceso ETL para cargar el Data Warehouse
AUTOR: Jairo Matías

Objetivo:
- Limpiar el Data Warehouse.
- Cargar dimensiones desde SalesIntel_OLTP.
- Simular la carga de productos desde el archivo Productos.xlsx.
- Validar productos existentes antes de insertarlos al DW.
- Cargar la tabla de hechos FactVentas.
- Dejar consultas de validación para comprobar el resultado.

Requisitos previos:
1. Ejecutar 01_Crear_Modelo_SalesIntel_DW.sql
2. Ejecutar 02_Insertar_Datos_Prueba_SalesIntel_DW.sql
================================================================================
*/

SET NOCOUNT ON;
GO

/* ============================================================================
   1. LIMPIEZA DEL DATA WAREHOUSE
============================================================================ */

USE SalesIntel_DW;
GO

DELETE FROM dbo.FactVentas;
DELETE FROM dbo.StgProductosExcel;
DELETE FROM dbo.DimCliente;
DELETE FROM dbo.DimCiudad;
DELETE FROM dbo.DimProducto;
GO

DBCC CHECKIDENT ('dbo.FactVentas', RESEED, 0);
DBCC CHECKIDENT ('dbo.StgProductosExcel', RESEED, 0);
DBCC CHECKIDENT ('dbo.DimCliente', RESEED, 0);
DBCC CHECKIDENT ('dbo.DimCiudad', RESEED, 0);
DBCC CHECKIDENT ('dbo.DimProducto', RESEED, 0);
GO

/* ============================================================================
   2. CARGA DE DIMENSIONES DESDE LA BASE TRANSACCIONAL
============================================================================ */

INSERT INTO dbo.DimCiudad (
    IdCiudad,
    NombreCiudad,
    Provincia,
    Region
)
SELECT
    c.IdCiudad,
    c.NombreCiudad,
    c.Provincia,
    c.Region
FROM SalesIntel_OLTP.dbo.Ciudad c;
GO

INSERT INTO dbo.DimCliente (
    IdCliente,
    NombreCliente,
    TipoCliente
)
SELECT
    c.IdCliente,
    c.NombreCliente,
    c.TipoCliente
FROM SalesIntel_OLTP.dbo.Cliente c;
GO

INSERT INTO dbo.DimProducto (
    IdProducto,
    NombreProducto,
    Categoria,
    PrecioBase,
    Estado
)
SELECT
    p.IdProducto,
    p.NombreProducto,
    p.Categoria,
    p.PrecioBase,
    p.Estado
FROM SalesIntel_OLTP.dbo.Producto p;
GO

/* ============================================================================
   3. SIMULACIÓN DE CARGA DESDE Productos.xlsx

   Archivo original:
   IdProducto | Nombre
   1          | PRODUCTO 1
   2          | PRODUCTO 2
   4          | PRODUCTO 4
   3          | PRODUCTO 3
   100        | PRODUCTO 100
   4          | PRODUCTO 4

   Nota:
   En un SSIS real, esta sección sería reemplazada por:
   Excel Source -> Lookup contra DimProducto -> Conditional Split -> OLE DB Destination
============================================================================ */

INSERT INTO dbo.StgProductosExcel (
    IdProducto,
    NombreProducto
)
VALUES
(1, 'PRODUCTO 1'),
(2, 'PRODUCTO 2'),
(4, 'PRODUCTO 4'),
(3, 'PRODUCTO 3'),
(100, 'PRODUCTO 100'),
(4, 'PRODUCTO 4');
GO

/* ============================================================================
   4. VALIDACIÓN DE PRODUCTOS EXISTENTES EN EL DW

   Regla:
   - Si el producto ya existe en DimProducto, no se inserta.
   - Si el producto aparece duplicado en el Excel, se marca como duplicado.
   - Si el producto no existe en DimProducto, se inserta como producto externo.
============================================================================ */

;WITH ProductosStaging AS (
    SELECT
        IdCarga,
        IdProducto,
        NombreProducto,
        ROW_NUMBER() OVER (
            PARTITION BY IdProducto
            ORDER BY IdCarga
        ) AS NumeroFilaProducto
    FROM dbo.StgProductosExcel
)
UPDATE stg
SET
    Procesado = 1,
    Observacion =
        CASE
            WHEN ps.NumeroFilaProducto > 1 THEN 'Producto duplicado en archivo Excel. No insertado.'
            WHEN dp.IdProducto IS NOT NULL THEN 'Producto ya existe en DimProducto. No insertado.'
            ELSE 'Producto nuevo pendiente de inserción.'
        END
FROM dbo.StgProductosExcel stg
INNER JOIN ProductosStaging ps
    ON ps.IdCarga = stg.IdCarga
LEFT JOIN dbo.DimProducto dp
    ON dp.IdProducto = stg.IdProducto;
GO

INSERT INTO dbo.DimProducto (
    IdProducto,
    NombreProducto,
    Categoria,
    PrecioBase,
    Estado
)
SELECT
    stg.IdProducto,
    stg.NombreProducto,
    'Producto Externo' AS Categoria,
    0.00 AS PrecioBase,
    1 AS Estado
FROM dbo.StgProductosExcel stg
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.DimProducto dp
    WHERE dp.IdProducto = stg.IdProducto
)
AND stg.IdCarga IN (
    SELECT MIN(IdCarga)
    FROM dbo.StgProductosExcel
    GROUP BY IdProducto
);
GO

UPDATE stg
SET Observacion = 'Producto nuevo insertado en DimProducto.'
FROM dbo.StgProductosExcel stg
WHERE EXISTS (
    SELECT 1
    FROM dbo.DimProducto dp
    WHERE dp.IdProducto = stg.IdProducto
)
AND stg.Observacion = 'Producto nuevo pendiente de inserción.';
GO

/* ============================================================================
   5. CARGA DE LA TABLA DE HECHOS
============================================================================ */

INSERT INTO dbo.FactVentas (
    ProductoKey,
    CiudadKey,
    ClienteKey,
    TiempoKey,
    IdFactura,
    IdDetalleFactura,
    Cantidad,
    PrecioUnitario,
    Descuento
)
SELECT
    dp.ProductoKey,
    dc.CiudadKey,
    dcl.ClienteKey,
    dt.TiempoKey,
    f.IdFactura,
    df.IdDetalleFactura,
    df.Cantidad,
    df.PrecioUnitario,
    df.Descuento
FROM SalesIntel_OLTP.dbo.DetFactura df
INNER JOIN SalesIntel_OLTP.dbo.Factura f
    ON f.IdFactura = df.IdFactura
INNER JOIN SalesIntel_OLTP.dbo.Producto p
    ON p.IdProducto = df.IdProducto
INNER JOIN SalesIntel_OLTP.dbo.Ciudad c
    ON c.IdCiudad = f.IdCiudad
INNER JOIN SalesIntel_OLTP.dbo.Cliente cl
    ON cl.IdCliente = f.IdCliente
INNER JOIN dbo.DimProducto dp
    ON dp.IdProducto = p.IdProducto
INNER JOIN dbo.DimCiudad dc
    ON dc.IdCiudad = c.IdCiudad
INNER JOIN dbo.DimCliente dcl
    ON dcl.IdCliente = cl.IdCliente
INNER JOIN dbo.DimTiempo dt
    ON dt.Fecha = f.FechaFactura
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.FactVentas fv
    WHERE fv.IdDetalleFactura = df.IdDetalleFactura
);
GO

/* ============================================================================
   6. VALIDACIONES GENERALES DEL ETL
============================================================================ */

SELECT 'DimProducto' AS Tabla, COUNT(*) AS Total FROM dbo.DimProducto
UNION ALL
SELECT 'DimCiudad', COUNT(*) FROM dbo.DimCiudad
UNION ALL
SELECT 'DimCliente', COUNT(*) FROM dbo.DimCliente
UNION ALL
SELECT 'DimTiempo', COUNT(*) FROM dbo.DimTiempo
UNION ALL
SELECT 'FactVentas', COUNT(*) FROM dbo.FactVentas
UNION ALL
SELECT 'StgProductosExcel', COUNT(*) FROM dbo.StgProductosExcel;
GO

SELECT
    IdCarga,
    IdProducto,
    NombreProducto,
    Procesado,
    Observacion,
    FechaCarga
FROM dbo.StgProductosExcel
ORDER BY IdCarga;
GO

/* ============================================================================
   7. CONSULTA BASE DEL DW PARA VALIDAR VENTAS
============================================================================ */

SELECT TOP 20
    dt.Fecha,
    dt.Anio,
    dt.NombreMes,
    dc.NombreCiudad,
    dcl.NombreCliente,
    dp.NombreProducto,
    fv.Cantidad,
    fv.PrecioUnitario,
    fv.Descuento,
    fv.TotalVenta
FROM dbo.FactVentas fv
INNER JOIN dbo.DimTiempo dt
    ON dt.TiempoKey = fv.TiempoKey
INNER JOIN dbo.DimCiudad dc
    ON dc.CiudadKey = fv.CiudadKey
INNER JOIN dbo.DimCliente dcl
    ON dcl.ClienteKey = fv.ClienteKey
INNER JOIN dbo.DimProducto dp
    ON dp.ProductoKey = fv.ProductoKey
ORDER BY dt.Fecha DESC, dc.NombreCiudad, dp.NombreProducto;
GO

/* ============================================================================
   8. CONSULTA SOLICITADA: TOTAL VENDIDO POR PRODUCTO EN LOS ÚLTIMOS 3 MESES,
      AGRUPADO POR CIUDAD
============================================================================ */

SELECT
    dc.NombreCiudad,
    dp.NombreProducto,
    SUM(fv.Cantidad) AS CantidadVendida,
    SUM(fv.TotalVenta) AS TotalVendido
FROM dbo.FactVentas fv
INNER JOIN dbo.DimTiempo dt
    ON dt.TiempoKey = fv.TiempoKey
INNER JOIN dbo.DimCiudad dc
    ON dc.CiudadKey = fv.CiudadKey
INNER JOIN dbo.DimProducto dp
    ON dp.ProductoKey = fv.ProductoKey
WHERE dt.Fecha >= DATEADD(MONTH, -3, CAST(GETDATE() AS DATE))
GROUP BY
    dc.NombreCiudad,
    dp.NombreProducto
ORDER BY
    dc.NombreCiudad,
    dp.NombreProducto;
GO

/* ============================================================================
   9. CONSULTA PARA GRÁFICO: VENTAS POR CIUDAD
============================================================================ */

SELECT
    dc.NombreCiudad,
    SUM(fv.TotalVenta) AS TotalVendido
FROM dbo.FactVentas fv
INNER JOIN dbo.DimCiudad dc
    ON dc.CiudadKey = fv.CiudadKey
GROUP BY
    dc.NombreCiudad
ORDER BY
    TotalVendido DESC;
GO

/* ============================================================================
   10. CONSULTA PARA GRÁFICO: VENTAS DE CADA PRODUCTO POR AÑO
============================================================================ */

SELECT
    dt.Anio,
    dp.NombreProducto,
    SUM(fv.TotalVenta) AS TotalVendido
FROM dbo.FactVentas fv
INNER JOIN dbo.DimTiempo dt
    ON dt.TiempoKey = fv.TiempoKey
INNER JOIN dbo.DimProducto dp
    ON dp.ProductoKey = fv.ProductoKey
GROUP BY
    dt.Anio,
    dp.NombreProducto
ORDER BY
    dt.Anio,
    dp.NombreProducto;
GO
