# Guía rápida de instalación

## Requisitos

- Microsoft SQL Server 2022.
- SQL Server Management Studio.
- Visual Studio con SQL Server Data Tools / Analysis Services Projects.
- SQL Server Analysis Services en modo multidimensional.
- Microsoft Excel.
- Microsoft Power BI Desktop.

## 1. Crear bases de datos y Data Warehouse

Ejecutar en SQL Server Management Studio, en este orden:

```text
database/01_model/01_Crear_Modelo_SalesIntel_DW.sql
database/02_seed/02_Insertar_Datos_Prueba_SalesIntel_DW.sql
database/03_etl/03_ETL_Cargar_DW_SalesIntel.sql
database/04_reports/04_Consultas_Reportes_SalesIntel.sql
database/05_cube/05_Preparar_Cubo_SalesIntel.sql
```

Al finalizar deben existir:

- `SalesIntel_OLTP`;
- `SalesIntel_DW`;
- dimensiones y `FactVentas`;
- vistas de reporting;
- dos procedimientos almacenados de reporting;
- vistas `vw_Cubo_*` para Analysis Services.

## 2. Ejecutar validaciones automatizadas

Ejecutar:

```text
database/06_tests/06_Validaciones_Portfolio.sql
```

El script utiliza `THROW` para detener la ejecución si detecta:

- hechos huérfanos;
- claves de negocio duplicadas;
- granularidad duplicada en `FactVentas`;
- KPIs distintos a los esperados del seed;
- objetos de reporting ausentes;
- vistas requeridas por SSAS ausentes.

Resultado esperado al final:

```text
TODAS LAS VALIDACIONES DE SALESINTEL DW FINALIZARON EN VERDE
```

## 3. Crear cubo en Visual Studio

Crear un proyecto:

```text
Proyecto multidimensional de Analysis Services
```

Nombre recomendado:

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

## 4. Relaciones del Data Source View

```text
vw_Cubo_FactVentas.ProductoKey → vw_Cubo_DimProducto.ProductoKey
vw_Cubo_FactVentas.CiudadKey   → vw_Cubo_DimCiudad.CiudadKey
vw_Cubo_FactVentas.ClienteKey  → vw_Cubo_DimCliente.ClienteKey
vw_Cubo_FactVentas.TiempoKey   → vw_Cubo_DimTiempo.TiempoKey
```

## 5. Procesar el cubo

Nombre:

```text
CuboVentasSalesIntel
```

Servidor de implementación típico:

```text
localhost
```

o:

```text
localhost\SSAS2022
```

Procesar el cubo y comprobar las medidas y dimensiones desde la pestaña **Browser**.

La guía detallada está en:

```text
docs/Guia_Crear_Cubo_SalesIntel_DW.md
```

## 6. Ejecutar consultas MDX

Archivo:

```text
analysis-services/mdx/06_Consultas_MDX_Cubo_SalesIntel.mdx
```

Validar, como mínimo:

- total general de ventas;
- ventas por ciudad;
- ventas por producto;
- ventas por año;
- top de ciudades y productos;
- cruce ciudad × producto.

## 7. Dashboard de Excel

Abrir:

```text
excel/SalesIntel_DW_Dashboard_Excel.xlsx
```

Actualizar sus conexiones o tablas dinámicas según la configuración local.

## 8. Dashboard de Power BI

Abrir:

```text
power-bi/SalesIntelDW.pbix
```

Configurar la conexión local a `SalesIntel_DW` y actualizar los datos.

Las vistas principales utilizadas por Power BI son:

```text
vw_VentasDetalleDW
vw_VentasPorCiudad
vw_VentasProductoAnio
vw_VentasUltimos3MesesProductoCiudad
```

## 9. Evidencias de portafolio

Una vez validado todo el flujo, capturar y publicar las evidencias descritas en:

```text
docs/Evidencias.md
```

No deben mostrarse enlaces de galería en el README hasta que las capturas correspondientes existan realmente en `assets/screenshots/`.

## 10. Reproducibilidad de SSAS

Consultar:

```text
analysis-services/README.md
```

Los archivos generados por SSDT deben exportarse desde un proyecto real validado localmente. No se recomienda escribir manualmente `.dwproj`, `.cube`, `.dim`, `.dsv` o `.ds` solo para simular que el proyecto es ejecutable.
