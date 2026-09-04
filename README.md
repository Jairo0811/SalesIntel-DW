<p align="center">
  <img src="docs/logo.jpeg" width="420" alt="SalesIntel DW Logo">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/ITLA-2017--C3-0057B8?style=for-the-badge" alt="ITLA 2017-C3">
  <img src="https://img.shields.io/badge/Status-Finalizado-success?style=for-the-badge" alt="Estado del proyecto">
  <img src="https://img.shields.io/badge/Reimplementación-2026-brightgreen?style=for-the-badge" alt="Reimplementación 2026">
</p>

<p align="center">
  <strong>Business Intelligence / Data Warehouse Portfolio Project</strong>
</p>

<p align="center">
  SQL Server • Data Warehouse • ETL • SSAS • MDX • Excel • Power BI
</p>

---

## 📖 Descripción

**SalesIntel DW** es una solución de **Business Intelligence (BI)** reimplementada completamente desde cero tomando como referencia un **proyecto final académico** realizado durante el **período 2017-C3** para la asignatura **Minería de Datos e Inteligencia de Negocios (SOF-014)** del **Instituto Tecnológico de las Américas (ITLA)**.

El proyecto académico original presentaba errores, incompatibilidades y una estructura difícil de mantener. En **2026** se creó una nueva implementación organizada, documentada y reproducible, conservando el objetivo académico original y transformándolo en una pieza de portafolio profesional enfocada en ingeniería de datos y analítica.

La solución implementa el flujo:

```text
SalesIntel_OLTP
      │
      ▼
 Staging / ETL
      │
      ▼
 SalesIntel_DW
   │        │
   │        ├────────► SSAS ───────► Cubo OLAP ───────► MDX
   │
   ├────────► Excel
   │
   └────────► Power BI
```

---

## 📌 Información del proyecto

| Información | Detalle |
|---|---|
| 🏫 Institución | Instituto Tecnológico de las Américas (ITLA) |
| 📘 Asignatura | Minería de Datos e Inteligencia de Negocios (SOF-014) |
| 👨‍🏫 Profesor | Carlos Caraballo |
| 📅 Período académico original | **2017-C3** |
| 👥 Modalidad | Proyecto Final Grupal |
| 🛠️ Reimplementación | **2026** |
| 🎯 Enfoque actual | Portafolio profesional de BI / Data Warehouse |
| 📌 Estado | ✅ Finalizado / Maintenance Mode |

### Integrantes del proyecto académico original

| Integrante | Matrícula |
|---|---|
| Francis Jairo Matías Rosario | **2015-2984** |
| John Christopher Adames Perez | **2015-2986** |

---

## ✨ Funcionalidades

- 🗄️ Modelo transaccional OLTP para ventas.
- ⭐ Data Warehouse con esquema estrella.
- 🔄 ETL para dimensiones y tabla de hechos.
- 📥 Staging y validación de productos procedentes de Excel.
- 🔑 Claves sustitutas para el modelo dimensional.
- 🏙️ Análisis por ciudad, producto, cliente y período.
- 📑 Vistas y procedimientos almacenados para reporting.
- 🧊 Capa multidimensional mediante SQL Server Analysis Services.
- 📐 Consultas MDX para exploración del cubo.
- 📗 Dashboard analítico en Microsoft Excel.
- 📊 Dashboard interactivo en Microsoft Power BI.
- 📈 KPIs ejecutivos de ventas.
- ✅ Validaciones SQL automatizadas con `THROW`.
- 📚 Documentación técnica, arquitectura y guía de reproducción.

---

## 🧰 Stack tecnológico

### Datos y ETL

- Microsoft SQL Server 2022.
- T-SQL.
- Modelo OLTP.
- Staging.
- ETL mediante scripts SQL.
- Esquema estrella.
- Vistas, procedimientos almacenados e índices analíticos.

### Análisis multidimensional

- SQL Server Analysis Services (SSAS Multidimensional).
- SQL Server Data Tools / Visual Studio.
- Data Source View.
- Cubo OLAP.
- MDX.

### Visualización

- Microsoft Excel.
- Microsoft Power BI Desktop.

### Ingeniería y documentación

- Git.
- GitHub.
- Markdown.
- Diagramas Mermaid.

---

## 📊 Estadísticas del proyecto

| Elemento | Cantidad |
|---|---:|
| 🗄️ Tablas OLTP | **5** |
| ⭐ Dimensiones | **4** |
| 📈 Tablas de hechos | **1** |
| 📥 Tablas de staging | **1** |
| 🧊 Cubos SSAS | **1** |
| 📐 Consultas MDX | **10** |
| 📑 Scripts SQL principales | **6** |
| 📊 Dashboards | **2** |
| 📋 Procedimientos almacenados | **2** |
| 👁️ Vistas analíticas / SSAS | **9** |

---

## 🏗️ Arquitectura

La solución mantiene separadas la operación transaccional y la lectura analítica:

