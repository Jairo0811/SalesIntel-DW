<p align="center">
  <img src="docs/logo.png" width="230" alt="SalesIntel DW Logo">
</p>

<h1 align="center">📊 SalesIntel DW</h1>

<p align="center">
  <strong>Business Intelligence Platform</strong>
</p>

<p align="center">
  SQL Server • Data Warehouse • ETL • SSAS • MDX • Excel • Power BI
</p>

<p align="center">
  <img src="https://skillicons.dev/icons?i=visualstudio,git,github" alt="Tecnologías utilizadas">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/SQL%20Server-2022-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white" alt="SQL Server">
  <img src="https://img.shields.io/badge/SSAS-Analysis%20Services-5C2D91?style=for-the-badge&logo=microsoft&logoColor=white" alt="SSAS">
  <img src="https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=for-the-badge&logo=powerbi&logoColor=black" alt="Power BI">
  <img src="https://img.shields.io/badge/Excel-Dashboard-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white" alt="Excel">
  <img src="https://img.shields.io/badge/Status-Finalizado-success?style=for-the-badge" alt="Estado">
  <img src="https://img.shields.io/badge/Original-2017-blue?style=for-the-badge" alt="Proyecto original">
  <img src="https://img.shields.io/badge/Nueva%20versión-2026-brightgreen?style=for-the-badge" alt="Nueva versión">
</p>

---

## 📖 Descripción

**SalesIntel DW** es una solución de **Inteligencia de Negocios (BI)** desarrollada nuevamente desde cero tomando como referencia un proyecto final académico realizado originalmente en **2017** para la asignatura **Minería de Datos e Inteligencia de Negocios (SOF-014)** del **Instituto Tecnológico de las Américas (ITLA)**.

El proyecto académico original presentaba múltiples errores, incompatibilidades y una estructura difícil de mantener. Por esta razón, en **2026** se creó una nueva implementación completa, organizada y documentada, conservando la idea académica original y modernizándola como una pieza de portafolio profesional.

La solución implementa un flujo completo de análisis de ventas mediante:

- 🗄️ Base de datos transaccional OLTP.
- ⭐ Data Warehouse con esquema estrella.
- 🔄 Procesos ETL.
- 🧊 Cubo multidimensional mediante SQL Server Analysis Services.
- 📐 Consultas MDX.
- 📑 Reportes SQL.
- 📗 Dashboard analítico en Microsoft Excel.
- 📊 Dashboard interactivo en Microsoft Power BI.

---

## 📌 Información del proyecto

- 📘 **Materia:** Minería de Datos e Inteligencia de Negocios (SOF-014)
- 👨‍🏫 **Profesor:** Carlos Caraballo
- 🏫 **Institución:** Instituto Tecnológico de las Américas (ITLA)
- 📅 **Período académico original:** 2017-C3
- 🛠️ **Nueva implementación y documentación:** 2026
- ✅ **Estado:** Finalizado

---

## 👥 Integrantes del proyecto académico original

| Integrante | Matrícula |
|------------|-----------|
| 👤 Francis Jairo Matías Rosario | **2015-2984** |
| 👤 Jhon Christopher Adames Perez | **2015-2986** |

---

## ✨ Funcionalidades

- 🗄️ Modelo transaccional OLTP para la gestión de ventas.
- ⭐ Data Warehouse diseñado con esquema estrella.
- 🔄 Carga ETL de dimensiones y tabla de hechos.
- 📥 Importación y validación de productos desde Excel.
- 🧹 Limpieza y transformación de datos.
- 🔑 Uso de claves sustitutas en las dimensiones.
- 📅 Construcción de la dimensión de tiempo.
- 🏙️ Análisis de ventas por ciudad.
- 📦 Análisis de ventas por producto.
- 👤 Análisis de ventas por cliente.
- 📅 Análisis de ventas por año, trimestre y mes.
- 🧊 Cubo multidimensional mediante SSAS.
- 📐 Consultas analíticas mediante MDX.
- 📑 Reportes SQL mediante vistas y procedimientos almacenados.
- 📗 Dashboard analítico en Microsoft Excel.
- 📊 Dashboard interactivo en Microsoft Power BI.
- 📈 Indicadores de ventas y KPIs.
- 📚 Documentación técnica del proceso completo.
- 🌿 Organización profesional del proyecto para GitHub.

---

## 🧰 Tecnologías utilizadas

<p align="center">
  <img src="https://skillicons.dev/icons?i=visualstudio,git,github" alt="Tecnologías utilizadas">
</p>

