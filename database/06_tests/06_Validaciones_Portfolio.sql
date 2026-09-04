/*
================================================================================
PROYECTO: SalesIntel DW
FASE 06: Validaciones automatizadas para portfolio hardening
AUTOR: Jairo Matías

Objetivo:
- Verificar integridad referencial del modelo estrella.
- Verificar unicidad de claves de negocio cargadas al DW.
- Verificar KPIs estables del dataset de demostración.
- Fallar explícitamente con THROW cuando una validación no se cumple.

Requisitos previos:
1. Ejecutar 01_Crear_Modelo_SalesIntel_DW.sql
2. Ejecutar 02_Insertar_Datos_Prueba_SalesIntel_DW.sql
3. Ejecutar 03_ETL_Cargar_DW_SalesIntel.sql
4. Ejecutar 04_Consultas_Reportes_SalesIntel.sql
5. Ejecutar 05_Preparar_Cubo_SalesIntel.sql
================================================================================
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

USE SalesIntel_DW;
GO

PRINT 'SalesIntel DW - inicio de validaciones automatizadas';
GO

/* ============================================================================
   TEST 01 - HECHOS SIN DIMENSION RELACIONADA
============================================================================ */

IF EXISTS (
    SELECT 1
    FROM dbo.FactVentas fv
    LEFT JOIN dbo.DimProducto dp ON dp.ProductoKey = fv.ProductoKey
    LEFT JOIN dbo.DimCiudad dc ON dc.CiudadKey = fv.CiudadKey
    LEFT JOIN dbo.DimCliente dcl ON dcl.ClienteKey = fv.ClienteKey
    LEFT JOIN dbo.DimTiempo dt ON dt.TiempoKey = fv.TiempoKey
    WHERE dp.ProductoKey IS NULL
       OR dc.CiudadKey IS NULL
       OR dcl.ClienteKey IS NULL
       OR dt.TiempoKey IS NULL
)
    THROW 51001, 'TEST 01 FALLIDO: existen hechos sin dimension relacionada.', 1;

PRINT 'OK TEST 01 - integridad dimensional';
GO

/* ============================================================================
   TEST 02 - CLAVES DE NEGOCIO DUPLICADAS EN DIMENSIONES
============================================================================ */

IF EXISTS (
    SELECT IdProducto
    FROM dbo.DimProducto
    GROUP BY IdProducto
    HAVING COUNT(*) > 1
)
    THROW 51002, 'TEST 02 FALLIDO: IdProducto duplicado en DimProducto.', 1;

IF EXISTS (
    SELECT IdCiudad
    FROM dbo.DimCiudad
    GROUP BY IdCiudad
    HAVING COUNT(*) > 1
)
    THROW 51003, 'TEST 02 FALLIDO: IdCiudad duplicado en DimCiudad.', 1;

IF EXISTS (
    SELECT IdCliente
    FROM dbo.DimCliente
    GROUP BY IdCliente
    HAVING COUNT(*) > 1
)
    THROW 51004, 'TEST 02 FALLIDO: IdCliente duplicado en DimCliente.', 1;

IF EXISTS (
    SELECT Fecha
    FROM dbo.DimTiempo
    GROUP BY Fecha
    HAVING COUNT(*) > 1
)
    THROW 51005, 'TEST 02 FALLIDO: Fecha duplicada en DimTiempo.', 1;

PRINT 'OK TEST 02 - unicidad de claves de negocio';
GO

/* ============================================================================
   TEST 03 - DETALLES DE FACTURA DUPLICADOS EN LA TABLA DE HECHOS
============================================================================ */

IF EXISTS (
    SELECT IdDetalleFactura
    FROM dbo.FactVentas
    GROUP BY IdDetalleFactura
    HAVING COUNT(*) > 1
)
    THROW 51006, 'TEST 03 FALLIDO: IdDetalleFactura duplicado en FactVentas.', 1;

PRINT 'OK TEST 03 - granularidad de FactVentas';
GO

/* ============================================================================
   TEST 04 - KPIs ESTABLES DEL DATASET DE DEMOSTRACION

   Estos valores proceden del seed versionado. Si el dataset cambia de forma
   intencional, actualizar conjuntamente estas expectativas y la documentacion.
============================================================================ */

