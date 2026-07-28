<h1 align="center">📊 SalesIntel DW</h1>

<p align="center">
  <img src="docs/logo.png" width="230" alt="SalesIntel DW Logo">
</p>

<p align="center">
  <strong>Business Intelligence Platform</strong>
</p>

<p align="center">
  SQL Server • Data Warehouse • ETL • SSAS • MDX • Excel • Power BI
</p>

<p align="center">
  <img src="https://img.shields.io/badge/ITLA-2017--C3-0057B8?style=for-the-badge" alt="ITLA 2017-C3">
  <img src="https://img.shields.io/badge/Status-Finalizado-success?style=for-the-badge" alt="Estado del proyecto">
  <img src="https://img.shields.io/badge/Reimplementación-2026-brightgreen?style=for-the-badge" alt="Reimplementación 2026">
</p>

---

## 📖 Descripción

**SalesIntel DW** es una solución de **Business Intelligence (BI)** reimplementada completamente desde cero tomando como referencia un **proyecto final académico** realizado durante el **período académico 2017-C3** para la asignatura **Minería de Datos e Inteligencia de Negocios (SOF-014)** del **Instituto Tecnológico de las Américas (ITLA)**.

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

| Información | Detalle |
|-------------|---------|
| 🏫 Institución | Instituto Tecnológico de las Américas (ITLA) |
| 📘 Asignatura | Minería de Datos e Inteligencia de Negocios (SOF-014) |
| 👨‍🏫 Profesor | Carlos Caraballo |
| 📅 Período | **2017-C3** |
| 👥 Modalidad | Proyecto Final Grupal |
| 🛠️ Reimplementación | 2026 |
| 📌 Estado | ✅ Finalizado |

---

## 👥 Integrantes del proyecto académico original

| Integrante | Matrícula |
|------------|-----------|
| 👤 Francis Jairo Matías Rosario | **2015-2984** |
| 👤 Jhon Christopher Adames Perez | **2015-2986** |

---

## ✨ Funcionalidades

- 🗄️ Modelo OLTP para la gestión de ventas.
- ⭐ Data Warehouse con esquema estrella.
- 🔄 Procesos ETL para dimensiones y tabla de hechos.
- 📥 Importación y validación de productos desde Excel.
- 🏙️ Análisis por ciudad, producto, cliente y período.
- 🧊 Cubo OLAP mediante SQL Server Analysis Services.
- 📐 Consultas multidimensionales mediante MDX.
- 📑 Reportes SQL mediante vistas y procedimientos almacenados.
- 📗 Dashboard analítico en Microsoft Excel.
- 📊 Dashboard interactivo en Microsoft Power BI.
- 📈 Indicadores y KPIs de ventas.
- 📚 Documentación técnica del proceso completo.

---

## 🧰 Stack tecnológico

### 📥 Integración y procesos ETL

<p>
  <img src="https://img.shields.io/badge/ETL-SQL-CC2927?style=flat-square&logo=microsoftsqlserver&logoColor=white" alt="ETL con SQL" />
  <img src="https://img.shields.io/badge/Staging-Data%20Processing-1F4E79?style=flat-square&logo=databricks&logoColor=white" alt="Staging y procesamiento de datos" />
</p>

- Scripts SQL para extracción, transformación y carga.
- Área de staging para importación y validación de datos.
- Limpieza, transformación y generación de claves sustitutas.
- Carga de dimensiones y de la tabla de hechos.

### 🏛️ Data Warehouse y almacenamiento

<p>
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/microsoftsqlserver/microsoftsqlserver-plain.svg" alt="Microsoft SQL Server" width="48" height="48" />
  <img src="https://img.shields.io/badge/Star%20Schema-Data%20Warehouse-1F4E79?style=flat-square&logo=databricks&logoColor=white" alt="Esquema estrella" />
</p>

- Microsoft SQL Server 2022.
- Modelo transaccional OLTP.
- Data Warehouse con esquema estrella.
- Dimensiones, tabla de hechos, vistas y procedimientos almacenados.

### 🧊 Análisis multidimensional

<p>
  <img src="https://img.shields.io/badge/SSAS-Analysis%20Services-5C2D91?style=flat-square&logo=microsoft&logoColor=white" alt="SQL Server Analysis Services" />
  <img src="https://img.shields.io/badge/MDX-Multidimensional%20Queries-5C2D91?style=flat-square&logo=microsoft&logoColor=white" alt="MDX" />
</p>

- SQL Server Analysis Services.
- Cubo OLAP multidimensional.
- Consultas analíticas mediante MDX.
- Medidas, dimensiones y navegación multidimensional.

