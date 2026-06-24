# 📊 SalesIntel DW

<p align="center">
  <img src="https://skillicons.dev/icons?i=visualstudio,git,github" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/SQL%20Server-2022-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white" />
  <img src="https://img.shields.io/badge/SSMS-SQL%20Server%20Management%20Studio-0078D4?style=for-the-badge&logo=microsoft&logoColor=white" />
  <img src="https://img.shields.io/badge/SSAS-Analysis%20Services-5C2D91?style=for-the-badge&logo=microsoft&logoColor=white" />
  <img src="https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=for-the-badge&logo=powerbi&logoColor=black" />
  <img src="https://img.shields.io/badge/Excel-Dashboard-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white" />
</p>

<p align="center">
  <strong>Data Warehouse · ETL · SSAS Cube · MDX · Excel Dashboard · Power BI Dashboard</strong>
</p>

---

## 📌 Descripción

**SalesIntel DW** es una solución de **Inteligencia de Negocios (BI)** reconstruida y modernizada a partir de un proyecto final académico desarrollado originalmente en el **Instituto Tecnológico de Las Américas (ITLA)** para la asignatura **Minería de Datos e Inteligencia de Negocios (SOF-014)**.

El proyecto implementa un flujo completo de análisis de ventas utilizando **SQL Server**, **Data Warehouse**, **ETL**, **vistas analíticas**, **SQL Server Analysis Services**, **consultas MDX**, **dashboard en Excel** y una versión moderna del dashboard en **Power BI**.

---

## 🎓 Información académica original

| Dato           | Información                                  |
| -------------- | -------------------------------------------- |
| 🏫 Institución | Instituto Tecnológico de Las Américas (ITLA) |
| 📘 Materia     | Minería de Datos e Inteligencia de Negocios  |
| 🧾 Código      | SOF-014                                      |
| 👨‍🏫 Profesor | Carlos Caraballo                             |
| 📅 Período     | 2017-C3                                      |
| 👥 Modalidad   | Proyecto Final Grupal                        |

### 👨‍💻 Integrantes

| Integrante                    | Matrícula |
| ----------------------------- | --------- |
| Francis Jairo Matias Rosario  | 2015-2984 |
| Jhon Christopher Adames Perez | 2015-2986 |

---

## 🎯 Objetivo

Construir una solución de Inteligencia de Negocios para analizar ventas nacionales por ciudad, producto, período y cliente, mediante:

* 🗄️ Base de datos transaccional simulada.
* ⭐ Data Warehouse en esquema estrella.
* 🔄 Proceso ETL hacia dimensiones y tabla de hechos.
* 📥 Validación de productos externos desde Excel.
* 🧊 Cubo Multidimensional con SQL Server Analysis Services.
* 📐 Consultas MDX para análisis del cubo.
* 📑 Reportes SQL.
* 📊 Dashboard en Excel.
* ⚡ Dashboard moderno en Power BI conectado al Data Warehouse.

---

## 🏗️ Arquitectura

```text
SalesIntel DW
├── SalesIntel_OLTP
│   ├── Ciudad
│   ├── Producto
│   ├── Cliente
│   ├── Factura
│   └── DetFactura
│
├── SalesIntel_DW
│   ├── DimProducto
│   ├── DimCiudad
│   ├── DimCliente
│   ├── DimTiempo
│   ├── FactVentas
│   └── StgProductosExcel
│
├── SQL Server Analysis Services
│   └── CuboVentasSalesIntel
│
├── Excel Dashboard
│
└── Power BI Dashboard
```

---

## 🛠️ Tecnologías utilizadas

<p align="left">
  <img src="https://skillicons.dev/icons?i=visualstudio,git,github" />
</p>

| Tecnología                      | Uso dentro del proyecto                            |
| ------------------------------- | -------------------------------------------------- |
| 🗄️ SQL Server 2022             | Motor de base de datos relacional                  |
| 🧰 SQL Server Management Studio | Creación, ejecución y validación de scripts SQL    |
| 💻 Visual Studio 2026           | Desarrollo del proyecto multidimensional           |
| 🧩 SQL Server Data Tools        | Herramientas BI para Visual Studio                 |
| 🧊 SQL Server Analysis Services | Creación y procesamiento del cubo multidimensional |
| 📐 MDX                          | Consultas analíticas sobre el cubo                 |
| 📗 Microsoft Excel              | Dashboard y análisis tabular                       |
| 📊 Microsoft Power BI Desktop   | Dashboard moderno conectado al Data Warehouse      |
| 🧬 Git / GitHub                 | Control de versiones y publicación del proyecto    |

