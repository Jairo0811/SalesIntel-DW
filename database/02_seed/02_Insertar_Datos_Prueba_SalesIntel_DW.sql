/*
================================================================================
PROYECTO: SalesIntel DW
FASE 02: Inserción de datos de prueba
AUTOR: Jairo Matías

Objetivo:
- Poblar la base transaccional SalesIntel_OLTP.
- Poblar la dimensión de tiempo SalesIntel_DW.dbo.DimTiempo.
- Dejar datos suficientes para reportes por ciudad, producto, mes y año.

Requisito previo:
- Ejecutar primero: 01_Crear_Modelo_SalesIntel_DW.sql
================================================================================
*/

SET NOCOUNT ON;
GO

/* ============================================================================
   1. LIMPIEZA DE DATOS TRANSACCIONALES
============================================================================ */

USE SalesIntel_OLTP;
GO

DELETE FROM dbo.DetFactura;
DELETE FROM dbo.Factura;
DELETE FROM dbo.Cliente;
DELETE FROM dbo.Producto;
DELETE FROM dbo.Ciudad;
GO

DBCC CHECKIDENT ('dbo.DetFactura', RESEED, 0);
DBCC CHECKIDENT ('dbo.Factura', RESEED, 0);
DBCC CHECKIDENT ('dbo.Cliente', RESEED, 0);
DBCC CHECKIDENT ('dbo.Ciudad', RESEED, 0);
GO

/* ============================================================================
   2. CIUDADES
============================================================================ */

INSERT INTO dbo.Ciudad (NombreCiudad, Provincia, Region)
VALUES
('Santo Domingo', 'Santo Domingo', 'Ozama'),
('Santiago', 'Santiago', 'Cibao Norte'),
('La Romana', 'La Romana', 'Yuma'),
('San Pedro de Macorís', 'San Pedro de Macorís', 'Higuamo'),
('Puerto Plata', 'Puerto Plata', 'Cibao Norte'),
('San Francisco de Macorís', 'Duarte', 'Cibao Nordeste'),
('Barahona', 'Barahona', 'Enriquillo'),
('Higüey', 'La Altagracia', 'Yuma');
GO

/* ============================================================================
   3. PRODUCTOS
   Nota:
   Se usan códigos similares al archivo Productos.xlsx original:
   1, 2, 3, 4 y 100.
============================================================================ */

INSERT INTO dbo.Producto (IdProducto, NombreProducto, Categoria, PrecioBase)
VALUES
(1, 'PRODUCTO 1', 'Tecnología', 1250.00),
(2, 'PRODUCTO 2', 'Oficina', 875.00),
(3, 'PRODUCTO 3', 'Hogar', 650.00),
(4, 'PRODUCTO 4', 'Electrónica', 2100.00),
(100, 'PRODUCTO 100', 'Especial', 3500.00),
(101, 'PRODUCTO 101', 'Tecnología', 1850.00),
(102, 'PRODUCTO 102', 'Oficina', 975.00),
(103, 'PRODUCTO 103', 'Hogar', 720.00);
GO

/* ============================================================================
   4. CLIENTES
============================================================================ */

INSERT INTO dbo.Cliente (NombreCliente, TipoCliente)
VALUES
('Cliente Corporativo Norte', 'Corporativo'),
('Cliente Corporativo Sur', 'Corporativo'),
('Distribuidora Capital', 'Distribuidor'),
('Comercial del Este', 'Distribuidor'),
('Cliente Minorista 001', 'Minorista'),
('Cliente Minorista 002', 'Minorista'),
('Cliente Gobierno 001', 'Institucional'),
('Cliente Gobierno 002', 'Institucional');
GO

/* ============================================================================
   5. FACTURAS
   Se generan fechas relativas a GETDATE() para que siempre existan ventas
   en los últimos 3 meses al momento de ejecutar el script.
============================================================================ */

