# Fase Final — Portfolio Hardening

Esta fase cierra la evolución de **SalesIntel DW** como proyecto académico reimplementado y pieza de portafolio profesional de Business Intelligence.

## Objetivo

Dejar el repositorio:

- reproducible;
- verificable;
- visualmente demostrable;
- consistente en su documentación;
- preparado para ser presentado a reclutadores, clientes o equipos técnicos.

## Alcance completado en GitHub

- [x] Separación OLTP / Data Warehouse documentada.
- [x] ETL SQL versionado.
- [x] Capa de reporting versionada.
- [x] Vistas para SSAS versionadas.
- [x] Consultas MDX versionadas.
- [x] Dashboard Excel versionado.
- [x] Dashboard Power BI versionado.
- [x] Arquitectura documentada.
- [x] Setup documentado.
- [x] Validaciones automatizadas SQL con `THROW`.
- [x] Changelog añadido.
- [x] Documentación específica de reproducibilidad SSAS.
- [x] Estado del proyecto definido como finalizado / portfolio.

## Validaciones automatizadas

Ejecutar al final del flujo:

```text
database/06_tests/06_Validaciones_Portfolio.sql
```

Las validaciones comprueban:

- hechos sin dimensión relacionada;
- duplicados en claves de negocio dimensionales;
- duplicados en la granularidad de `FactVentas`;
- KPIs esperados del dataset de demostración;
- presencia de vistas y procedimientos de reporting;
- presencia de las vistas requeridas por el cubo SSAS.

## KPIs de referencia

| Métrica | Valor esperado |
|---|---:|
| Cantidad vendida | 183 |
| Total vendido | 222,995.00 |
| Descuento total | 3,150.00 |
| Facturas | 22 |

Si el seed cambia intencionalmente, deben actualizarse conjuntamente el test de KPIs y la documentación.

## Evidencias visuales pendientes de captura local

Las capturas no pueden generarse desde GitHub porque requieren ejecutar SQL Server, Visual Studio/SSDT, SSAS, Excel y Power BI Desktop en un entorno local.

Agregar en `assets/screenshots/` al menos:

```text
01_tablas_creadas_sql_server.png
03_etl_carga_dw.png
06_modelo_estrella_dsv.png
08_cubo_procesado_correctamente.png
09_browse_ventas_por_ciudad.png
10_browse_producto_por_anio.png
11_dashboard_excel.png
12_dashboard_powerbi.png
```

No debe afirmarse que una evidencia está publicada hasta que el archivo exista realmente en el repositorio.

## Proyecto SSAS generado por SSDT

Los artefactos SQL, MDX y las instrucciones de construcción están versionados. Los archivos generados por SSDT (`.dwproj`, `.ds`, `.dsv`, `.dim`, `.cube`) deben exportarse desde el proyecto real una vez validado localmente.

No se agregan archivos XML escritos manualmente para evitar presentar como ejecutable una definición no validada por Visual Studio/SSDT.

Consultar:

```text
analysis-services/README.md
docs/Guia_Crear_Cubo_SalesIntel_DW.md
docs/Setup.md
```

## Criterio de cierre

SalesIntel DW se considera **funcionalmente finalizado** cuando:

1. los scripts 01 a 06 ejecutan correctamente;
2. el cubo SSAS procesa sin errores;
3. las consultas MDX devuelven resultados válidos;
4. Excel y Power BI refrescan correctamente;
5. las evidencias mínimas están publicadas.

Tras cumplir esos cinco puntos, el repositorio debe mantenerse en modo de mantenimiento y no evolucionar hacia un SaaS genérico salvo que aparezca un caso de negocio concreto.

## Posicionamiento recomendado

**Tipo:** Business Intelligence / Data Warehouse Portfolio Project  
**Estado:** Finalizado  
**Origen:** Proyecto académico ITLA 2017-C3, reimplementado en 2026  
**Uso comercial recomendado:** demostrador técnico para servicios personalizados de BI, integración de datos y Power BI.