DECLARE @CantidadVendida INT;
DECLARE @TotalVendido DECIMAL(18,2);
DECLARE @DescuentoTotal DECIMAL(18,2);
DECLARE @TotalFacturas INT;

SELECT
    @CantidadVendida = SUM(Cantidad),
    @TotalVendido = SUM(TotalVenta),
    @DescuentoTotal = SUM(Descuento),
    @TotalFacturas = COUNT(DISTINCT IdFactura)
FROM dbo.FactVentas;

IF @CantidadVendida <> 183
    THROW 51007, 'TEST 04 FALLIDO: CantidadVendida esperada = 183.', 1;

IF @TotalVendido <> CAST(222995.00 AS DECIMAL(18,2))
    THROW 51008, 'TEST 04 FALLIDO: TotalVendido esperado = 222995.00.', 1;

IF @DescuentoTotal <> CAST(3150.00 AS DECIMAL(18,2))
    THROW 51009, 'TEST 04 FALLIDO: DescuentoTotal esperado = 3150.00.', 1;

IF @TotalFacturas <> 22
    THROW 51010, 'TEST 04 FALLIDO: TotalFacturas esperado = 22.', 1;

PRINT 'OK TEST 04 - KPIs del dataset';
GO

/* ============================================================================
   TEST 05 - VISTAS Y PROCEDIMIENTOS REQUERIDOS
============================================================================ */

IF OBJECT_ID('dbo.vw_VentasDetalleDW', 'V') IS NULL
    THROW 51011, 'TEST 05 FALLIDO: falta vw_VentasDetalleDW.', 1;

IF OBJECT_ID('dbo.vw_VentasPorCiudad', 'V') IS NULL
    THROW 51012, 'TEST 05 FALLIDO: falta vw_VentasPorCiudad.', 1;

IF OBJECT_ID('dbo.vw_VentasProductoAnio', 'V') IS NULL
    THROW 51013, 'TEST 05 FALLIDO: falta vw_VentasProductoAnio.', 1;

IF OBJECT_ID('dbo.vw_VentasUltimos3MesesProductoCiudad', 'V') IS NULL
    THROW 51014, 'TEST 05 FALLIDO: falta vw_VentasUltimos3MesesProductoCiudad.', 1;

IF OBJECT_ID('dbo.sp_ReporteVentasUltimos3MesesProductoCiudad', 'P') IS NULL
    THROW 51015, 'TEST 05 FALLIDO: falta sp_ReporteVentasUltimos3MesesProductoCiudad.', 1;

IF OBJECT_ID('dbo.sp_ReporteVentasPorRangoFecha', 'P') IS NULL
    THROW 51016, 'TEST 05 FALLIDO: falta sp_ReporteVentasPorRangoFecha.', 1;

PRINT 'OK TEST 05 - objetos de reporting';
GO

/* ============================================================================
   TEST 06 - VISTAS REQUERIDAS PARA EL CUBO
============================================================================ */

IF OBJECT_ID('dbo.vw_Cubo_DimProducto', 'V') IS NULL
    THROW 51017, 'TEST 06 FALLIDO: falta vw_Cubo_DimProducto.', 1;

IF OBJECT_ID('dbo.vw_Cubo_DimCiudad', 'V') IS NULL
    THROW 51018, 'TEST 06 FALLIDO: falta vw_Cubo_DimCiudad.', 1;

IF OBJECT_ID('dbo.vw_Cubo_DimCliente', 'V') IS NULL
    THROW 51019, 'TEST 06 FALLIDO: falta vw_Cubo_DimCliente.', 1;

IF OBJECT_ID('dbo.vw_Cubo_DimTiempo', 'V') IS NULL
    THROW 51020, 'TEST 06 FALLIDO: falta vw_Cubo_DimTiempo.', 1;

IF OBJECT_ID('dbo.vw_Cubo_FactVentas', 'V') IS NULL
    THROW 51021, 'TEST 06 FALLIDO: falta vw_Cubo_FactVentas.', 1;

PRINT 'OK TEST 06 - capa semantica para SSAS';
GO

PRINT '============================================================';
PRINT 'TODAS LAS VALIDACIONES DE SALESINTEL DW FINALIZARON EN VERDE';
PRINT '============================================================';
GO
