/* 
================================================================================
PROYECTO: SalesIntel DW
SUBTÍTULO: Sistema de Inteligencia de Negocios para el Análisis de Ventas Nacionales
FASE 01: Creación de bases de datos, modelo transaccional y Data Warehouse
AUTOR: Jairo Matías
================================================================================

Este script crea dos bases de datos:

1. SalesIntel_OLTP
   Base transaccional simulada de ventas nacionales.

2. SalesIntel_DW
   Data Warehouse en esquema estrella para análisis BI.

Objetivo académico:
- Recrear desde cero el proyecto final viejo de Minería de Datos e Inteligencia de Negocios.
- Preparar la base para ETL, cubo de ventas, reportes y dashboard.
================================================================================
*/

USE master;
GO

/* ============================================================================
   1. CREACIÓN DE BASES DE DATOS
============================================================================ */

IF DB_ID('SalesIntel_OLTP') IS NOT NULL
BEGIN
    ALTER DATABASE SalesIntel_OLTP SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE SalesIntel_OLTP;
END;
GO

IF DB_ID('SalesIntel_DW') IS NOT NULL
BEGIN
    ALTER DATABASE SalesIntel_DW SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE SalesIntel_DW;
END;
GO

CREATE DATABASE SalesIntel_OLTP;
GO

CREATE DATABASE SalesIntel_DW;
GO

/* ============================================================================
   2. MODELO TRANSACCIONAL - SalesIntel_OLTP
============================================================================ */

USE SalesIntel_OLTP;
GO

CREATE TABLE dbo.Ciudad (
    IdCiudad INT IDENTITY(1,1) PRIMARY KEY,
    NombreCiudad VARCHAR(100) NOT NULL,
    Provincia VARCHAR(100) NULL,
    Region VARCHAR(50) NULL,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE()
);
GO

CREATE TABLE dbo.Producto (
    IdProducto INT PRIMARY KEY,
    NombreProducto VARCHAR(150) NOT NULL,
    Categoria VARCHAR(100) NULL,
    PrecioBase DECIMAL(18,2) NOT NULL,
    Estado BIT NOT NULL DEFAULT 1,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE()
);
GO

CREATE TABLE dbo.Cliente (
    IdCliente INT IDENTITY(1,1) PRIMARY KEY,
    NombreCliente VARCHAR(150) NOT NULL,
    TipoCliente VARCHAR(50) NULL,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE()
);
GO

CREATE TABLE dbo.Factura (
    IdFactura INT IDENTITY(1,1) PRIMARY KEY,
    NumeroFactura VARCHAR(30) NOT NULL UNIQUE,
    IdCliente INT NOT NULL,
    IdCiudad INT NOT NULL,
    FechaFactura DATE NOT NULL,
    Estado VARCHAR(30) NOT NULL DEFAULT 'Completada',

    CONSTRAINT FK_Factura_Cliente
        FOREIGN KEY (IdCliente) REFERENCES dbo.Cliente(IdCliente),

    CONSTRAINT FK_Factura_Ciudad
        FOREIGN KEY (IdCiudad) REFERENCES dbo.Ciudad(IdCiudad)
);
GO

CREATE TABLE dbo.DetFactura (
    IdDetalleFactura INT IDENTITY(1,1) PRIMARY KEY,
    IdFactura INT NOT NULL,
    IdProducto INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(18,2) NOT NULL,
    Descuento DECIMAL(18,2) NOT NULL DEFAULT 0,

    CONSTRAINT FK_DetFactura_Factura
        FOREIGN KEY (IdFactura) REFERENCES dbo.Factura(IdFactura),

    CONSTRAINT FK_DetFactura_Producto
        FOREIGN KEY (IdProducto) REFERENCES dbo.Producto(IdProducto),

    CONSTRAINT CK_DetFactura_Cantidad
        CHECK (Cantidad > 0),

    CONSTRAINT CK_DetFactura_PrecioUnitario
        CHECK (PrecioUnitario >= 0)
);
GO

/* ============================================================================
   3. DATA WAREHOUSE - SalesIntel_DW
============================================================================ */

USE SalesIntel_DW;
GO

CREATE TABLE dbo.DimProducto (
    ProductoKey INT IDENTITY(1,1) PRIMARY KEY,
    IdProducto INT NOT NULL,
    NombreProducto VARCHAR(150) NOT NULL,
    Categoria VARCHAR(100) NULL,
    PrecioBase DECIMAL(18,2) NULL,
    Estado BIT NOT NULL DEFAULT 1,
    FechaCarga DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT UQ_DimProducto_IdProducto UNIQUE (IdProducto)
);
GO

