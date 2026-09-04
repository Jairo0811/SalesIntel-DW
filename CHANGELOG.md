# Changelog

Todos los cambios relevantes de **SalesIntel DW** se documentan en este archivo.

El formato sigue una adaptación de Keep a Changelog y el proyecto utiliza versionado semántico para sus hitos de portafolio.

## [Unreleased]

### Added

- Validaciones automatizadas SQL para integridad dimensional, granularidad, objetos de reporting y KPIs del dataset.
- Documentación específica de reproducibilidad de SQL Server Analysis Services.
- Checklist de evidencias y cierre de portfolio hardening.

### Changed

- Documentación de instalación ampliada para incluir Power BI, pruebas SQL y capa SSAS.
- Documentación de evidencias alineada con los archivos realmente requeridos por el README.

### Fixed

- Inconsistencia documental sobre la cantidad de procedimientos almacenados: el proyecto contiene dos procedimientos de reporting.

## [1.0.0] - 2026-09-04

### Added

- Modelo OLTP `SalesIntel_OLTP`.
- Data Warehouse `SalesIntel_DW` con esquema estrella.
- Dimensiones de Producto, Ciudad, Cliente y Tiempo.
- Tabla de hechos `FactVentas`.
- Staging para validación de productos procedentes de Excel.
- Proceso ETL SQL.
- Vistas y procedimientos almacenados para reporting.
- Vistas dedicadas para SQL Server Analysis Services.
- Consultas MDX para navegación del cubo.
- Dashboard analítico en Microsoft Excel.
- Dashboard interactivo en Microsoft Power BI.
- Documentación de arquitectura, instalación y construcción del cubo.
- Identidad visual y documentación de portafolio.

### Context

Esta versión representa la reimplementación profesional realizada en 2026 a partir del alcance académico original desarrollado en ITLA durante el período 2017-C3 para la asignatura Minería de Datos e Inteligencia de Negocios (SOF-014).