CREATE TABLE #FacturasTmp (
    NumeroFactura VARCHAR(30) NOT NULL,
    NombreCliente VARCHAR(150) NOT NULL,
    NombreCiudad VARCHAR(100) NOT NULL,
    FechaFactura DATE NOT NULL
);

INSERT INTO #FacturasTmp (NumeroFactura, NombreCliente, NombreCiudad, FechaFactura)
VALUES
('F-2024-0001', 'Cliente Corporativo Norte', 'Santo Domingo', DATEFROMPARTS(2024, 1, 15)),
('F-2024-0002', 'Distribuidora Capital', 'Santiago', DATEFROMPARTS(2024, 2, 20)),
('F-2024-0003', 'Comercial del Este', 'La Romana', DATEFROMPARTS(2024, 3, 12)),
('F-2024-0004', 'Cliente Minorista 001', 'Puerto Plata', DATEFROMPARTS(2024, 6, 5)),
('F-2024-0005', 'Cliente Gobierno 001', 'San Pedro de Macorís', DATEFROMPARTS(2024, 9, 18)),
('F-2024-0006', 'Cliente Corporativo Sur', 'Barahona', DATEFROMPARTS(2024, 12, 7)),

('F-2025-0001', 'Cliente Corporativo Norte', 'Santo Domingo', DATEFROMPARTS(2025, 1, 10)),
('F-2025-0002', 'Distribuidora Capital', 'Santiago', DATEFROMPARTS(2025, 2, 14)),
('F-2025-0003', 'Comercial del Este', 'Higüey', DATEFROMPARTS(2025, 4, 22)),
('F-2025-0004', 'Cliente Minorista 002', 'San Francisco de Macorís', DATEFROMPARTS(2025, 6, 30)),
('F-2025-0005', 'Cliente Gobierno 002', 'Puerto Plata', DATEFROMPARTS(2025, 8, 16)),
('F-2025-0006', 'Cliente Corporativo Sur', 'La Romana', DATEFROMPARTS(2025, 10, 9)),
('F-2025-0007', 'Cliente Minorista 001', 'Santo Domingo', DATEFROMPARTS(2025, 11, 28)),
('F-2025-0008', 'Cliente Gobierno 001', 'Santiago', DATEFROMPARTS(2025, 12, 19)),

('F-ACT-0001', 'Cliente Corporativo Norte', 'Santo Domingo', CAST(DATEADD(DAY, -12, GETDATE()) AS DATE)),
('F-ACT-0002', 'Distribuidora Capital', 'Santiago', CAST(DATEADD(DAY, -24, GETDATE()) AS DATE)),
('F-ACT-0003', 'Comercial del Este', 'La Romana', CAST(DATEADD(DAY, -35, GETDATE()) AS DATE)),
('F-ACT-0004', 'Cliente Minorista 001', 'Puerto Plata', CAST(DATEADD(DAY, -48, GETDATE()) AS DATE)),
('F-ACT-0005', 'Cliente Gobierno 001', 'San Pedro de Macorís', CAST(DATEADD(DAY, -60, GETDATE()) AS DATE)),
('F-ACT-0006', 'Cliente Corporativo Sur', 'Barahona', CAST(DATEADD(DAY, -72, GETDATE()) AS DATE)),
('F-ACT-0007', 'Cliente Minorista 002', 'Higüey', CAST(DATEADD(DAY, -83, GETDATE()) AS DATE)),
('F-ACT-0008', 'Cliente Gobierno 002', 'San Francisco de Macorís', CAST(DATEADD(DAY, -91, GETDATE()) AS DATE));

INSERT INTO dbo.Factura (NumeroFactura, IdCliente, IdCiudad, FechaFactura)
SELECT
    f.NumeroFactura,
    c.IdCliente,
    ci.IdCiudad,
    f.FechaFactura
FROM #FacturasTmp f
INNER JOIN dbo.Cliente c
    ON c.NombreCliente = f.NombreCliente
INNER JOIN dbo.Ciudad ci
    ON ci.NombreCiudad = f.NombreCiudad;