---

## 📁 Estructura del repositorio

```text
database/
├── 01_model/
│   └── 01_Crear_Modelo_SalesIntel_DW.sql
├── 02_seed/
│   └── 02_Insertar_Datos_Prueba_SalesIntel_DW.sql
├── 03_etl/
│   └── 03_ETL_Cargar_DW_SalesIntel.sql
├── 04_reports/
│   └── 04_Consultas_Reportes_SalesIntel.sql
└── 05_cube/
    └── 05_Preparar_Cubo_SalesIntel.sql

analysis-services/
└── mdx/
    └── 06_Consultas_MDX_Cubo_SalesIntel.mdx

excel/
└── SalesIntel_DW_Dashboard_Excel.xlsx

power-bi/
└── SalesIntelDW.pbix

docs/
├── Setup.md
├── Evidencias.md
└── Guia_Crear_Cubo_SalesIntel_DW.md

legacy/
└── Archivos originales del proyecto académico

assets/
└── screenshots/
```

---

## ▶️ Orden de ejecución

Ejecutar los scripts en **SQL Server Management Studio** en el siguiente orden:

```text
01_Crear_Modelo_SalesIntel_DW.sql
02_Insertar_Datos_Prueba_SalesIntel_DW.sql
03_ETL_Cargar_DW_SalesIntel.sql
04_Consultas_Reportes_SalesIntel.sql
05_Preparar_Cubo_SalesIntel.sql
```

Luego crear el proyecto multidimensional en **Visual Studio** usando las vistas preparadas para el cubo:

```text
vw_Cubo_DimProducto
vw_Cubo_DimCiudad
vw_Cubo_DimCliente
vw_Cubo_DimTiempo
vw_Cubo_FactVentas
```

---

## ⭐ Modelo Data Warehouse

El Data Warehouse utiliza un **esquema estrella** compuesto por una tabla de hechos y cuatro dimensiones principales.

### 📌 Dimensiones

* `DimProducto`
* `DimCiudad`
* `DimCliente`
* `DimTiempo`

### 📈 Tabla de hechos

* `FactVentas`

La tabla de hechos almacena las métricas principales del análisis:

* Cantidad vendida.
* Precio unitario.
* Descuento.
* Total vendido.

---

## 🧊 Cubo Multidimensional

Nombre del cubo:

```text
CuboVentasSalesIntel
```

### 📊 Medidas principales

* Total Vendido
* Cantidad Vendida
* Descuento
* Precio Unitario

### 🧭 Dimensiones

* Producto
* Ciudad
* Cliente
* Tiempo

---

## 📗 Dashboard en Excel

El dashboard en Excel se encuentra en:

```text
excel/SalesIntel_DW_Dashboard_Excel.xlsx
```

Incluye:

* Indicadores generales.
* Ventas por ciudad.
* Ventas por producto y año.
* Reporte de últimos tres meses.
* Datos detallados del Data Warehouse.
* Consultas SQL utilizadas como fuente.

---

## 📊 Dashboard en Power BI

Como capa moderna de visualización, el proyecto incluye un dashboard en **Power BI Desktop** conectado directamente al Data Warehouse `SalesIntel_DW`.

Archivo:

```text
power-bi/SalesIntelDW.pbix
```

### 📌 Visualizaciones incluidas

* KPI: Cantidad vendida.
* KPI: Descuento total.
* KPI: Total de facturas.
* KPI: Total vendido.
* Gráfico de barras: ventas por ciudad.
* Gráfico de barras: ventas por producto.
* Matriz: ventas por producto y año.
* Tabla: ventas de los últimos tres meses por ciudad y producto.

### 🗄️ Fuente de datos usada en Power BI

Power BI consume las siguientes vistas del Data Warehouse:

```text
vw_VentasDetalleDW
vw_VentasPorCiudad
vw_VentasProductoAnio
vw_VentasUltimos3MesesProductoCiudad
```

### 🧮 Medidas DAX principales

```DAX
Total Vendido = SUM(vw_VentasDetalleDW[TotalVenta])
```

```DAX
Cantidad Vendida = SUM(vw_VentasDetalleDW[Cantidad])
```

