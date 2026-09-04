# SQL Server Analysis Services

Esta carpeta contiene los artefactos versionables relacionados con la capa multidimensional de **SalesIntel DW**.

## Estado actual

El repositorio conserva en control de versiones:

- las vistas SQL que sirven como origen del cubo;
- las relaciones esperadas del Data Source View;
- la guía detallada de construcción del cubo;
- las consultas MDX de validación y navegación.

El cubo se crea con **SQL Server Analysis Services Multidimensional** desde Visual Studio/SSDT utilizando la guía `docs/Guia_Crear_Cubo_SalesIntel_DW.md`.

## Fuente de datos

Base de datos:

```text
SalesIntel_DW
```

Vistas destinadas al Data Source View:

```text
vw_Cubo_DimProducto
vw_Cubo_DimCiudad
vw_Cubo_DimCliente
vw_Cubo_DimTiempo
vw_Cubo_FactVentas
```

## Cubo esperado

```text
CuboVentasSalesIntel
```

### Dimensiones

- Producto
- Ciudad
- Cliente
- Tiempo

### Medidas principales

- Cantidad Vendida
- Total Vendido
- Descuento
- Precio Unitario

## Consultas MDX

Las consultas de validación están versionadas en:

```text
analysis-services/mdx/06_Consultas_MDX_Cubo_SalesIntel.mdx
```

## Reproducibilidad

Para reconstruir la capa multidimensional:

1. Ejecutar los scripts `database/01_model` a `database/05_cube`.
2. Crear un proyecto multidimensional de Analysis Services en Visual Studio.
3. Conectar el Data Source a `SalesIntel_DW`.
4. Agregar las cinco vistas `vw_Cubo_*` al Data Source View.
5. Configurar las relaciones descritas en `docs/Setup.md`.
6. Crear y procesar `CuboVentasSalesIntel`.
7. Ejecutar las consultas MDX versionadas.
8. Capturar las evidencias indicadas en `docs/Evidencias.md`.

## Nota sobre archivos generados por SSDT

No se incluyen archivos `.dwproj`, `.cube`, `.dim`, `.dsv` o `.ds` escritos manualmente. Esos metadatos deben exportarse desde una instancia real de Visual Studio/SSDT después de validar el cubo, evitando publicar definiciones XML no verificadas como si fueran un proyecto ejecutable.

Cuando se exporte el proyecto real, la estructura recomendada es:

```text
analysis-services/
├── README.md
├── mdx/
│   └── 06_Consultas_MDX_Cubo_SalesIntel.mdx
└── SalesIntel_DW_Cubo/
    ├── SalesIntel_DW_Cubo.dwproj
    ├── *.ds
    ├── *.dsv
    ├── *.dim
    └── *.cube
```

Hasta ese momento, la guía y las consultas MDX constituyen la fuente reproducible y verificable de la capa SSAS dentro del repositorio.