DROP TABLE #FacturasTmp;
GO

/* ============================================================================
   6. DETALLE DE FACTURAS
============================================================================ */

CREATE TABLE #DetalleTmp (
    NumeroFactura VARCHAR(30) NOT NULL,
    IdProducto INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(18,2) NOT NULL,
    Descuento DECIMAL(18,2) NOT NULL
);

INSERT INTO #DetalleTmp (NumeroFactura, IdProducto, Cantidad, PrecioUnitario, Descuento)
VALUES
('F-2024-0001', 1, 4, 1250.00, 0),
('F-2024-0001', 2, 2, 875.00, 0),
('F-2024-0002', 3, 5, 650.00, 100),
('F-2024-0002', 4, 1, 2100.00, 0),
('F-2024-0003', 100, 2, 3500.00, 250),
('F-2024-0003', 1, 3, 1250.00, 0),
('F-2024-0004', 2, 6, 875.00, 150),
('F-2024-0004', 101, 2, 1850.00, 0),
('F-2024-0005', 102, 4, 975.00, 0),
('F-2024-0005', 4, 2, 2100.00, 200),
('F-2024-0006', 103, 3, 720.00, 0),
('F-2024-0006', 100, 1, 3500.00, 0),

('F-2025-0001', 1, 6, 1250.00, 0),
('F-2025-0001', 4, 2, 2100.00, 0),
('F-2025-0002', 2, 8, 875.00, 300),
('F-2025-0002', 3, 5, 650.00, 0),
('F-2025-0003', 100, 3, 3500.00, 500),
('F-2025-0003', 101, 4, 1850.00, 100),
('F-2025-0004', 102, 7, 975.00, 0),
('F-2025-0004', 103, 4, 720.00, 0),
('F-2025-0005', 4, 5, 2100.00, 350),
('F-2025-0005', 1, 2, 1250.00, 0),
('F-2025-0006', 2, 10, 875.00, 250),
('F-2025-0006', 100, 1, 3500.00, 0),
('F-2025-0007', 3, 9, 650.00, 0),
('F-2025-0007', 101, 2, 1850.00, 0),
('F-2025-0008', 102, 6, 975.00, 100),
('F-2025-0008', 4, 3, 2100.00, 0),

('F-ACT-0001', 1, 5, 1250.00, 0),
('F-ACT-0001', 100, 2, 3500.00, 300),
('F-ACT-0002', 2, 7, 875.00, 0),
('F-ACT-0002', 4, 2, 2100.00, 100),
('F-ACT-0003', 3, 6, 650.00, 0),
('F-ACT-0003', 101, 3, 1850.00, 0),
('F-ACT-0004', 102, 8, 975.00, 200),
('F-ACT-0004', 103, 5, 720.00, 0),
('F-ACT-0005', 1, 4, 1250.00, 0),
('F-ACT-0005', 4, 3, 2100.00, 150),
('F-ACT-0006', 100, 2, 3500.00, 0),
('F-ACT-0006', 2, 5, 875.00, 0),
('F-ACT-0007', 3, 7, 650.00, 100),
('F-ACT-0007', 101, 2, 1850.00, 0),
('F-ACT-0008', 102, 6, 975.00, 0),
('F-ACT-0008', 103, 4, 720.00, 0);

INSERT INTO dbo.DetFactura (IdFactura, IdProducto, Cantidad, PrecioUnitario, Descuento)
SELECT
    f.IdFactura,
    d.IdProducto,
    d.Cantidad,
    d.PrecioUnitario,
    d.Descuento
FROM #DetalleTmp d
INNER JOIN dbo.Factura f
    ON f.NumeroFactura = d.NumeroFactura
INNER JOIN dbo.Producto p
    ON p.IdProducto = d.IdProducto;

DROP TABLE #DetalleTmp;
GO

/* ============================================================================
   7. DIMENSIÓN DE TIEMPO EN EL DW
============================================================================ */

USE SalesIntel_DW;
GO

