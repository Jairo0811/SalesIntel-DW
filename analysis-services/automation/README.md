# Automatización del cubo SSAS

Esta carpeta contiene scripts reproducibles para crear y validar `CuboVentasSalesIntel` en SQL Server Analysis Services Multidimensional.

El flujo ya fue ejecutado correctamente contra una instancia real y sus metadatos fueron importados después a Visual Studio/SSDT, por lo que el repositorio incluye tanto la automatización como el proyecto multidimensional real.

## Requisitos

- Windows.
- SQL Server Database Engine con `SalesIntel_DW`.
- SQL Server Analysis Services en modo multidimensional.
- Microsoft OLE DB Driver 19 for SQL Server.
- SSMS / librerías AMO y ADOMD instaladas.
- Haber ejecutado los scripts `database/01_model` a `database/05_cube`.

Valores por defecto del entorno de validación:

- SQL Server: `DESKTOP-5QBHCJS`
- Base relacional: `SalesIntel_DW`
- Analysis Services: `localhost\SSAS2022`
- Base SSAS: `SalesIntel_DW_Cubo`
- Cubo: `CuboVentasSalesIntel`

Todos estos valores pueden sobreescribirse mediante parámetros del script.

## Crear o reconstruir el cubo

Desde Windows PowerShell abierto en la raíz del repositorio:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\analysis-services\automation\Create-SalesIntelCube.ps1
```

El script:

1. valida las cinco vistas `vw_Cubo_*`;
2. crea o recrea la base `SalesIntel_DW_Cubo` en SSAS;
3. crea el Data Source y el DSV;
4. crea las dimensiones Producto, Ciudad, Cliente y Tiempo;
5. crea `CuboVentasSalesIntel`;
6. crea el measure group `Ventas`;
7. concede a la cuenta del servicio SSAS acceso `db_datareader` sobre `SalesIntel_DW` cuando el usuario ejecutor tiene permisos para hacerlo;
8. crea y procesa la partición `FactVentas`.

> El script elimina la base SSAS `SalesIntel_DW_Cubo` si ya existe. No elimina ni modifica la base relacional `SalesIntel_DW`.

Para crear los metadatos sin procesar:

```powershell
.\analysis-services\automation\Create-SalesIntelCube.ps1 -SkipProcess
```

## Probar el cubo

Después de un procesamiento exitoso:

```powershell
.\analysis-services\automation\Test-SalesIntelCube.ps1
```

El smoke test MDX valida:

| KPI | Valor esperado |
|---|---:|
| Total Vendido | 222,995.00 |
| Cantidad Vendida | 183 |
| Descuento | 3,150.00 |

También comprueba que la dimensión Ciudad devuelve miembros navegables.

## Proyecto SSDT real

El modelo procesado fue importado desde SSAS a Visual Studio y se versiona en:

```text
analysis-services/SalesIntel_DW_Cubo/
```

Por tanto, la automatización ya no sustituye al proyecto SSDT: ambos forman parte de la estrategia de reproducibilidad del repositorio.