```DAX
Descuento Total = SUM(vw_VentasDetalleDW[Descuento])
```

```DAX
Total Facturas = DISTINCTCOUNT(vw_VentasDetalleDW[IdFactura])
```

```DAX
Ticket Promedio =
DIVIDE(
    SUM(vw_VentasDetalleDW[TotalVenta]),
    DISTINCTCOUNT(vw_VentasDetalleDW[IdFactura])
)
```

---

## 🔎 Consultas principales

### 🏙️ Ventas por ciudad

```sql
SELECT
    NombreCiudad,
    TotalVendido
FROM dbo.vw_VentasPorCiudad
ORDER BY TotalVendido DESC;
```

### 📦 Ventas por producto y año

```sql
SELECT
    Anio,
    NombreProducto,
    TotalVendido
FROM dbo.vw_VentasProductoAnio
ORDER BY
    Anio,
    NombreProducto;
```

### 🕒 Reporte de últimos tres meses

```sql
EXEC dbo.sp_ReporteVentasUltimos3MesesProductoCiudad;
```

---

## 📐 Consultas MDX

El repositorio incluye consultas MDX para validar y navegar el cubo desde SQL Server Analysis Services:

```text
analysis-services/mdx/06_Consultas_MDX_Cubo_SalesIntel.mdx
```

Consultas incluidas:

* Total general del cubo.
* Ventas por ciudad.
* Ventas por producto.
* Ventas por producto y año.
* Ventas por ciudad y producto.
* Ventas por año, trimestre y mes.
* Top 5 ciudades por ventas.
* Top 5 productos por ventas.
* Ventas por región y ciudad.
* Ventas por tipo de cliente.

---

## ✅ Resultados validados

| Métrica                   |  Resultado |
| ------------------------- | ---------: |
| 📦 Cantidad vendida       |        183 |
| 🏷️ Descuento total       |   3,150.00 |
| 🧾 Total de facturas      |         22 |
| 💰 Total vendido          | 222,995.00 |
| 🕒 Ventas últimos 3 meses |  83,230.00 |

---

## 🚦 Estado del proyecto

* [x] 🗄️ Modelo transaccional
* [x] ⭐ Data Warehouse
* [x] 🧪 Datos de prueba
* [x] 🔄 ETL SQL
* [x] 📥 Validación de productos externos
* [x] 📑 Vistas de reportes
* [x] 🧊 Vistas para cubo
* [x] 🧊 Cubo SSAS
* [x] ⚙️ Procesamiento del cubo
* [x] 🔎 Browse de ventas por ciudad
* [x] 📦 Browse de ventas por producto y año
* [x] 📗 Dashboard Excel
* [x] 📊 Dashboard Power BI
* [x] 📝 Documentación para GitHub

---

## 🖼️ Evidencias sugeridas

Guardar capturas dentro de:

```text
assets/screenshots/
```

Capturas recomendadas:

```text
06_modelo_estrella_dsv.png
08_cubo_procesado_correctamente.png
09_browse_ventas_por_ciudad.png
10_browse_producto_por_anio.png
11_dashboard_excel.png
12_dashboard_power_bi.png
```

---

## 🚀 Propósito de esta Reconstrucción

Este repositorio conserva y moderniza un proyecto académico desarrollado originalmente en el período **2017-C3**, transformándolo en una pieza presentable de portafolio profesional.

La reconstrucción mantiene la esencia del proyecto original: carga de datos, análisis de ventas, Data Warehouse, cubo multidimensional y visualización de resultados. A la vez, organiza los scripts, documentación, evidencias y artefactos técnicos bajo una estructura más limpia y mantenible para GitHub.

La incorporación de **Power BI** no formó parte del alcance académico original, pero se agregó como una capa moderna de visualización para fortalecer la presentación del proyecto en portafolio.

---

## 🤝 Créditos

Proyecto original desarrollado en grupo para la asignatura **Minería de Datos e Inteligencia de Negocios (SOF-014)** del **ITLA**, impartida por el profesor **Carlos Caraballo**, durante el período **2017-C3**.

### 👥 Integrantes del proyecto original

* **Francis Jairo Matias Rosario** — `2015-2984`
* **Jhon Christopher Adames Perez** — `2015-2986`

---

## 👨‍💻 Autor de la Reconstrucción

**Francis Jairo Matias Rosario**

Reconstrucción, modernización técnica, documentación y preparación del proyecto para portafolio.