### 📈 Visualización y análisis de datos

<p>
  <img src="https://img.shields.io/badge/Power%20BI-Desktop-F2C811?style=flat-square&logo=powerbi&logoColor=black" alt="Power BI Desktop" />
  <img src="https://img.shields.io/badge/Microsoft%20Excel-Dashboard-217346?style=flat-square&logo=microsoftexcel&logoColor=white" alt="Microsoft Excel" />
</p>

- Microsoft Power BI Desktop.
- Microsoft Excel.
- Dashboards ejecutivos, KPIs y reportes analíticos.
- Visualizaciones por ciudad, producto, cliente y período.

### 🧰 Herramientas de desarrollo

<p>
  <img src="https://skillicons.dev/icons?i=visualstudio,git,github" alt="Visual Studio, Git y GitHub" />
</p>

- Visual Studio.
- SQL Server Data Tools.
- SQL Server Management Studio.
- Git y GitHub.

---

## 📊 Estadísticas del proyecto

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

## 🏗️ Arquitectura de la solución

```text
SalesIntel_OLTP
      │
      ▼
  Proceso ETL
      │
      ▼
 SalesIntel_DW
   │        │
   │        ├────────► Cubo SSAS ───────► Consultas MDX
   │
   ├────────► Dashboard Excel
   │
   └────────► Dashboard Power BI
```

---

## 📂 Estructura del repositorio

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

## ▶️ Orden de ejecución

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

## ⭐ Modelo Data Warehouse

El proyecto implementa un **Data Warehouse** utilizando un **esquema estrella (Star Schema)** para optimizar el análisis multidimensional y el rendimiento de las consultas.

### 📌 Dimensiones

- 🏙️ `DimCiudad`
- 📦 `DimProducto`
- 👤 `DimCliente`
- 📅 `DimTiempo`

### 📈 Tabla de hechos

- 💰 `FactVentas`

La tabla de hechos almacena las principales métricas utilizadas por el cubo y los dashboards:

- 📦 Cantidad Vendida
- 💵 Precio Unitario
- 🏷️ Descuento
- 💰 Total Vendido

---

## 🔄 Proceso ETL

El proceso ETL realiza la extracción, transformación y carga de datos desde la base transaccional **SalesIntel_OLTP** hacia el Data Warehouse **SalesIntel_DW**.

### Flujo

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

## 🧊 Cubo multidimensional (SSAS)

El proyecto incorpora un **cubo OLAP** desarrollado mediante **SQL Server Analysis Services (SSAS)**, permitiendo realizar análisis multidimensionales sobre la información almacenada en el Data Warehouse.

### 📦 Nombre del cubo

```text
CuboVentasSalesIntel
```

### 📊 Medidas

- 💰 Total Vendido
- 📦 Cantidad Vendida
- 🏷️ Descuento
- 💵 Precio Unitario

### 🧭 Dimensiones

- 📦 Producto
- 🏙️ Ciudad
- 👤 Cliente
- 📅 Tiempo

El cubo permite realizar análisis dinámicos mediante consultas **MDX**, facilitando la exploración de la información desde distintas perspectivas.

---

## 📗 Dashboard en Microsoft Excel

Como parte del proyecto académico original se desarrolló un dashboard utilizando **Microsoft Excel**, conectado al Data Warehouse.

### 📈 Incluye

- Indicadores generales.
- Ventas por ciudad.
- Ventas por producto.
- Gráficos dinámicos.
- Reportes ejecutivos.

Archivo:

```text
excel/
└── SalesIntel_DW_Dashboard_Excel.xlsx
```

---

## 📊 Dashboard en Microsoft Power BI

Como mejora respecto al proyecto académico original, esta versión incorpora un dashboard desarrollado en **Microsoft Power BI Desktop**, conectado directamente al Data Warehouse.

### 📌 KPIs

- 📦 Cantidad Vendida
- 💰 Total Vendido
- 🏷️ Descuento Total
- 🧾 Total de Facturas
- 📈 Ticket Promedio

### 📈 Visualizaciones

- 🏙️ Ventas por Ciudad.
- 📦 Ventas por Producto.
- 📅 Ventas por Año.
- 📊 Ventas por Producto y Año.
- 📋 Reporte de los últimos tres meses.
- 📉 Indicadores ejecutivos.
- 🎯 KPIs.

### 🗄️ Fuente de datos

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

## 📸 Galería del proyecto

> Las siguientes rutas corresponden a las evidencias preparadas para documentar el funcionamiento del sistema.

