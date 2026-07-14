# 📊 SalesIntel DW

<p align="center">
  <img src="docs/logo.png" width="260" alt="SalesIntel DW Logo">
</p>

<p align="center">
  <img src="https://skillicons.dev/icons?i=visualstudio,git,github" alt="Tecnologías utilizadas" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/SQL%20Server-2022-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white"/>
  <img src="https://img.shields.io/badge/SSAS-Analysis%20Services-5C2D91?style=for-the-badge&logo=microsoft&logoColor=white"/>
  <img src="https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=for-the-badge&logo=powerbi&logoColor=black"/>
  <img src="https://img.shields.io/badge/Excel-Dashboard-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white"/>
</p>

<p align="center">
  <strong>SQL Server · Data Warehouse · ETL · SSAS · MDX · Excel · Power BI</strong>
</p>

---

## 📖 Descripción

**SalesIntel DW** es una solución de **Business Intelligence** desarrollada desde cero tomando como referencia un proyecto final académico realizado originalmente en **2017** para la asignatura **Minería de Datos e Inteligencia de Negocios (SOF-014)** del **Instituto Tecnológico de las Américas (ITLA)**.

El proyecto original presentaba múltiples errores, incompatibilidades y una estructura difícil de mantener. Por esta razón, en **2026** se creó una nueva implementación completa, organizada y documentada, conservando la idea académica original y modernizándola para formar parte de un portafolio profesional.

La solución cubre el flujo completo de análisis de ventas:

- Base de datos transaccional.
- Data Warehouse en esquema estrella.
- Procesos ETL.
- Cubo multidimensional con SQL Server Analysis Services.
- Consultas MDX.
- Dashboard analítico en Excel.
- Dashboard interactivo en Power BI.

---

# 📌 Información del proyecto

- 📘 **Materia:** Minería de Datos e Inteligencia de Negocios (SOF-014)
- 👨‍🏫 **Profesor:** Carlos Caraballo
- 🏫 **Institución:** Instituto Tecnológico de las Américas (ITLA)
- 📅 **Período académico original:** 2017-C3
- 🛠️ **Nueva implementación y documentación:** 2026
- ✅ **Estado:** Finalizado

---

# 👥 Integrantes del proyecto académico original

| Integrante | Matrícula |
|------------|-----------|
| 👤 Francis Jairo Matías Rosario | **2015-2984** |
| 👤 Jhon Christopher Adames Perez | **2015-2986** |

---

# ✨ Funcionalidades

- 🗄️ Modelo transaccional OLTP para la gestión de ventas.
- ⭐ Data Warehouse diseñado con esquema estrella.
- 🔄 Carga ETL de dimensiones y tabla de hechos.
- 📥 Importación y validación de productos desde Excel.
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

---

# 🏗️ Arquitectura

```text
SalesIntel_OLTP
      │
      ▼
Proceso ETL
      │
      ▼
SalesIntel_DW
      │
      ├──────────────► Reportes SQL
      │                    │
      │                    ▼
      │             Dashboard Excel
      │
      └──────────────► Cubo SSAS
                           │
                           ├────────► Consultas MDX
                           │
                           └────────► Dashboard Power BI
```

---

# ⭐ Modelo Data Warehouse

El Data Warehouse utiliza un **esquema estrella** compuesto por cuatro dimensiones y una tabla de hechos.

## 📌 Dimensiones

- `DimProducto`
- `DimCiudad`
- `DimCliente`
- `DimTiempo`

## 📈 Tabla de hechos

- `FactVentas`

## 📊 Métricas principales

- Cantidad vendida.
- Precio unitario.
- Descuento.
- Total vendido.

---

# 🧊 Cubo multidimensional

El proyecto incluye un cubo OLAP desarrollado con **SQL Server Analysis Services**.

```text
CuboVentasSalesIntel
```

## Medidas

- Total Vendido.
- Cantidad Vendida.
- Descuento.
- Precio Unitario.

## Dimensiones

- Producto.
- Ciudad.
- Cliente.
- Tiempo.

---

# 📊 Dashboard en Power BI

El dashboard de Power BI consume vistas analíticas preparadas dentro del Data Warehouse:

```text
vw_VentasDetalleDW
vw_VentasPorCiudad
vw_VentasProductoAnio
vw_VentasUltimos3MesesProductoCiudad
```

Incluye:

- KPI de cantidad vendida.
- KPI de descuento total.
- KPI de total de facturas.
- KPI de total vendido.
- Ventas por ciudad.
- Ventas por producto.
- Ventas por producto y año.
- Ventas de los últimos tres meses.

Archivo principal:

```text
power-bi/SalesIntelDW.pbix
```

