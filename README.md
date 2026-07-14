# 📊 SalesIntel DW

<p align="center">
  <img src="https://skillicons.dev/icons?i=visualstudio,git,github" alt="Tecnologías utilizadas" />
</p>

<p align="center">

![SQL Server](https://img.shields.io/badge/SQL%20Server-2022-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![SSAS](https://img.shields.io/badge/SSAS-Analysis%20Services-5C2D91?style=for-the-badge&logo=microsoft&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Excel](https://img.shields.io/badge/Excel-Dashboard-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)
![Original](https://img.shields.io/badge/Original-2017-blue?style=for-the-badge)
![Version](https://img.shields.io/badge/Version-2026-brightgreen?style=for-the-badge)

</p>

---

# 📖 Descripción

**SalesIntel DW** es una solución de **Business Intelligence (BI)** desarrollada desde cero tomando como referencia un proyecto final académico realizado originalmente en el **Instituto Tecnológico de Las Américas (ITLA)** para la asignatura **Minería de Datos e Inteligencia de Negocios (SOF-014)**.

El proyecto original presentaba múltiples errores e incompatibilidades, por lo que esta versión fue rediseñada completamente con una estructura moderna, organizada y documentada, manteniendo la misma idea académica pero utilizando buenas prácticas de desarrollo y documentación.

La solución implementa un flujo completo de Inteligencia de Negocios utilizando:

- 🗄️ Base de datos transaccional (OLTP)
- ⭐ Data Warehouse en esquema estrella
- 🔄 Procesos ETL
- 🧊 Cubo Multidimensional (SQL Server Analysis Services)
- 📐 Consultas MDX
- 📗 Dashboard en Microsoft Excel
- 📊 Dashboard interactivo en Microsoft Power BI

Esta versión forma parte de mi **portafolio profesional**, preservando el valor académico del proyecto original mientras demuestra conocimientos en tecnologías modernas de Business Intelligence.

---

# 📌 Información del proyecto

- 📘 **Materia:** Minería de Datos e Inteligencia de Negocios (SOF-014)
- 👨‍🏫 **Profesor:** Carlos Caraballo
- 🏫 **Institución:** Instituto Tecnológico de Las Américas (ITLA)
- 📅 **Período Académico:** 2017-C3
- 🛠️ **Nueva implementación y documentación:** 2026

---

# 👥 Integrantes del proyecto académico original

| Integrante | Matrícula |
|------------|-----------|
| 👤 Francis Jairo Matías Rosario | **2015-2984** |
| 👤 Jhon Christopher Adames Perez | **2015-2986** |

---

# ✨ Funcionalidades

- 🗄️ Base de datos OLTP para la gestión de ventas.
- ⭐ Data Warehouse utilizando esquema estrella.
- 🔄 Procesos ETL para carga de dimensiones y tabla de hechos.
- 📥 Importación y validación de productos desde Excel.
- 🧊 Cubo Multidimensional con SQL Server Analysis Services (SSAS).
- 📐 Consultas MDX para análisis multidimensional.
- 📑 Reportes SQL mediante vistas y procedimientos almacenados.
- 📗 Dashboard analítico en Microsoft Excel.
- 📊 Dashboard interactivo en Microsoft Power BI.
- 📈 Indicadores (KPIs) de ventas.
- 🏙️ Análisis por ciudad.
- 📦 Análisis por producto.
- 📅 Análisis por período.
- 👥 Análisis por cliente.
- 📚 Documentación técnica completa.
- 🌿 Organización del proyecto para GitHub.

---

# 🧰 Tecnologías utilizadas

<p align="center">
  <img src="https://skillicons.dev/icons?i=visualstudio,git,github" alt="Tecnologías utilizadas" />
</p>

| Tecnología | Descripción |
|------------|-------------|
| 🗄️ Microsoft SQL Server 2022 | Motor de base de datos relacional utilizado para el modelo OLTP y el Data Warehouse. |
| 🧰 SQL Server Management Studio (SSMS) | Administración, desarrollo y ejecución de scripts SQL. |
| 💻 Visual Studio 2026 | Desarrollo del proyecto multidimensional mediante SQL Server Data Tools. |
| 🧩 SQL Server Data Tools (SSDT) | Creación del modelo de Analysis Services. |
| 🧊 SQL Server Analysis Services (SSAS) | Construcción y procesamiento del cubo multidimensional. |
| 📐 MDX | Lenguaje de consultas para análisis multidimensional. |
| 📗 Microsoft Excel | Dashboard analítico y validación de datos. |
| 📊 Microsoft Power BI Desktop | Dashboard interactivo conectado al Data Warehouse. |
| 🌿 Git | Control de versiones. |
| 🐙 GitHub | Publicación y documentación del proyecto. |

---

# 📊 Estadísticas del proyecto

| Elemento | Cantidad |
|----------|---------:|
| 🗄️ Tablas OLTP | **5** |
| ⭐ Dimensiones | **4** |
| 📈 Tabla de Hechos | **1** |
| 📥 Tabla de Staging | **1** |
| 🧊 Cubo SSAS | **1** |
| 📐 Consultas MDX | **10** |
| 📑 Scripts SQL | **5** |
| 📊 Dashboards | **2** |
| 📋 Procedimientos almacenados | **1** |
| 👁️ Vistas analíticas | **9** |

---

# 🏗️ Arquitectura de la solución

```text
                     SalesIntel DW

          +------------------------------+
          |      Sistema Transaccional   |
          |       SalesIntel_OLTP         |
          +------------------------------+
                     │
                     │
                     ▼
          +------------------------------+
          |       Proceso ETL            |
          +------------------------------+
                     │
                     ▼
          +------------------------------+
          |      SalesIntel_DW           |
          |      Data Warehouse          |
          +------------------------------+
                     │
          ┌──────────┴──────────┐
          ▼                     ▼
+------------------+    +----------------------+
|  SQL Reportes    |    | SQL Server Analysis  |
|     (Views)      |    |      Services        |
+------------------+    +----------------------+
          │                     │
          ▼                     ▼
+------------------+    +----------------------+
| Excel Dashboard  |    | Power BI Dashboard   |
+------------------+    +----------------------+
```

---

# 📂 Estructura del repositorio

```text
SalesIntel-DW
│
├── 📁 database
│   ├── 📁 01_model
│   ├── 📁 02_seed
│   ├── 📁 03_etl
│   ├── 📁 04_reports
│   └── 📁 05_cube
│
├── 📁 analysis-services
│   └── 📁 mdx
│
├── 📁 excel
│
├── 📁 power-bi
│
├── 📁 docs
│
├── 📁 assets
│   └── 📁 screenshots
│
├── 📁 legacy
│
├── 📄 README.md
├── 📄 LICENSE
└── 📄 .gitignore
```

---

# ▶️ Orden de ejecución

Ejecutar los scripts utilizando **SQL Server Management Studio** respetando el siguiente orden:

```text
01_Crear_Modelo_SalesIntel_DW.sql

02_Insertar_Datos_Prueba_SalesIntel_DW.sql

03_ETL_Cargar_DW_SalesIntel.sql

04_Consultas_Reportes_SalesIntel.sql

05_Preparar_Cubo_SalesIntel.sql
```

Una vez ejecutados los scripts:

1. Abrir **Visual Studio**.
2. Crear un proyecto **SQL Server Analysis Services Multidimensional**.
3. Crear el **Data Source** apuntando a `SalesIntel_DW`.
4. Crear el **Data Source View**.
5. Generar el cubo utilizando las vistas preparadas.
6. Procesar el cubo.
7. Validar las consultas MDX.
8. Abrir el archivo **Power BI (.pbix)**.
9. Actualizar los datos y explorar el dashboard interactivo.

---

# ⭐ Modelo Data Warehouse

El Data Warehouse fue diseñado utilizando un **esquema estrella (Star Schema)** para optimizar el análisis multidimensional y facilitar la construcción del cubo OLAP.

## 📌 Dimensiones

- 🏙️ **DimCiudad**
- 📦 **DimProducto**
- 👤 **DimCliente**
- 📅 **DimTiempo**

## 📈 Tabla de hechos

- 💰 **FactVentas**

La tabla de hechos almacena las métricas principales utilizadas por el cubo y los dashboards:

- 📦 Cantidad Vendida
- 💵 Precio Unitario
- 🏷️ Descuento
- 💰 Total Vendido

---

# 🔄 Proceso ETL

El proceso ETL (Extract, Transform & Load) realiza la carga de información desde la base de datos transaccional (**SalesIntel_OLTP**) hacia el Data Warehouse (**SalesIntel_DW**).

## Flujo del proceso

```text
SalesIntel_OLTP
        │
        ▼
 Extracción de datos
        │
        ▼
 Transformación
        │
        ▼
Carga de Dimensiones
        │
        ▼
Carga de FactVentas
        │
        ▼
SalesIntel_DW
```

Durante este proceso se realizan:

- 🔄 Transformación de datos.
- 🧹 Limpieza de registros.
- 🔑 Generación de claves sustitutas.
- 📅 Construcción de la dimensión Tiempo.
- 📊 Carga de la tabla de hechos.

---

# 🧊 Cubo Multidimensional (SSAS)

El proyecto incluye un cubo OLAP desarrollado mediante **SQL Server Analysis Services (SSAS)**.

## 📦 Nombre del cubo

```text
CuboVentasSalesIntel
```

## 📊 Medidas

- 💰 Total Vendido
- 📦 Cantidad Vendida
- 🏷️ Descuento
- 💵 Precio Unitario

## 🧭 Dimensiones

- 📦 Producto
- 🏙️ Ciudad
- 👤 Cliente
- 📅 Tiempo

El cubo permite realizar análisis multidimensionales mediante **Consultas MDX**, facilitando la exploración de la información desde distintas perspectivas.

---

# 📗 Dashboard en Microsoft Excel

Como parte del proyecto académico original se desarrolló un dashboard utilizando **Microsoft Excel**, conectado al Data Warehouse.

## Incluye

- 📈 Indicadores generales.
- 🏙️ Ventas por ciudad.
- 📦 Ventas por producto.
- 📅 Ventas por año.
- 📊 Tablas dinámicas.
- 📉 Gráficos dinámicos.

Archivo:

```text
excel/
└── SalesIntel_DW_Dashboard_Excel.xlsx
```

---

# 📊 Dashboard en Microsoft Power BI

Como mejora respecto al proyecto académico original, esta versión incorpora un dashboard interactivo desarrollado en **Microsoft Power BI Desktop**.

## 📌 KPIs

- 📦 Cantidad Vendida
- 💰 Total Vendido
- 🏷️ Descuento Total
- 🧾 Total de Facturas

## 📈 Visualizaciones

- 🏙️ Ventas por Ciudad.
- 📦 Ventas por Producto.
- 📅 Ventas por Producto y Año.
- 📋 Ventas de los últimos tres meses.
- 📊 Indicadores (KPIs).

## Fuente de datos

Power BI consume directamente las siguientes vistas del Data Warehouse:

```text
vw_VentasDetalleDW

vw_VentasPorCiudad

vw_VentasProductoAnio

vw_VentasUltimos3MesesProductoCiudad
```

Archivo:

```text
power-bi/
└── SalesIntelDW.pbix
```

---

# 📸 Galería del proyecto

> **Las siguientes imágenes corresponden a evidencias del funcionamiento del sistema.**

## 🏗️ Modelo Data Warehouse

```text
assets/screenshots/01_modelo_dw.png
```

---

## 🧊 Cubo Multidimensional

```text
assets/screenshots/02_cubo_ssas.png
```

---

## 📗 Dashboard en Excel

```text
assets/screenshots/03_dashboard_excel.png
```

---

## 📊 Dashboard en Power BI

```text
assets/screenshots/04_dashboard_powerbi.png
```

---

## 📈 Resultados obtenidos

La solución fue validada exitosamente obteniendo los siguientes resultados:

| Métrica | Resultado |
|---------|----------:|
| 📦 Cantidad Vendida | **183** |
| 💰 Total Vendido | **222,995.00** |
| 🏷️ Descuento Total | **3,150.00** |
| 🧾 Total de Facturas | **22** |
| 📅 Ventas últimos 3 meses | **83,230.00** |

Todos los resultados fueron verificados mediante:

- ✅ Consultas SQL.
- ✅ Consultas MDX.
- ✅ Cubo SSAS.
- ✅ Dashboard en Excel.
- ✅ Dashboard en Power BI.

---

# 🔎 Consultas SQL destacadas

El proyecto incluye diversas consultas para validar la información almacenada en el Data Warehouse.

## 🏙️ Ventas por ciudad

```sql
SELECT
    NombreCiudad,
    TotalVendido
FROM dbo.vw_VentasPorCiudad
ORDER BY TotalVendido DESC;
```

---

## 📦 Ventas por producto y año

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

---

## 📅 Reporte de los últimos tres meses

```sql
EXEC dbo.sp_ReporteVentasUltimos3MesesProductoCiudad;
```

---

# 📐 Consultas MDX

El cubo multidimensional fue validado mediante consultas **MDX**.

Archivo:

```text
analysis-services/
└── mdx/
    └── 06_Consultas_MDX_Cubo_SalesIntel.mdx
```

### Consultas incluidas

- 📊 Total general de ventas.
- 🏙️ Ventas por ciudad.
- 📦 Ventas por producto.
- 📅 Ventas por año.
- 👤 Ventas por cliente.
- 📈 Ventas por ciudad y producto.
- 🏆 Top 5 ciudades con mayores ventas.
- 🏆 Top 5 productos más vendidos.
- 📆 Ventas por trimestre.
- 📆 Ventas por mes.

---

# 📚 Conceptos aplicados

Durante el desarrollo de esta versión del proyecto se aplicaron conocimientos relacionados con:

- 📊 Business Intelligence (BI)
- ⭐ Data Warehouse
- ⭐ Modelado Dimensional
- ⭐ Esquema Estrella (Star Schema)
- 🔄 ETL (Extract, Transform & Load)
- 🗄️ SQL Server
- 🧊 SQL Server Analysis Services (SSAS)
- 📐 MDX
- 📗 Microsoft Excel
- 📊 Microsoft Power BI
- 📈 KPIs
- 📉 Dashboards Analíticos
- 📋 Reportes Gerenciales
- 🌿 Git
- 🐙 GitHub

---

# 🚀 Mejoras implementadas en esta versión

La versión publicada en este repositorio fue desarrollada completamente desde cero, tomando como referencia únicamente la idea y los objetivos académicos del proyecto original.

Entre las principales mejoras realizadas se encuentran:

- ✅ Reestructuración completa del modelo de datos.
- ✅ Organización profesional del repositorio.
- ✅ Scripts SQL separados por etapas.
- ✅ Documentación técnica completa.
- ✅ Incorporación de Microsoft Power BI.
- ✅ Consultas MDX documentadas.
- ✅ Mejora del proceso ETL.
- ✅ Compatibilidad con SQL Server 2022.
- ✅ Preparación del proyecto para portafolio profesional.
- ✅ Integración con Git y GitHub.
- ✅ Estandarización de nombres y estructura.
- ✅ Limpieza general del código SQL.

---

# 📜 Licencia

Este proyecto fue desarrollado originalmente con fines **académicos** para el **Instituto Tecnológico de las Américas (ITLA)**.

La versión publicada en este repositorio corresponde a una implementación completamente nueva desarrollada en **2026**, con fines educativos, demostrativos y como parte de mi portafolio profesional.

El proyecto conserva la idea académica original, pero su estructura, organización, documentación y mejoras corresponden a esta nueva implementación.

---

# 🙌 Agradecimientos

Agradecimientos especiales a:

- 🏫 Instituto Tecnológico de las Américas (ITLA).
- 👨‍🏫 Prof. Carlos Caraballo.
- 👥 Equipo del proyecto académico original.
- 💙 Comunidad Microsoft.
- 📊 Equipo de Microsoft Power BI.
- 🧊 SQL Server Analysis Services.

---

# 👨‍💻 Autor

## Francis Jairo Matías Rosario

**Tecnólogo en Desarrollo de Software**  
**Estudiante de Ingeniería de Software**

### Áreas de interés

- 💻 Desarrollo de Software
- 🌐 Desarrollo Web
- 📊 Business Intelligence
- 🗄️ Bases de Datos
- 📈 Power BI
- 🎮 Desarrollo de Videojuegos
- 🤖 Inteligencia Artificial

---

# ⭐ Estado del proyecto

| Estado | Valor |
|---------|-------|
| 🚀 Desarrollo | **Completado** |
| 🛠️ Mantenimiento | **Activo** |
| 📚 Documentación | **Completa** |
| 📊 Dashboard Power BI | **Implementado** |
| 📗 Dashboard Excel | **Implementado** |
| 🧊 Cubo SSAS | **Implementado** |
| 🌿 GitHub | **Publicado** |

---

<div align="center">

## 🎯 SalesIntel DW

**Business Intelligence • Data Warehouse • ETL • SSAS • MDX • Power BI**

---

⭐ Si este proyecto te resultó interesante, puedes darle una estrella al repositorio.

Desarrollado con fines académicos y de portafolio profesional.

**© 2026 • Francis Jairo Matías Rosario**

</div>