- 🏗️ Modelo Data Warehouse: `assets/screenshots/modelo_dw.png`
- 🧊 Cubo SSAS: `assets/screenshots/cubo_ssas.png`
- 📊 Dashboard Power BI: `assets/screenshots/dashboard_powerbi.png`
- 📗 Dashboard Excel: `assets/screenshots/dashboard_excel.png`

---

## 📈 Resultados obtenidos

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

## 🔎 Consultas SQL destacadas

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

### 📅 Reporte de los últimos tres meses

```sql
EXEC dbo.sp_ReporteVentasUltimos3MesesProductoCiudad;
```

---

## 📐 Consultas MDX

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

## 📚 Conceptos aplicados

Durante el desarrollo de esta implementación se aplicaron conocimientos relacionados con:

- 📊 Business Intelligence (BI)
- ⭐ Data Warehouse
- ⭐ Modelado dimensional
- ⭐ Esquema estrella (Star Schema)
- 🔄 ETL (Extract, Transform & Load)
- 🗄️ SQL Server
- 🧊 SQL Server Analysis Services (SSAS)
- 📐 MDX (Multidimensional Expressions)
- 📗 Microsoft Excel
- 📊 Microsoft Power BI
- 📈 KPIs e indicadores
- 📉 Dashboards analíticos
- 📋 Reportes gerenciales
- 🌿 Git
- 🐙 GitHub

---

## 🚀 Reimplementación y modernización (2026)

La versión publicada en este repositorio fue desarrollada completamente desde cero tomando como referencia únicamente el alcance y los objetivos académicos del proyecto original.

Durante esta nueva implementación se realizaron las siguientes mejoras:

- ✅ Reconstrucción completa del modelo transaccional.
- ✅ Diseño de un nuevo Data Warehouse.
- ✅ Implementación del esquema estrella.
- ✅ Organización profesional de los scripts SQL.
- ✅ Separación del proyecto por módulos.
- ✅ Implementación del proceso ETL.
- ✅ Construcción del cubo OLAP.
- ✅ Desarrollo de consultas MDX.
- ✅ Creación del dashboard en Excel.
- ✅ Incorporación de un dashboard moderno en Power BI.
- ✅ Compatibilidad con SQL Server 2022.
- ✅ Documentación técnica completa.
- ✅ Organización del repositorio para GitHub.
- ✅ Integración de Git y control de versiones.
- ✅ Diseño de identidad visual y logotipo del proyecto.
- ✅ Optimización para portafolio profesional.

---

## 📋 Estado del proyecto

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

## 🎯 Competencias demostradas

Este proyecto evidencia experiencia práctica en:

- 🗄️ Diseño de bases de datos relacionales.
- ⭐ Modelado dimensional.
- 📊 Inteligencia de negocios.
- 📈 Business Analytics.
- 🔄 Procesos ETL.
- 🧊 SQL Server Analysis Services.
- 📐 Consultas MDX.
- 📊 Visualización de datos.
- 📗 Microsoft Excel.
- 📊 Microsoft Power BI.
- 📑 Documentación técnica.
- 🌿 Control de versiones con Git.
- 🐙 Publicación de proyectos en GitHub.

---

## 📜 Licencia

Este proyecto fue desarrollado originalmente con fines **académicos** para el **Instituto Tecnológico de las Américas (ITLA)**.

La versión publicada en este repositorio corresponde a una **nueva implementación desarrollada en 2026**, con fines educativos, demostrativos y como parte de un portafolio profesional.

El proyecto conserva la idea académica original, pero su arquitectura, organización, documentación, mejoras técnicas y presentación fueron desarrolladas nuevamente.

Consulta el archivo [`LICENSE`](LICENSE) para más información.

---

## 🙌 Agradecimientos

- 🏫 Instituto Tecnológico de las Américas (ITLA).
- 👨‍🏫 Prof. Carlos Caraballo.
- 👥 Equipo del proyecto académico original.
- 💙 Comunidad de SQL Server y Power BI.

---

## 👨‍💻 Autor

### Francis Jairo Matías Rosario

**Tecnólogo en Desarrollo de Software**  
**Estudiante de Ingeniería de Software**

### 🌐 Portafolio

[GitHub — Jairo0811](https://github.com/Jairo0811)

---

<p align="center">
  ⭐ Si este proyecto te resultó útil o interesante, considera darle una estrella al repositorio.
</p>

<p align="center">
  Desarrollado por <strong>Francis Jairo Matías Rosario</strong> · 2026
</p>
