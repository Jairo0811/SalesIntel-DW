# Evidencias de SalesIntel DW

Las evidencias visuales deben demostrar que el flujo completo funciona en un entorno local con SQL Server, SSAS, Excel y Power BI.

Guardar las capturas en:

```text
assets/screenshots/
```

## Capturas recomendadas

1. `01_tablas_creadas_sql_server.png`
2. `02_datos_prueba_cargados.png`
3. `03_etl_carga_dw.png`
4. `04_validacion_productos_excel.png`
5. `05_vistas_cubo_creadas.png`
6. `06_modelo_estrella_dsv.png`
7. `07_cubo_creado_visual_studio.png`
8. `08_cubo_procesado_correctamente.png`
9. `09_browse_ventas_por_ciudad.png`
10. `10_browse_producto_por_anio.png`
11. `11_dashboard_excel.png`
12. `12_dashboard_powerbi.png`
13. `13_tests_sql_verde.png`

## Evidencias mínimas para GitHub

Para considerar completa la presentación visual del proyecto, publicar al menos:

```text
06_modelo_estrella_dsv.png
08_cubo_procesado_correctamente.png
09_browse_ventas_por_ciudad.png
10_browse_producto_por_anio.png
11_dashboard_excel.png
12_dashboard_powerbi.png
13_tests_sql_verde.png
```

## Qué debe mostrar cada evidencia mínima

### `06_modelo_estrella_dsv.png`

El Data Source View de SSAS mostrando claramente `FactVentas` conectada con las dimensiones Producto, Ciudad, Cliente y Tiempo.

### `08_cubo_procesado_correctamente.png`

El resultado del procesamiento del cubo `CuboVentasSalesIntel` sin errores.

### `09_browse_ventas_por_ciudad.png`

Exploración del cubo con la medida de ventas segmentada por Ciudad.

### `10_browse_producto_por_anio.png`

Exploración multidimensional por Producto y Año.

### `11_dashboard_excel.png`

Dashboard de Excel con KPIs y gráficos visibles.

### `12_dashboard_powerbi.png`

Dashboard de Power BI con los KPIs principales y visualizaciones ejecutivas.

### `13_tests_sql_verde.png`

Salida de `database/06_tests/06_Validaciones_Portfolio.sql` mostrando:

```text
TODAS LAS VALIDACIONES DE SALESINTEL DW FINALIZARON EN VERDE
```

## Regla de publicación

No referenciar una captura como evidencia disponible desde el README si el archivo todavía no existe en `assets/screenshots/`.

Actualmente las capturas deben generarse localmente; GitHub no sustituye la validación visual de SQL Server Management Studio, Visual Studio/SSDT, SSAS, Excel o Power BI Desktop.