| Tecnología | Uso dentro del proyecto |
|------------|-------------------------|
| 🗄️ Microsoft SQL Server 2022 | Motor de base de datos utilizado para el modelo OLTP y el Data Warehouse. |
| 🧰 SQL Server Management Studio | Creación, ejecución y validación de scripts SQL. |
| 💻 Visual Studio | Desarrollo del proyecto multidimensional. |
| 🧩 SQL Server Data Tools | Herramientas BI utilizadas dentro de Visual Studio. |
| 🧊 SQL Server Analysis Services | Creación y procesamiento del cubo OLAP. |
| 📐 MDX | Consultas analíticas sobre el cubo multidimensional. |
| 📗 Microsoft Excel | Dashboard analítico y validación de resultados. |
| 📊 Microsoft Power BI Desktop | Dashboard interactivo conectado al Data Warehouse. |
| 🌿 Git | Control de versiones. |
| 🐙 GitHub | Publicación y documentación del proyecto. |

---

# 📊 Estadísticas del proyecto

| Elemento | Cantidad |
|----------|---------:|
| 🗄️ Tablas OLTP | **5** |
| ⭐ Dimensiones | **4** |
| 📈 Tabla de hechos | **1** |
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

                 +-------------------------+
                 |     SalesIntel_OLTP     |
                 | Base de Datos Operacional|
                 +-------------------------+
                            │
                            ▼
                    Proceso ETL (SQL)
                            │
                            ▼
                 +-------------------------+
                 |      SalesIntel_DW      |
                 |     Data Warehouse       |
                 +-------------------------+
                      │               │
          ┌───────────┘               └────────────┐
          ▼                                        ▼
+----------------------+             +--------------------------+
| Reportes SQL         |             | Cubo Multidimensional    |
| (Views & SP)         |             | SQL Server Analysis      |
+----------------------+             | Services (SSAS)          |
          │                          +--------------------------+
          ▼                                   │
+----------------------+              ┌────────┴─────────┐
| Dashboard Excel      |              ▼                  ▼
+----------------------+      Consultas MDX      Power BI Dashboard
```

---

# 📂 Estructura del repositorio

```text
SalesIntel-DW
│
├── 📁 analysis-services
│   └── 📁 mdx
│       └── 06_Consultas_MDX_Cubo_SalesIntel.mdx
│
├── 📁 assets
│   └── 📁 screenshots
│
├── 📁 database
│   ├── 📁 01_model
│   ├── 📁 02_seed
│   ├── 📁 03_etl
│   ├── 📁 04_reports
│   └── 📁 05_cube
│
├── 📁 docs
│   ├── Evidencias.md
│   ├── Guia_Crear_Cubo_SalesIntel_DW.md
│   ├── Setup.md
│   └── logo.png
│
├── 📁 excel
│   └── SalesIntel_DW_Dashboard_Excel.xlsx
│
├── 📁 power-bi
│   └── SalesIntelDW.pbix
│
├── 📁 legacy
│
├── 📄 README.md
├── 📄 LICENSE
└── 📄 .gitignore
```

---

# ▶️ Orden de ejecución

Ejecutar los scripts desde **SQL Server Management Studio** respetando el siguiente orden:

```text
01_Crear_Modelo_SalesIntel_DW.sql

02_Insertar_Datos_Prueba_SalesIntel_DW.sql

03_ETL_Cargar_DW_SalesIntel.sql

04_Consultas_Reportes_SalesIntel.sql

05_Preparar_Cubo_SalesIntel.sql
```

Posteriormente:

1. 💻 Abrir el proyecto multidimensional en **Visual Studio**.
2. 🔗 Configurar el **Data Source** apuntando a `SalesIntel_DW`.
3. 🗂️ Crear el **Data Source View**.
4. 🧊 Construir el cubo `CuboVentasSalesIntel`.
5. ⚙️ Procesar el cubo.
6. 📐 Ejecutar las consultas MDX.
7. 📊 Abrir `SalesIntelDW.pbix`.
8. 🔄 Actualizar los datos del dashboard.

---

# ⭐ Modelo Data Warehouse

El proyecto implementa un **Data Warehouse** utilizando un **esquema estrella (Star Schema)** para optimizar el análisis multidimensional y el rendimiento de las consultas.

## 📌 Dimensiones

- 🏙️ `DimCiudad`
- 📦 `DimProducto`
- 👤 `DimCliente`
- 📅 `DimTiempo`

## 📈 Tabla de hechos

- 💰 `FactVentas`

La tabla de hechos almacena las principales métricas utilizadas por el cubo y los dashboards:

- 📦 Cantidad Vendida
- 💵 Precio Unitario
- 🏷️ Descuento
- 💰 Total Vendido

---

# 🔄 Proceso ETL

El proceso ETL realiza la extracción, transformación y carga de datos desde la base transaccional **SalesIntel_OLTP** hacia el Data Warehouse **SalesIntel_DW**.

## Flujo

```text
SalesIntel_OLTP
        │
        ▼
 Extracción de Datos
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