---

# 📗 Dashboard en Excel

El dashboard en Excel permite consultar y visualizar:

- Indicadores generales.
- Ventas por ciudad.
- Ventas por producto y año.
- Reporte de los últimos tres meses.
- Datos detallados del Data Warehouse.

Archivo principal:

```text
excel/SalesIntel_DW_Dashboard_Excel.xlsx
```

---

# 🧰 Tecnologías utilizadas

<p align="center">
  <img src="https://skillicons.dev/icons?i=visualstudio,git,github" alt="Tecnologías utilizadas" />
</p>

- 🗄️ Microsoft SQL Server 2022
- 🧰 SQL Server Management Studio
- 💻 Visual Studio
- 🧩 SQL Server Data Tools
- 🧊 SQL Server Analysis Services
- 📐 MDX
- 📗 Microsoft Excel
- 📊 Microsoft Power BI Desktop
- 🌿 Git
- 🐙 GitHub

---

# ▶️ Ejecución

Ejecutar los scripts desde **SQL Server Management Studio** respetando el siguiente orden:

```text
01_Crear_Modelo_SalesIntel_DW.sql
02_Insertar_Datos_Prueba_SalesIntel_DW.sql
03_ETL_Cargar_DW_SalesIntel.sql
04_Consultas_Reportes_SalesIntel.sql
05_Preparar_Cubo_SalesIntel.sql
```

Luego:

1. Abrir el proyecto multidimensional en **Visual Studio**.
2. Configurar el origen de datos hacia `SalesIntel_DW`.
3. Crear o actualizar la vista del origen de datos.
4. Procesar el cubo `CuboVentasSalesIntel`.
5. Validar las consultas MDX.
6. Abrir `power-bi/SalesIntelDW.pbix`.
7. Actualizar los datos del dashboard.

---

# 📂 Estructura del proyecto

```text
SalesIntel-DW/
├── analysis-services/
│   └── mdx/
├── assets/
│   └── screenshots/
├── database/
│   ├── 01_model/
│   ├── 02_seed/
│   ├── 03_etl/
│   ├── 04_reports/
│   └── 05_cube/
├── docs/
│   ├── Evidencias.md
│   ├── Guia_Crear_Cubo_SalesIntel_DW.md
│   ├── Setup.md
│   └── logo.jpeg
├── excel/
├── legacy/
├── power-bi/
├── .gitignore
├── LICENSE
└── README.md
```

---

# ✅ Resultados validados

| Métrica | Resultado |
|---------|----------:|
| 📦 Cantidad vendida | **183** |
| 🏷️ Descuento total | **3,150.00** |
| 🧾 Total de facturas | **22** |
| 💰 Total vendido | **222,995.00** |
| 🕒 Ventas últimos 3 meses | **83,230.00** |

Los resultados fueron comprobados mediante consultas SQL, consultas MDX, el cubo SSAS, Excel y Power BI.

---

# 🛠️ Implementación realizada en 2026

Durante la creación de esta nueva versión se realizaron las siguientes mejoras:

- ✅ Rediseño completo del modelo transaccional.
- ✅ Construcción del Data Warehouse desde cero.
- ✅ Implementación del esquema estrella.
- ✅ Organización de scripts por etapas.
- ✅ Creación del proceso ETL.
- ✅ Preparación de vistas analíticas.
- ✅ Creación y procesamiento del cubo SSAS.
- ✅ Documentación de consultas MDX.
- ✅ Creación del dashboard en Excel.
- ✅ Incorporación de un dashboard moderno en Power BI.
- ✅ Compatibilidad con SQL Server 2022.
- ✅ Limpieza y estandarización de nombres.
- ✅ Configuración de `.gitignore`.
- ✅ Organización profesional del repositorio.
- ✅ Publicación y documentación en GitHub.

---

# 📜 Licencia

Este proyecto se publica con fines **académicos, educativos y de portafolio profesional**.

La idea base proviene del proyecto final grupal desarrollado en **2017**, mientras que la implementación, estructura, documentación y modernización publicadas en este repositorio fueron realizadas nuevamente en **2026**.

Consulta el archivo [`LICENSE`](LICENSE) para más información.

---

# 🙌 Agradecimientos

- 🏫 Instituto Tecnológico de las Américas (ITLA).
- 👨‍🏫 Prof. Carlos Caraballo.
- 👥 Equipo del proyecto académico original.
- 💙 Comunidad de SQL Server y Power BI.

---

> **Proyecto académico original de 2017, desarrollado nuevamente desde cero y modernizado en 2026 para preservar su valor histórico y convertirlo en una pieza profesional de portafolio.**
