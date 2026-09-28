# SQL Server Analysis Services

Esta carpeta contiene la capa multidimensional real de **SalesIntel DW**.

## Estado actual

El repositorio incluye y valida:

- el proyecto SSDT multidimensional real importado desde una instancia funcional de SSAS;
- el Data Source conectado a `SalesIntel_DW`;
- el Data Source View basado en las cinco vistas `vw_Cubo_*`;
- cuatro dimensiones: Producto, Ciudad, Cliente y Tiempo;
- el cubo `CuboVentasSalesIntel`;
- la partición `FactVentas`;
- scripts PowerShell para reconstrucción y smoke test;
- consultas MDX de validación y navegación.

El cubo fue creado y procesado correctamente en una instancia local de **SQL Server Analysis Services Multidimensional** y luego importado desde el servidor a Visual Studio/SSDT para versionar artefactos reales, no XML escrito manualmente.

## Proyecto SSDT

Ruta:

```text
analysis-services/SalesIntel_DW_Cubo/
```

Estructura principal:

```text
SalesIntel_DW_Cubo/
├── SalesIntel_DW_Cubo.slnx
└── SalesIntel_DW_Cubo/
    ├── SalesIntel_DW_Cubo.dwproj
    ├── SalesIntel_DW_Cubo.database
    ├── SalesIntel DW.ds
    ├── SalesIntel DW DSV.dsv
    ├── CuboVentasSalesIntel.cube
    ├── CuboVentasSalesIntel.partitions
    ├── Dim Producto.dim
    ├── Dim Ciudad.dim
    ├── Dim Cliente.dim
    └── Dim Tiempo.dim
```

## Fuente de datos

Base relacional:

```text
SalesIntel_DW
```

Vistas utilizadas por el DSV:

```text
vw_Cubo_DimProducto
vw_Cubo_DimCiudad
vw_Cubo_DimCliente
vw_Cubo_DimTiempo
vw_Cubo_FactVentas
```

## Cubo

```text
CuboVentasSalesIntel
```

### Dimensiones

- Dim Producto
- Dim Ciudad
- Dim Cliente
- Dim Tiempo

### Medidas de validación

- Total Vendido
- Cantidad Vendida
- Descuento

El modelo también conserva medidas auxiliares utilizadas por el cubo y sus cálculos.

## Validación realizada

El smoke test MDX fue ejecutado contra el cubo procesado y confirmó:

| KPI | Resultado |
|---|---:|
| Total Vendido | 222,995.00 |
| Cantidad Vendida | 183 |
| Descuento | 3,150.00 |
| Ciudades navegables | 8 |

Script:

```text
analysis-services/automation/Test-SalesIntelCube.ps1
```

Consultas MDX adicionales:

```text
analysis-services/mdx/06_Consultas_MDX_Cubo_SalesIntel.mdx
```

## Reconstrucción automatizada

Para reconstruir el cubo en una instancia compatible de SSAS:

```powershell
.\analysis-services\automation\Create-SalesIntelCube.ps1
```

Para ejecutar el smoke test:

```powershell
.\analysis-services\automation\Test-SalesIntelCube.ps1
```

Los parámetros de servidor y base de datos pueden sobreescribirse desde PowerShell.

## Reproducibilidad

1. Ejecutar los scripts `database/01_model` a `database/05_cube`.
2. Verificar que `SalesIntel_DW` contiene las cinco vistas `vw_Cubo_*`.
3. Ejecutar `Create-SalesIntelCube.ps1`.
4. Procesar `CuboVentasSalesIntel`.
5. Ejecutar `Test-SalesIntelCube.ps1`.
6. Abrir el proyecto SSDT versionado o importar nuevamente el modelo desde la instancia SSAS si se desea reproducir el flujo completo.

La guía detallada permanece disponible en `docs/Guia_Crear_Cubo_SalesIntel_DW.md`.
