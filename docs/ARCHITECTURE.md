# Arquitectura de SalesIntel DW

SalesIntel DW implementa una arquitectura clásica de **Business Intelligence**: datos transaccionales de origen, proceso ETL, Data Warehouse con esquema estrella, capa analítica multidimensional y herramientas de consumo para reportes y dashboards.

## Vista general

```mermaid
flowchart LR
    OLTP[("SalesIntel_OLTP")]
    ExcelSource["Archivos Excel / Datos de entrada"]

    OLTP --> Staging["Staging / Validación"]
    ExcelSource --> Staging
    Staging --> ETL["ETL · Extract / Transform / Load"]
    ETL --> DW[("SalesIntel_DW · Star Schema")]

    DW --> SQLReports["Vistas / Procedimientos / Reportes SQL"]
    DW --> SSAS["SQL Server Analysis Services"]
    SSAS --> Cube["CuboVentasSalesIntel"]
    Cube --> MDX["Consultas MDX"]

    DW --> Excel["Dashboard Excel"]
    DW --> PowerBI["Dashboard Power BI"]
```

La fuente transaccional no se consulta directamente para análisis multidimensional. El ETL transforma los datos hacia un modelo diseñado para lectura analítica y preserva una separación clara entre operación y reporting.

## Flujo ETL

```mermaid
sequenceDiagram
    participant S as Fuentes OLTP / Excel
    participant ST as Staging
    participant ETL as Proceso ETL
    participant D as Dimensiones
    participant F as FactVentas
    participant DW as SalesIntel_DW

    S->>ST: cargar datos de origen
    ST->>ETL: registros validados
    ETL->>ETL: limpiar y transformar
    ETL->>D: cargar dimensiones
    D-->>ETL: claves sustitutas
    ETL->>F: cargar hechos y métricas
    D->>DW: DimCiudad / Producto / Cliente / Tiempo
    F->>DW: FactVentas
```

## Modelo dimensional

```mermaid
flowchart TB
    Tiempo["DimTiempo"] --> Fact["FactVentas"]
    Ciudad["DimCiudad"] --> Fact
    Producto["DimProducto"] --> Fact
    Cliente["DimCliente"] --> Fact

    Fact --> Measures["Cantidad · Precio · Descuento · Total"]
```

El esquema estrella reduce complejidad de consulta y facilita el consumo desde SSAS, Excel y Power BI.

## Capa multidimensional

```mermaid
flowchart LR
    DW[("SalesIntel_DW")]
    DW --> DSV["Data Source View"]
    DSV --> SSAS["SSAS Multidimensional"]
    SSAS --> Cube["CuboVentasSalesIntel"]
    Cube --> Measures["Medidas"]
    Cube --> Dimensions["Dimensiones"]
    Measures --> MDX["Consultas MDX"]
    Dimensions --> MDX
```

## Capa de consumo

```mermaid
flowchart LR
    DW[("SalesIntel_DW")]
    Cube["Cubo SSAS"]

    DW --> Views["Vistas analíticas"]
    Views --> PowerBI["Power BI"]
    DW --> Excel["Excel"]
    Cube --> MDX["MDX"]
    MDX --> Analysts["Análisis multidimensional"]
    PowerBI --> Executives["KPIs / Dashboard ejecutivo"]
    Excel --> Executives
```

## Componentes principales

| Componente | Responsabilidad |
|---|---|
| `SalesIntel_OLTP` | Modelo transaccional de origen |
| Staging | Recepción, limpieza y validación previa de datos |
| ETL | Extracción, transformación, claves sustitutas y carga |
| `SalesIntel_DW` | Data Warehouse analítico |
| Dimensiones | Ciudad, Producto, Cliente y Tiempo |
| `FactVentas` | Métricas de ventas y claves dimensionales |
| SSAS | Motor multidimensional |
| `CuboVentasSalesIntel` | Cubo OLAP de ventas |
| MDX | Consultas multidimensionales |
| Excel | Dashboard analítico |
| Power BI | Dashboard interactivo y KPIs |

## Orden técnico de construcción

```mermaid
flowchart TD
    Model["1. Crear modelo OLTP / DW"] --> Seed["2. Datos de prueba"]
    Seed --> ETL["3. Ejecutar ETL"]
    ETL --> Reports["4. Crear vistas / reportes"]
    Reports --> CubePrep["5. Preparar cubo"]
    CubePrep --> SSAS["6. Procesar SSAS"]
    SSAS --> MDX["7. Validar MDX"]
    MDX --> Dashboards["8. Actualizar Excel / Power BI"]
```

## Criterio de evolución

El diseño debe mantener separados el modelo transaccional y el analítico. Si el volumen o frecuencia de carga aumentan, la evolución natural sería automatizar orquestación ETL, incrementalidad y calidad de datos antes de introducir nuevas herramientas de visualización.