- 🔄 Transformación de registros.
- 🧹 Limpieza de datos.
- 🔑 Generación de claves sustitutas.
- 📅 Construcción de la dimensión Tiempo.
- 📊 Carga de la tabla de hechos.


---

# 🧊 Cubo Multidimensional (SSAS)

El proyecto incorpora un **cubo OLAP** desarrollado mediante **SQL Server Analysis Services (SSAS)**, permitiendo realizar análisis multidimensionales sobre la información almacenada en el Data Warehouse.

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

El cubo permite realizar análisis dinámicos desde SQL Server Analysis Services mediante consultas **MDX**, facilitando la exploración de la información desde diferentes perspectivas.

---

# 📗 Dashboard en Microsoft Excel

Como parte del proyecto académico original se desarrolló un dashboard utilizando **Microsoft Excel**, conectado al Data Warehouse.

## 📈 Incluye

- Indicadores generales.
- Ventas por ciudad.
- Ventas por producto.
- Ventas por año.
- Tablas dinámicas.
- Gráficos dinámicos.
- Reportes ejecutivos.

Archivo:

```text
excel/
└── SalesIntel_DW_Dashboard_Excel.xlsx
```

---

# 📊 Dashboard en Microsoft Power BI

Como mejora respecto al proyecto académico original, esta versión incorpora un dashboard desarrollado en **Microsoft Power BI Desktop**, conectado directamente al Data Warehouse.

## 📌 KPIs

- 📦 Cantidad Vendida
- 💰 Total Vendido
- 🏷️ Descuento Total
- 🧾 Total de Facturas
- 📈 Ticket Promedio

## 📈 Visualizaciones

- 🏙️ Ventas por Ciudad.
- 📦 Ventas por Producto.
- 📅 Ventas por Año.
- 📊 Ventas por Producto y Año.
- 📋 Reporte de los últimos tres meses.
- 📉 Indicadores ejecutivos.
- 🎯 KPIs.

## 🗄️ Fuente de datos

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

> Las siguientes imágenes corresponden al funcionamiento del sistema.

## 🏗️ Modelo Data Warehouse

```text
assets/screenshots/modelo_dw.png
```

---

## 🧊 Cubo SSAS

```text
assets/screenshots/cubo_ssas.png
```

---

## 📊 Dashboard Power BI

```text
assets/screenshots/dashboard_powerbi.png
```

---

## 📗 Dashboard Excel

```text
assets/screenshots/dashboard_excel.png
```

> **Nota:** Cuando captures las evidencias finales del proyecto, reemplaza estos bloques por imágenes reales utilizando Markdown.

Ejemplo:

```markdown
![Dashboard Power BI](assets/screenshots/dashboard_powerbi.png)
```

---

# 📈 Resultados obtenidos

La solución fue validada satisfactoriamente mediante consultas SQL, consultas MDX, el cubo OLAP y ambos dashboards.

| Métrica | Resultado |
|---------|----------:|
| 📦 Cantidad Vendida | **183** |
| 💰 Total Vendido | **222,995.00** |
| 🏷️ Descuento Total | **3,150.00** |
| 🧾 Total de Facturas | **22** |
| 📅 Ventas últimos 3 meses | **83,230.00** |

Los resultados fueron verificados mediante:

- ✅ Consultas SQL.
- ✅ Procedimientos almacenados.
- ✅ Consultas MDX.
- ✅ Cubo SQL Server Analysis Services.
- ✅ Dashboard en Microsoft Excel.
- ✅ Dashboard en Microsoft Power BI.

---

# 🔎 Consultas SQL destacadas

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

El repositorio incluye una colección de consultas **MDX** para validar y navegar el cubo multidimensional.

Archivo:

```text
analysis-services/
└── mdx/
    └── 06_Consultas_MDX_Cubo_SalesIntel.mdx
```

### Consultas disponibles

- 📊 Total general de ventas.
- 🏙️ Ventas por ciudad.
- 📦 Ventas por producto.
- 👤 Ventas por cliente.
- 📅 Ventas por año.
- 📆 Ventas por trimestre.
- 📆 Ventas por mes.
- 🏆 Top 5 ciudades.
- 🏆 Top 5 productos.
- 📈 Ventas por ciudad y producto.