CREATE TABLE dbo.DimCiudad (
    CiudadKey INT IDENTITY(1,1) PRIMARY KEY,
    IdCiudad INT NOT NULL,
    NombreCiudad VARCHAR(100) NOT NULL,
    Provincia VARCHAR(100) NULL,
    Region VARCHAR(50) NULL,
    FechaCarga DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT UQ_DimCiudad_IdCiudad UNIQUE (IdCiudad)
);
GO

CREATE TABLE dbo.DimCliente (
    ClienteKey INT IDENTITY(1,1) PRIMARY KEY,
    IdCliente INT NOT NULL,
    NombreCliente VARCHAR(150) NOT NULL,
    TipoCliente VARCHAR(50) NULL,
    FechaCarga DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT UQ_DimCliente_IdCliente UNIQUE (IdCliente)
);
GO

CREATE TABLE dbo.DimTiempo (
    TiempoKey INT PRIMARY KEY,
    Fecha DATE NOT NULL,
    Dia TINYINT NOT NULL,
    Mes TINYINT NOT NULL,
    NombreMes VARCHAR(20) NOT NULL,
    Trimestre TINYINT NOT NULL,
    Anio SMALLINT NOT NULL,
    DiaSemana VARCHAR(20) NOT NULL
);
GO

CREATE TABLE dbo.FactVentas (
    VentaKey BIGINT IDENTITY(1,1) PRIMARY KEY,
    ProductoKey INT NOT NULL,
    CiudadKey INT NOT NULL,
    ClienteKey INT NOT NULL,
    TiempoKey INT NOT NULL,
    IdFactura INT NOT NULL,
    IdDetalleFactura INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(18,2) NOT NULL,
    Descuento DECIMAL(18,2) NOT NULL DEFAULT 0,
    TotalVenta AS ((Cantidad * PrecioUnitario) - Descuento) PERSISTED,
    FechaCarga DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_FactVentas_DimProducto
        FOREIGN KEY (ProductoKey) REFERENCES dbo.DimProducto(ProductoKey),

    CONSTRAINT FK_FactVentas_DimCiudad
        FOREIGN KEY (CiudadKey) REFERENCES dbo.DimCiudad(CiudadKey),

    CONSTRAINT FK_FactVentas_DimCliente
        FOREIGN KEY (ClienteKey) REFERENCES dbo.DimCliente(ClienteKey),

    CONSTRAINT FK_FactVentas_DimTiempo
        FOREIGN KEY (TiempoKey) REFERENCES dbo.DimTiempo(TiempoKey),

    CONSTRAINT UQ_FactVentas_IdDetalleFactura UNIQUE (IdDetalleFactura)
);
GO

/* ============================================================================
   4. TABLA STAGING PARA PRODUCTOS EXTERNOS
   Esta tabla simula la carga desde Productos.xlsx antes de insertar al DW.
============================================================================ */

CREATE TABLE dbo.StgProductosExcel (
    IdCarga INT IDENTITY(1,1) PRIMARY KEY,
    IdProducto INT NOT NULL,
    NombreProducto VARCHAR(150) NOT NULL,
    FechaCarga DATETIME NOT NULL DEFAULT GETDATE(),
    Procesado BIT NOT NULL DEFAULT 0,
    Observacion VARCHAR(250) NULL
);
GO

/* ============================================================================
   5. ÍNDICES RECOMENDADOS PARA CONSULTAS BI
============================================================================ */

CREATE INDEX IX_FactVentas_TiempoKey
ON dbo.FactVentas(TiempoKey);
GO

CREATE INDEX IX_FactVentas_ProductoKey
ON dbo.FactVentas(ProductoKey);
GO

CREATE INDEX IX_FactVentas_CiudadKey
ON dbo.FactVentas(CiudadKey);
GO

CREATE INDEX IX_DimTiempo_Anio_Mes
ON dbo.DimTiempo(Anio, Mes);
GO

/* ============================================================================
   6. VALIDACIÓN FINAL
============================================================================ */

SELECT 
    'SalesIntel_OLTP' AS BaseDatos,
    name AS Tabla
FROM SalesIntel_OLTP.sys.tables
UNION ALL
SELECT 
    'SalesIntel_DW' AS BaseDatos,
    name AS Tabla
FROM SalesIntel_DW.sys.tables
ORDER BY BaseDatos, Tabla;
GO