```text
Fuentes OLTP / Excel
        │
        ▼
 Staging / Validación
        │
        ▼
       ETL
        │
        ▼
 SalesIntel_DW
   │     │      │
   │     │      └────► Vistas / Stored Procedures
   │     │
   │     └───────────► SSAS / Cubo / MDX
   │
   ├─────────────────► Excel
   └─────────────────► Power BI
```

Documentación detallada:

```text
docs/ARCHITECTURE.md
```

---

## ⭐ Modelo dimensional

### Dimensiones

- `DimCiudad`
- `DimProducto`
- `DimCliente`
- `DimTiempo`

### Tabla de hechos

- `FactVentas`

### Métricas principales

- Cantidad vendida.
- Precio unitario.
- Descuento.
- Total vendido.

La granularidad de `FactVentas` corresponde a cada detalle de factura y se preserva mediante `IdDetalleFactura` único.

---

## 🔄 ETL

El proceso ETL carga información desde `SalesIntel_OLTP` hacia `SalesIntel_DW`.

```text
SalesIntel_OLTP
        │
        ▼
 Extracción
        │
        ▼
 Transformación
        │
        ▼
 Dimensiones
        │
        ▼
 FactVentas
        │
        ▼
 SalesIntel_DW
```

Incluye:

- limpieza de datos;
- construcción de claves sustitutas;
- carga de dimensiones;
- construcción de `DimTiempo`;
- staging de productos externos;
- validación de duplicados;
- carga de hechos;
- consultas de comprobación.

> El ETL actual está diseñado como una implementación reproducible de laboratorio/portafolio mediante recarga completa. Cargas incrementales, CDC, SCD, orquestación y observabilidad quedan fuera del alcance de esta versión académica-profesional.

---

## 📑 Reporting SQL

El Data Warehouse publica vistas reutilizables para Excel, Power BI, SSRS o consultas directas:

```text
vw_VentasDetalleDW
vw_VentasPorCiudad
vw_VentasProductoAnio
vw_VentasUltimos3MesesProductoCiudad
```

Procedimientos almacenados:

```text
sp_ReporteVentasUltimos3MesesProductoCiudad
sp_ReporteVentasPorRangoFecha
```

---

## 🧊 SQL Server Analysis Services

El modelo prepara cinco vistas específicas para el Data Source View:

```text
vw_Cubo_DimProducto
vw_Cubo_DimCiudad
vw_Cubo_DimCliente
vw_Cubo_DimTiempo
vw_Cubo_FactVentas
```

Cubo:

```text
CuboVentasSalesIntel
```

Dimensiones:

- Producto.
- Ciudad.
- Cliente.
- Tiempo.

Medidas principales:

- Total Vendido.
- Cantidad Vendida.
- Descuento.
- Precio Unitario.

Las consultas MDX están versionadas en:

```text
analysis-services/mdx/06_Consultas_MDX_Cubo_SalesIntel.mdx
```

La política de reproducibilidad y exportación de archivos generados por SSDT está documentada en:

```text
analysis-services/README.md
```

---

## 📗 Dashboard de Excel

Archivo:

```text
excel/SalesIntel_DW_Dashboard_Excel.xlsx
```

Incluye indicadores generales, ventas por ciudad, ventas por producto, gráficos dinámicos y análisis ejecutivo.

---

## 📊 Dashboard de Power BI

Archivo:

```text
power-bi/SalesIntelDW.pbix
```

KPIs principales:

- Cantidad Vendida.
- Total Vendido.
- Descuento Total.
- Total de Facturas.
- Ticket Promedio.

Power BI consume principalmente:

```text
vw_VentasDetalleDW
vw_VentasPorCiudad
vw_VentasProductoAnio
vw_VentasUltimos3MesesProductoCiudad
```

---

## ✅ Validaciones automatizadas

La fase final de portfolio hardening incorpora pruebas SQL ejecutables:

```text
database/06_tests/06_Validaciones_Portfolio.sql
```

Comprueban:

- integridad entre hechos y dimensiones;
- unicidad de claves de negocio;
- granularidad de `FactVentas`;
- KPIs del dataset versionado;
- existencia de vistas y procedimientos de reporting;
- existencia de vistas requeridas por SSAS.

El script utiliza `THROW`, por lo que una inconsistencia detiene la ejecución como un fallo real.

### KPIs esperados

| Métrica | Resultado |
|---|---:|
| 📦 Cantidad Vendida | **183** |
| 💰 Total Vendido | **222,995.00** |
| 🏷️ Descuento Total | **3,150.00** |
| 🧾 Total de Facturas | **22** |

---

## ▶️ Orden de ejecución

En SQL Server Management Studio:

```text
01_Crear_Modelo_SalesIntel_DW.sql
02_Insertar_Datos_Prueba_SalesIntel_DW.sql
03_ETL_Cargar_DW_SalesIntel.sql
04_Consultas_Reportes_SalesIntel.sql
05_Preparar_Cubo_SalesIntel.sql
06_Validaciones_Portfolio.sql
```

Después:

1. Crear/procesar el cubo `CuboVentasSalesIntel` en Visual Studio/SSDT.
2. Ejecutar las consultas MDX.
3. Abrir y actualizar el dashboard de Excel.
4. Abrir y actualizar `SalesIntelDW.pbix`.
5. Capturar las evidencias visuales finales.