---

# 📚 Conceptos aplicados

Durante el desarrollo de esta implementación se aplicaron conocimientos relacionados con:

- 📊 Business Intelligence (BI)
- ⭐ Data Warehouse
- ⭐ Modelado Dimensional
- ⭐ Esquema Estrella (Star Schema)
- 🔄 ETL (Extract, Transform & Load)
- 🗄️ SQL Server
- 🧊 SQL Server Analysis Services (SSAS)
- 📐 MDX (Multidimensional Expressions)
- 📗 Microsoft Excel
- 📊 Microsoft Power BI
- 📈 KPIs e Indicadores
- 📉 Dashboards Analíticos
- 📋 Reportes Gerenciales
- 🌿 Git
- 🐙 GitHub

---

# 🚀 Nueva implementación realizada en 2026

La versión publicada en este repositorio fue desarrollada completamente desde cero tomando como referencia únicamente el alcance y los objetivos académicos del proyecto original.

Durante esta nueva implementación se realizaron las siguientes mejoras:

- ✅ Reconstrucción completa del modelo transaccional.
- ✅ Diseño de un nuevo Data Warehouse.
- ✅ Implementación del esquema estrella.
- ✅ Organización profesional de los scripts SQL.
- ✅ Separación del proyecto por módulos.
- ✅ Implementación del proceso ETL.
- ✅ Construcción del Cubo OLAP.
- ✅ Desarrollo de consultas MDX.
- ✅ Creación del Dashboard en Excel.
- ✅ Incorporación de un Dashboard moderno en Power BI.
- ✅ Compatibilidad con SQL Server 2022.
- ✅ Documentación técnica completa.
- ✅ Organización del repositorio para GitHub.
- ✅ Integración de Git y control de versiones.
- ✅ Diseño de identidad visual y logotipo del proyecto.
- ✅ Optimización para portafolio profesional.

---

# 📋 Estado del proyecto

| Componente | Estado |
|------------|--------|
| 🗄️ Modelo OLTP | ✅ Completado |
| ⭐ Data Warehouse | ✅ Completado |
| 🔄 ETL | ✅ Completado |
| 🧊 Cubo SSAS | ✅ Completado |
| 📐 Consultas MDX | ✅ Completado |
| 📗 Dashboard Excel | ✅ Completado |
| 📊 Dashboard Power BI | ✅ Completado |
| 📑 Documentación | ✅ Completada |
| 🌿 GitHub | ✅ Publicado |

---

# 🎯 Competencias demostradas

Este proyecto evidencia experiencia práctica en:

- 🗄️ Diseño de Bases de Datos Relacionales.
- ⭐ Modelado Dimensional.
- 📊 Inteligencia de Negocios.
- 📈 Business Analytics.
- 🔄 Procesos ETL.
- 🧊 SQL Server Analysis Services.
- 📐 Consultas MDX.
- 📊 Visualización de Datos.
- 📗 Microsoft Excel.
- 📊 Microsoft Power BI.
- 📑 Documentación Técnica.
- 🌿 Control de Versiones con Git.
- 🐙 Publicación de proyectos en GitHub.

---

# 📜 Licencia

Este proyecto fue desarrollado originalmente con fines **académicos** para el **Instituto Tecnológico de las Américas (ITLA)**.

La versión publicada en este repositorio corresponde a una **nueva implementación desarrollada en 2026**, con fines educativos, demostrativos y como parte de un portafolio profesional.

El proyecto conserva la idea académica original, pero su arquitectura, organización, documentación, mejoras técnicas y presentación fueron desarrolladas nuevamente.

Consulta el archivo **LICENSE** para más información.

---

# 🙌 Agradecimientos

Agradecimientos especiales a:

- 🏫 Instituto Tecnológico de las Américas (ITLA).
- 👨‍🏫 Prof. Carlos Caraballo.
- 👥 Equipo del proyecto académico original.
- 💙 Microsoft SQL Server.
- 📊 Microsoft Power BI.
- 🧊 SQL Server Analysis Services.
- 🌎 Comunidad de Business Intelligence.

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
- 🤖 Inteligencia Artificial
- 🎮 Desarrollo de Videojuegos

---

<div align="center">

# 📊 SalesIntel DW

### Business Intelligence Platform

**SQL Server • Data Warehouse • ETL • SSAS • MDX • Excel • Power BI**

---

⭐ Si este proyecto fue de tu interés, considera darle una estrella al repositorio.

Desarrollado con fines académicos y como parte de un portafolio profesional.

**© 2026 • Francis Jairo Matías Rosario**

</div>