DELETE FROM dbo.FactVentas;
DELETE FROM dbo.DimTiempo;
GO

DECLARE @FechaInicio DATE = '2024-01-01';
DECLARE @FechaFin DATE = CAST(DATEADD(YEAR, 1, GETDATE()) AS DATE);

;WITH Fechas AS (
    SELECT @FechaInicio AS Fecha
    UNION ALL
    SELECT DATEADD(DAY, 1, Fecha)
    FROM Fechas
    WHERE Fecha < @FechaFin
)
INSERT INTO dbo.DimTiempo (
    TiempoKey,
    Fecha,
    Dia,
    Mes,
    NombreMes,
    Trimestre,
    Anio,
    DiaSemana
)
SELECT
    CONVERT(INT, FORMAT(Fecha, 'yyyyMMdd')) AS TiempoKey,
    Fecha,
    DAY(Fecha) AS Dia,
    MONTH(Fecha) AS Mes,
    CASE MONTH(Fecha)
        WHEN 1 THEN 'Enero'
        WHEN 2 THEN 'Febrero'
        WHEN 3 THEN 'Marzo'
        WHEN 4 THEN 'Abril'
        WHEN 5 THEN 'Mayo'
        WHEN 6 THEN 'Junio'
        WHEN 7 THEN 'Julio'
        WHEN 8 THEN 'Agosto'
        WHEN 9 THEN 'Septiembre'
        WHEN 10 THEN 'Octubre'
        WHEN 11 THEN 'Noviembre'
        WHEN 12 THEN 'Diciembre'
    END AS NombreMes,
    DATEPART(QUARTER, Fecha) AS Trimestre,
    YEAR(Fecha) AS Anio,
    CASE DATEPART(WEEKDAY, Fecha)
        WHEN 1 THEN 'Domingo'
        WHEN 2 THEN 'Lunes'
        WHEN 3 THEN 'Martes'
        WHEN 4 THEN 'Miércoles'
        WHEN 5 THEN 'Jueves'
        WHEN 6 THEN 'Viernes'
        WHEN 7 THEN 'Sábado'
    END AS DiaSemana
FROM Fechas
OPTION (MAXRECURSION 0);
GO

/* ============================================================================
   8. VALIDACIONES
============================================================================ */

USE SalesIntel_OLTP;
GO

SELECT 'Ciudades' AS Entidad, COUNT(*) AS Total FROM dbo.Ciudad
UNION ALL
SELECT 'Productos', COUNT(*) FROM dbo.Producto
UNION ALL
SELECT 'Clientes', COUNT(*) FROM dbo.Cliente
UNION ALL
SELECT 'Facturas', COUNT(*) FROM dbo.Factura
UNION ALL
SELECT 'Detalle Facturas', COUNT(*) FROM dbo.DetFactura;
GO

USE SalesIntel_DW;
GO

SELECT 'DimTiempo' AS Entidad, COUNT(*) AS Total FROM dbo.DimTiempo;
GO

SELECT TOP 10
    f.NumeroFactura,
    f.FechaFactura,
    ci.NombreCiudad,
    c.NombreCliente,
    p.NombreProducto,
    df.Cantidad,
    df.PrecioUnitario,
    df.Descuento,
    (df.Cantidad * df.PrecioUnitario) - df.Descuento AS TotalLinea
FROM SalesIntel_OLTP.dbo.DetFactura df
INNER JOIN SalesIntel_OLTP.dbo.Factura f
    ON f.IdFactura = df.IdFactura
INNER JOIN SalesIntel_OLTP.dbo.Ciudad ci
    ON ci.IdCiudad = f.IdCiudad
INNER JOIN SalesIntel_OLTP.dbo.Cliente c
    ON c.IdCliente = f.IdCliente
INNER JOIN SalesIntel_OLTP.dbo.Producto p
    ON p.IdProducto = df.IdProducto
ORDER BY f.FechaFactura DESC, f.NumeroFactura;
GO