Guía completa:

```text
docs/Setup.md
```

---

## 📸 Evidencias de portafolio

La carpeta:

```text
assets/screenshots/
```

está reservada para evidencias capturadas desde un entorno local real.

Las capturas mínimas y sus criterios están definidos en:

```text
docs/Evidencias.md
```

No se publican enlaces a imágenes inexistentes. Las evidencias requieren SQL Server Management Studio, Visual Studio/SSDT, SSAS, Excel y Power BI Desktop ejecutándose localmente.

---

## 📂 Estructura del repositorio

```text
SalesIntel-DW
│
├── analysis-services
│   ├── README.md
│   └── mdx
│       └── 06_Consultas_MDX_Cubo_SalesIntel.mdx
│
├── assets
│   └── screenshots
│
├── database
│   ├── 01_model
│   ├── 02_seed
│   ├── 03_etl
│   ├── 04_reports
│   ├── 05_cube
│   └── 06_tests
│       └── 06_Validaciones_Portfolio.sql
│
├── docs
│   ├── ARCHITECTURE.md
│   ├── Evidencias.md
│   ├── Guia_Crear_Cubo_SalesIntel_DW.md
│   ├── PORTFOLIO_HARDENING.md
│   ├── Setup.md
│   └── logo.jpeg
│
├── excel
│   └── SalesIntel_DW_Dashboard_Excel.xlsx
│
├── power-bi
│   └── SalesIntelDW.pbix
│
├── legacy
│
├── CHANGELOG.md
├── LICENSE
├── README.md
└── .gitignore
```

---

## 🚀 Reimplementación y modernización 2026

La nueva implementación incorporó:

- reconstrucción del modelo transaccional;
- nuevo Data Warehouse;
- esquema estrella;
- staging y ETL;
- consultas y reporting reutilizable;
- preparación y documentación de SSAS;
- consultas MDX;
- dashboard Excel;
- dashboard Power BI;
- compatibilidad con SQL Server 2022;
- documentación de arquitectura;
- pruebas SQL automatizadas;
- control de versiones;
- identidad visual;
- portfolio hardening.

---

## 📋 Estado del proyecto

| Componente | Estado |
|---|---|
| 🗄️ Modelo OLTP | ✅ Completado |
| ⭐ Data Warehouse | ✅ Completado |
| 🔄 ETL | ✅ Completado |
| 📑 Reporting SQL | ✅ Completado |
| 🧊 Capa SSAS / guía reproducible | ✅ Completada |
| 📐 Consultas MDX | ✅ Completadas |
| 📗 Dashboard Excel | ✅ Completado |
| 📊 Dashboard Power BI | ✅ Completado |
| ✅ Validaciones SQL | ✅ Completadas |
| 📚 Documentación | ✅ Completada |
| 📸 Evidencias visuales | ⏳ Captura local pendiente |

### Maintenance Mode

SalesIntel DW se considera **funcionalmente finalizado** como proyecto de portafolio. Nuevas funcionalidades solo deberían añadirse si existe un caso de negocio concreto o si mejoran directamente su reproducibilidad, evidencia o mantenimiento.

---

## 🎯 Competencias demostradas

Este proyecto evidencia experiencia práctica en:

- diseño de bases de datos relacionales;
- SQL Server y T-SQL;
- modelado dimensional;
- esquemas estrella;
- Business Intelligence;
- Data Warehousing;
- ETL y staging;
- SQL Server Analysis Services;
- MDX;
- KPIs y reporting ejecutivo;
- Microsoft Excel;
- Microsoft Power BI;
- validación de calidad de datos;
- documentación técnica;
- Git y GitHub.

---

## 💼 Posicionamiento

SalesIntel DW no se plantea como un SaaS independiente. Su valor principal es demostrar capacidades técnicas para proyectos de:

- Business Intelligence;
- Data Warehouse;
- integración y transformación de datos;
- modelado analítico;
- dashboards Power BI;
- reporting gerencial.

Puede utilizarse como demostrador técnico para servicios personalizados de BI y analítica empresarial.

---

## 📚 Documentación

- `docs/ARCHITECTURE.md` — arquitectura técnica.
- `docs/Setup.md` — instalación y orden de ejecución.
- `docs/Guia_Crear_Cubo_SalesIntel_DW.md` — construcción del cubo.
- `analysis-services/README.md` — reproducibilidad SSAS.
- `docs/Evidencias.md` — evidencias visuales requeridas.
- `docs/PORTFOLIO_HARDENING.md` — criterio de cierre del proyecto.
- `CHANGELOG.md` — historial de hitos.

---

## 📜 Licencia

La implementación publicada corresponde a una nueva versión desarrollada en 2026 con fines educativos, demostrativos y de portafolio profesional.

Consulta [`LICENSE`](LICENSE) para los términos aplicables.

---

## 🙌 Agradecimientos

- Instituto Tecnológico de las Américas (ITLA).
- Prof. Carlos Caraballo.
- Equipo del proyecto académico original.
- Comunidad de SQL Server y Power BI.

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
