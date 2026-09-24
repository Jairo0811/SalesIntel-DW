# Automatización del cubo SSAS

Esta carpeta contiene una ruta **experimental y verificable** para crear y probar
`CuboVentasSalesIntel` directamente en la instancia local de SQL Server Analysis Services.

La idea es validar primero el modelo en un servidor real y, una vez funcione, importarlo
desde Visual Studio mediante **Importar desde el servidor (multidimensional)**. De ese modo
los archivos `.dwproj`, `.cube`, `.dim`, `.dsv` y `.ds` finales serán generados por
SSDT a partir de un cubo que ya fue probado.

## Requisitos

- Windows.
- SQL Server Database Engine con `SalesIntel_DW`.
- SQL Server Analysis Services en modo multidimensional.
- Microsoft OLE DB Driver 19 for SQL Server.
- SSMS / librerías AMO y ADOMD instaladas.
- Haber ejecutado los scripts `database/01_model` a `database/05_cube`.

Valores usados actualmente:

- SQL Server: `DESKTOP-5QBHCJS`
- Base relacional: `SalesIntel_DW`
- Analysis Services: `localhost\SSAS2022`
- Base SSAS: `SalesIntel_DW_Cubo`
- Cubo: `CuboVentasSalesIntel`

## Crear el cubo

Desde **Windows PowerShell** abierto en la raíz del repositorio:

```powershell
Set-ExecutionPolicy -Scope Process Bypass

.\analysis-services\automation\Create-SalesIntelCube.ps1
```

El script:

1. comprueba las cinco vistas `vw_Cubo_*`;
2. crea/recrea la base `SalesIntel_DW_Cubo` en SSAS;
3. crea el Data Source y el DSV;
4. crea las dimensiones Producto, Ciudad, Cliente y Tiempo;
5. crea `CuboVentasSalesIntel`;
6. crea el measure group `Ventas`;
7. crea y procesa la partición `FactVentas`.

> El script elimina la base SSAS `SalesIntel_DW_Cubo` si ya existe. No elimina
> `SalesIntel_DW` ni modifica las bases relacionales.

Para crear los metadatos sin procesarlos:

```powershell
.\analysis-services\automation\Create-SalesIntelCube.ps1 -SkipProcess
```

## Probar el cubo

Después de un procesamiento exitoso:

```powershell
.\analysis-services\automation\Test-SalesIntelCube.ps1
```

El smoke test ejecuta MDX y espera:

| KPI | Valor |
|---|---:|
| Total Vendido | 222,995.00 |
| Cantidad Vendida | 183 |
| Descuento | 3,150.00 |

También comprueba que la dimensión Ciudad devuelve miembros al navegar el cubo.

## Si falla el procesamiento por permisos

El Data Source se configura inicialmente con `ImpersonateCurrentUser` para facilitar
la prueba local. Si SSAS exige una cuenta de servicio para procesar, configura la
impersonación desde Visual Studio/SSMS y concede a la cuenta del servicio de Analysis
Services permiso `db_datareader` sobre `SalesIntel_DW`.

## Después de validar

Cuando ambos scripts pasen:

1. Abrir Visual Studio.
2. Elegir **Importar desde el servidor (multidimensional)**.
3. Servidor: `localhost\SSAS2022`.
4. Base: `SalesIntel_DW_Cubo`.
5. Guardar el proyecto dentro de `analysis-services/SalesIntel_DW_Cubo/`.
6. Revisar que no se versionen contraseñas ni credenciales.
7. Sustituir esta automatización experimental por los artefactos SSDT reales o conservarla
   como herramienta de reconstrucción.
