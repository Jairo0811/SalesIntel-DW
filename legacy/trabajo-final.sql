select *  from dimproducto
select *  from [dbo].[DetFactura]
select *  from [dbo].[DimTiempo]
select *  from [dbo].[FactVentas]
select *  from [dbo].[DetFactura]
 
insert into DimProducto(IdProducto,Nombre)values(100,	'PRODUCTO 100')
1	PRODUCTO 1
2	PRODUCTO 2
4	PRODUCTO 4
3	PRODUCTO 3
100	PRODUCTO 100
4	PRODUCTO 4

insert into [dbo].[DetFactura](IdFactura,IdProducto,Precio,Cant)values(2,1,100,1)

SELECT        Count( DimProducto.IdProducto),DimTiempo.mes,DetFactura.Cant AS Expr1, DimCiudad.Nombre
FROM            DimProducto INNER JOIN
                         DetFactura ON DimProducto.IdProducto = DetFactura.IdProducto CRoss JOIN
                         DimCiudad cross JOIN
                         DimTiempo
						
group BY     DimTiempo.mes,DetFactura.Cant,DimCiudad.Nombre
