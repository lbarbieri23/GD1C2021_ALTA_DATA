
GO

BEGIN
-- Componentes de PC

    CREATE TABLE [ALTA_DATA].[BI_Memoria_Ram] (
    	  [id_memoria_ram] NVARCHAR(255) PRIMARY KEY,
    	  [mr_tipo] NVARCHAR(255),
    	  [mr_capacidad] NVARCHAR(255),
    	  [mr_velocidad] NVARCHAR(255),
    	  [mr_fabricante] NVARCHAR(255)
    	);

    CREATE TABLE [ALTA_DATA].[BI_Microprocesador] (
    	  [id_microprocesador] NVARCHAR(50) PRIMARY KEY,
    	  [mic_cache] NVARCHAR(50),
    	  [mic_hilos] DECIMAL,
    	  [mic_velocidad] NVARCHAR(50),
    	  [mic_fabricante] NVARCHAR(255)
    	);

    CREATE TABLE [ALTA_DATA].[BI_Disco_Rigido] (
    	  [id_disco_rigido] NVARCHAR(255) PRIMARY KEY,
          [dr_tipo] NVARCHAR(255),
          [dr_capacidad] NVARCHAR(255),
          [dr_fabricante] NVARCHAR(255),
          [dr_velocidad] NVARCHAR(255)
    	);

  	CREATE TABLE [ALTA_DATA].[BI_Motherboard] (
    	  [id_motherboard] INTEGER IDENTITY(1,1) PRIMARY KEY,
    	  [mb_fabricante] NVARCHAR(255)
    	);

    CREATE TABLE [ALTA_DATA].[BI_Placa_Video] (
    	  [id_placa_video] INTEGER IDENTITY(1,1) PRIMARY KEY,
    	  [pv_chipset] NVARCHAR(50),
    	  [pv_modelo] NVARCHAR(50),
    	  [pv_velocidad] NVARCHAR(255),
    	  [pv_capacidad] NVARCHAR(255),
    	  [pv_fabricante] NVARCHAR(255)
    	);

    CREATE TABLE [ALTA_DATA].[BI_PC] (
    	  [id_pc] NVARCHAR(50) PRIMARY KEY,
    	  [id_disco_rigido] NVARCHAR (255) FOREIGN KEY REFERENCES [ALTA_DATA].[BI_Disco_Rigido](id_disco_rigido),
    	  [id_memoria_ram] NVARCHAR (255) FOREIGN KEY REFERENCES [ALTA_DATA].[BI_Memoria_Ram](id_memoria_ram),
    	  [id_microprocesador] NVARCHAR (50) FOREIGN KEY REFERENCES [ALTA_DATA].[BI_Microprocesador](id_microprocesador),
    	  [id_placa_video] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[BI_Placa_Video](id_placa_video),
    	  [id_motherboard] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[BI_Motherboard](id_motherboard),
    	  [pc_alto] DECIMAL,
    	  [pc_ancho] DECIMAL,
    	  [pc_profundidad] DECIMAL
    );

-- Accesorios

	CREATE TABLE [ALTA_DATA].[BI_Accesorio] (
	  [id_accesorio] DECIMAL PRIMARY KEY,
	  [acc_fabricante] NVARCHAR(255),
	  [acc_descripcion] NVARCHAR(255)
	);

-- Sucursales

	CREATE TABLE [ALTA_DATA].[BI_Sucursal] (
      [id_sucursal] INTEGER IDENTITY(1,1) PRIMARY KEY,
      [suc_direccion] NVARCHAR (255),
      [suc_mail] NVARCHAR (255),
      [suc_telefono] DECIMAL
	);

-- Clientes

	CREATE TABLE [ALTA_DATA].[BI_Cliente] (
	[id_cliente] INTEGER IDENTITY(1,1) PRIMARY KEY,
    [cli_fecha_nacimiento] DATETIME2,
    [cli_sexo] CHAR NULL
	);

-- Compras

	CREATE TABLE [ALTA_DATA].[BI_Compra] (
	 [id_compra] INTEGER IDENTITY(1,1) PRIMARY KEY,
     [com_fecha] DATETIME2,
     [com_precio] DECIMAL,
     [com_cantidad] DECIMAL,
     [cod_fecha] INTEGER,
     [id_pc] NVARCHAR(50),
     [id_accesorio] DECIMAL,
     [id_sucursal] INTEGER,
     [id_cliente] INTEGER
     );

-- Ventas

	CREATE TABLE [ALTA_DATA].[BI_Venta] (
	[id_venta] INTEGER IDENTITY(1,1) PRIMARY KEY,
	[ven_fecha] DATETIME2,
	[ven_precio] DECIMAL,
	[ven_cantidad] DECIMAL,
	[cod_fecha] INTEGER,
	[id_pc] NVARCHAR(50),
	[id_accesorio] DECIMAL,
	[id_sucursal] INTEGER,
	[id_cliente] INTEGER
	);

-- Tiempo

	CREATE TABLE [ALTA_DATA].[BI_Tiempo] (
	      [cod_fecha] INTEGER IDENTITY(1,1) PRIMARY KEY,
    	  [mes] DECIMAL,
    	  [anio] DECIMAL,
	);

END;

-- MIGRACION DE DATOS

-- Componentes de PC

-- Memoria Ram
GO
BEGIN
	BEGIN
		INSERT INTO [ALTA_DATA].[BI_Memoria_Ram](
			 [id_memoria_ram]
			,[mr_tipo]
			,[mr_capacidad]
			,[mr_velocidad]
			,[mr_fabricante]
			)
		SELECT DISTINCT
	         m.[id_memoria_ram]
    		,m.[mr_tipo]
    		,m.[mr_capacidad]
    		,m.[mr_velocidad]
    		,m.[mr_fabricante]
		FROM [ALTA_DATA].[Memoria_Ram] m
			WHERE m.[id_memoria_ram] IS NOT NULL;

	END;

-- Microprocesador
	BEGIN
		INSERT INTO [ALTA_DATA].[BI_Microprocesador](
		     [id_microprocesador]
			 ,[mic_cache]
			 ,[mic_hilos]
			 ,[mic_velocidad]
			 ,[mic_fabricante]
			 )
		SELECT DISTINCT
			  m.[id_microprocesador]
             ,m.[mic_cache]
             ,m.[mic_hilos]
             ,m.[mic_velocidad]
             ,m.[mic_fabricante]
		FROM [ALTA_DATA].[Microprocesador] m
			WHERE m.[id_microprocesador] IS NOT NULL;
	END;

-- Disco Rigido
	BEGIN
		INSERT INTO [ALTA_DATA].[BI_Disco_Rigido] (
			   [id_disco_rigido]
			  ,[dr_tipo]
			  ,[dr_capacidad]
			  ,[dr_fabricante]
			  ,[dr_velocidad]
			)
		SELECT DISTINCT
			   m.[id_disco_rigido]
              ,m.[dr_tipo]
              ,m.[dr_capacidad]
              ,m.[dr_fabricante]
              ,m.[dr_velocidad]
		FROM [ALTA_DATA].[Disco_Rigido] m
			WHERE  m.[id_disco_rigido] IS NOT NULL;
	END;

-- Motherboard
/*
No hay datos de las motherboards en el modelo inicial
*/

-- Placa de video
/*
Como no hay codigos de las placas de video dejamos que se genere un id automaticamente
*/
	BEGIN
		INSERT INTO [ALTA_DATA].[BI_Placa_Video] (
			  [pv_chipset]
			  ,[pv_modelo]
			  ,[pv_velocidad]
			  ,[pv_capacidad]
			  ,[pv_fabricante]
			)
		SELECT DISTINCT
			   m.[pv_chipset]
			  ,m.[pv_modelo]
			  ,m.[pv_velocidad]
			  ,m.[pv_capacidad]
			  ,m.[pv_fabricante]
		FROM [ALTA_DATA].[Placa_Video] m
			WHERE m.[pv_chipset]IS NOT NULL
				OR m.[pv_modelo] IS NOT NULL
				OR m.[pv_velocidad]IS NOT NULL
				OR m.[pv_capacidad] IS NOT NULL
				OR m.[pv_fabricante] IS NOT NULL;
	END;

-- PC
/* No hay datos de las motherboards asi que por ahora va a quedar en NULL este campo */
	BEGIN
		INSERT INTO [ALTA_DATA].[BI_PC] (
			   [id_pc]
			  ,[id_disco_rigido]
			  ,[id_memoria_ram]
			  ,[id_microprocesador]
			  ,[id_placa_video]
			  ,[id_motherboard]
			  ,[pc_alto]
			  ,[pc_ancho]
			  ,[pc_profundidad]
			)
		SELECT DISTINCT
			 m.[id_pc]
            ,m.[id_disco_rigido]
            ,m.[id_memoria_ram]
            ,m.[id_microprocesador]
            ,m.[id_placa_video]
			,NULL
			,m.[pc_alto]
            ,m.[pc_ancho]
            ,m.[pc_profundidad]
		FROM [ALTA_DATA].[PC] m
	END;

-- Accesorios
/*
La tabla Accesorio del modelo de creacion inicial no cuenta con el fabricante
*/
	BEGIN
		INSERT INTO [ALTA_DATA].[BI_Accesorio](
			 [id_accesorio]
			,[acc_descripcion]
			)
		SELECT DISTINCT
			 m.[id_accesorio]
            ,m.[acc_descripcion]
		FROM [ALTA_DATA].[Accesorios] m
			WHERE m.[id_accesorio] IS NOT NULL;

	END;

-- Sucursal
/*
Como no hay codigos de las sucursales, dejamos que se genere un id automaticamente
*/
	BEGIN
		INSERT INTO [ALTA_DATA].[BI_Sucursal](
			 [suc_direccion]
			,[suc_mail]
			,[suc_telefono]
			)
		SELECT DISTINCT
			 m.[suc_direccion]
			,m.[suc_mail]
			,m.[suc_telefono]
		FROM [ALTA_DATA].[Sucursal] m
			 WHERE m.[suc_direccion] IS NOT NULL
				OR m.[suc_mail] IS NOT NULL
				OR m.[suc_telefono] IS NOT NULL;
	END;

-- Cliente
/*
Como no hay codigos de los clientes dejamos que se genere un id automaticamente, ademas falta el sexo del cliente en la
tabla cliente del modelo inicial
*/
	BEGIN
		INSERT INTO [ALTA_DATA].[BI_Cliente](
			[cli_fecha_nacimiento]
			)
		SELECT DISTINCT
			m.[cli_fecha_nacimiento]
		FROM [ALTA_DATA].[Cliente] m
			WHERE m.[cli_fecha_nacimiento] IS NOT NULL;
	END;

-- Tiempo
/*
Como no hay codigos de fecha dejamos que se genere un id automaticamente
*/
	BEGIN
		INSERT INTO [ALTA_DATA].[BI_Tiempo](
		     [mes]
		    ,[anio]
			)
		SELECT DISTINCT (
		    SELECT MONTH (c.com_fecha) as mes, year (c.com_fecha) as anio
		    FROM [ALTA_DATA].[Compra] c
		    UNION
		    SELECT MONTH (f.fac_fecha) as mes, year (f.fac_fecha) as anio
        	FROM [ALTA_DATA].[Factura] f )
	END;

-- Compra
/*
Como no hay codigos de compra, dejamos que se genere un id automaticamente
*/
	BEGIN
		INSERT INTO [ALTA_DATA].[BI_Compra](
			 [com_fecha]
			,[com_precio]
			,[com_cantidad]
			,[id_pc]
			,[id_accesorio]
			,[id_sucursal]
			,[id_cliente]
			)
		SELECT DISTINCT
		    m.[com_fecha]
		   ,i.[itemc_precio]
		   ,i.[itemc_cantidad]
		   ,p.[id_pc]
		   ,a.[id_accesorio]
		   ,s.[id_sucursal]
		   ,c.[id_cliente]
		FROM [ALTA_DATA].[Compra] m,[ALTA_DATA].[Item_compra] i, [ALTA_DATA].[PC] p , [ALTA_DATA].[Accesorios] a, [ALTA_DATA].[Sucursal] s, [ALTA_DATA].[Cliente] c
	END;

-- Ventas
/*
Como no hay codigo de ventas dejamos que se genere un id automaticamente, falta tambien el precio y la cantidad que no estan en item factura del modelo inciial
*/
	BEGIN
		INSERT INTO [ALTA_DATA].[BI_Venta](
			 [ven_fecha]
			,[id_pc]
            ,[id_accesorio]
            ,[id_sucursal]
            ,[id_cliente]
			)
		SELECT DISTINCT
			 m.[fac_fecha]
		    ,p.[id_pc]
            ,a.[id_accesorio]
            ,s.[id_sucursal]
            ,c.[id_cliente]
		FROM [ALTA_DATA].[Factura] m, [ALTA_DATA].[PC] p, [ALTA_DATA].[Accesorios] a, [ALTA_DATA].[Sucursal] s, [ALTA_DATA].[Cliente] c
	END;

END;

GO

--##############################################################################################################################

-- VISTAS

-- 1) promedio de tiempo en stock de cada modelo de pc
-- como en cada factura no se especifica la cantidad, se asume que se venden de a una unidad. Como en las cantidades de compra en todas las filas es 1 tambien se asume lo mismo.
 create view promedio_tiempo_en_stock
	as
		select p.[id_pc], t.[anio], t.[mes], avg(datediff(month, isnull(v.[cod_fecha], 0), isnull(c.[cod_fecha], 0))) as promedio_tiempo_en_stock, 
		from [ALTA_DATA].[BI_PC] p, [ALTA_DATA].[BI_Venta] v, [ALTA_DATA].[BI_Compra] c
        left join [ALTA_DATA].[BI_Venta] v on p.[id_pc] = v.[id_pc] 
        left join [ALTA_DATA].[BI_Compra] c on p.[id_pc] = c.[id_pc]
			join [ALTA_DATA].[BI_Tiempo] t on t.[cod_fecha] = v.[cod_fecha] 
			join [ALTA_DATA].[BI_Tiempo] t on t.[cod_fecha] = c.[cod_fecha]
		group by p.[id_pc], t.[anio], t.[mes]
		order by v.[cod_fecha], c.[cod_fecha]
    END;
    GO

--2)  Precio promedio de PCs, vendidos y comprados.

create view precio_promedio_Pc_compra_venta 
as 
	select v.[id_pc],
     sum(ISNULL(v.[ven_precio],0) / count(ISNULL(v.[ven_precio], 1) ) as promedio_precio_venta
     sum(ISNULL(v.[com_precio],0) / count(ISNULL(v.[com_precio], 1) ) as promedio_precio_compra
	from [ALTA_DATA][BI_Venta] v
    group by v.[id_pc]
END;
GO

-- 3) Cantidad de PCs, vendidos y comprados x sucursal y mes

create view precio_promedio_Pc_compra_venta 
as 
    select s.[id_sucursal],
           MONTH(v.[id_venta]),
           v.[id_pc],
           [ALTA_DATA].precio_prom_compra(v.[id_pc]), -- funcion ppc
           [ALTA_DATA].precio_prom_venta(v.[id_pc]), --  funcion ppv
        from [ALTA_DATA].[BI_Sucursal] s
    left join [BI_Compra] c on s.[id_sucursal] = c.[id_sucursal]
    left join [BI_Venta] c on s.[id_sucursal] = v.[id_sucursal] 
		where  v.[id_pc] = c.[id_pc]
		and month(v.[cod_fecha]) = month(c.[cod_fecha])
		and year(v.[cod_fecha]) = year(c.[cod_fecha])  
    group by 

END;
GO

-- ppc: contempla las cantidades. no es lo mismo comprar 400 notebooks a 10 pesos y luego 1 notebook a $100. El promedio no es $55
create function precio_prom_compra (@id_pc NVARCHAR(50))
returns decimal(12,2)
as 
begin 
    return select top 1 sum([com_cantidad] * [com_precio]) / sum([com_cantidad])
                from [BI_Compra]   
                where [id_pc] = @id_pc and
                      [cod_fecha] =  @mes
                group by sum([com_cantidad] * [com_precio]) / sum([com_cantidad])
END

--ppv: contempla las cantidades
create function precio_prom_venta(@id_pc NVARCHAR(50), @mes NVARCHAR(10))
returns decimal(12,2)
as 
begin 
    return select top 1 sum([ven_cantidad] * [ven_precio]) / sum([ven_cantidad]))
                from [BI_Venta]   
                where [id_pc] = @id_pc and
                      [cod_fecha] =  @mes
                group by sum([ven_cantidad] * [ven_precio]) / sum([ven_cantidad]))  --de donde sacas ven_cantidad? no hay datos por enunciado
END

-- 4) Ganancias (precio de venta – precio de compra) x Sucursal x mes

create view ganancia_sucursal_x_mes
as 
    select s.[id_sucursal], month([cod_fecha]), sum(v.[ven_cantidad] * v.[ven_precio]) - sum(c.[com_cantidad] * c.com_precio) as ganancias
    from [ALTA_DATA].[BI_Sucursal] s
    left join [ALTA_DATA].[BI_Compra] c on s.[id_sucursal] = c.[id_sucursal]
    left join [ALTA_DATA].[BI_Venta] c on s.[id_sucursal] = v.[id_sucursal] 
    where  v.[id_pc] = c.[id_pc]
    and month(v.[cod_fecha]) = month(c.[cod_fecha])
    and year(v.[cod_fecha]) = year(c.[cod_fecha])  
    group by  s.[id_sucursal], month([cod_fecha])
end



-- ACCESORIOS


-- 5) promedio de tiempo en stock de cada modelo de ACCESORIO
-- como en cada factura no se especifica la cantidad, se asume que se venden de a una unidad. Como en las cantidades de compra en todas las filas es 1 tambien se asume lo mismo.
 create view promedio_tiempo_en_stock
	as
		select a.[id_accesorio], t.[anio], t.[mes], avg(datediff(month, isnull(v.[cod_fecha], 0), isnull(c.[cod_fecha], 0))) as promedio_tiempo_en_stock, 
		from [ALTA_DATA].[BI_ACCESORIO] a
        left join [ALTA_DATA].[BI_Venta] v on a.[id_accesorio] = v.[id_pc] 
        left join [ALTA_DATA].[BI_Compra] c on a.[id_accesorio] = c.[id_pc]
			join [ALTA_DATA].[BI_Tiempo] t on t.[cod_fecha] = v.[cod_fecha] 
			join [ALTA_DATA].[BI_Tiempo] t on t.[cod_fecha] = c.[cod_fecha]
		group by a.[id_accesorio], t.[anio], t.[mes]
		order by v.[cod_fecha], c.[cod_fecha]
    END;
    GO

--6)  Precio promedio de accesorios, vendidos y comprados.

create view precio_promedio_accesorio_compra_venta 
as 
	select v.[id_accesorio],
     sum(ISNULL(v.[ven_precio],0) / count(ISNULL(v.[ven_precio], 1) ) as promedio_precio_venta
     sum(ISNULL(v.[com_precio],0) / count(ISNULL(v.[com_precio], 1) ) as promedio_precio_compra
	from [BI_Ventas_PC] v
    group by v.[id_accesorio]
END;
GO

-- 7) Cantidad de accesorios, vendidos y comprados x sucursal y mes

create view precio_promedio_accesorio_compra_venta 
as 
    select s.[id_sucursal],
           MONTH(v.[id_venta]),
           v.[id_accesorio],
           [ALTA_DATA].precio_prom_compra(v.[id_accesorio]), -- funcion ppc
           [ALTA_DATA].precio_prom_venta(v.[id_accesorio]), --  funcion ppv
        from [BI_Sucursal] s
    left join [ALTA_DATA].[BI_Compra] c on s.[id_sucursal] = c.[id_sucursal]
    left join [ALTA_DATA].[BI_Venta] c on s.[id_sucursal] = v.[id_sucursal] 
		where  v.[id_accesorio] = c.[id_accesorio]
		and month(v.[cod_fecha]) = month(c.[cod_fecha])
		and year(v.[cod_fecha]) = year(c.[cod_fecha])  
    group by 

END;
GO

-- ppc: contempla las cantidades. no es lo mismo comprar 400 accesorios a 10 pesos y luego 1 accesorio a $100. El promedio no es $55
create function precio_prom_compra (@id_accesorio NVARCHAR(50))
returns decimal(12,2)
as 
begin 
    return select top 1 sum([com_cantidad] * [com_precio]) / sum([com_cantidad])
                from [BI_Compra]   
                where [id_accesorio] = @id_accesorio and
                      [cod_fecha] =  @mes
                group by sum([com_cantidad] * [com_precio]) / sum([com_cantidad])
END

--ppv: contempla las cantidades
create function precio_prom_venta(@id_accesorio NVARCHAR(50), @mes NVARCHAR(10))
returns decimal(12,2)
as 
begin 
    return select top 1 sum([ven_cantidad] * [ven_precio]) / sum([ven_cantidad]))
                from [BI_Venta]   
                where [id_accesorio] = @id_accesorio and
                      [cod_fecha] =  @mes
                group by sum([ven_cantidad] * [ven_precio]) / sum([ven_cantidad]))
END

-- 8) Ganancias (precio de venta – precio de compra) x Sucursal x mes

create view ganancia_sucursal_x_mes
as 
    select s.[id_sucursal], month([cod_fecha]), sum(v.[ven_cantidad] * v.[ven_precio]) - sum(c.[com_cantidad] * c.[com_precio]) as ganancias
    from BI_Sucursal s
    left join [BI_Compra] c on s.[id_sucursal] = c.[id_sucursal]
    left join [BI_Venta] c on s.[id_sucursal] = v.[id_sucursal] 
    where  v.[id_accesorio] = c.[id_accesorio]
    and month(v.[cod_fecha]) = month(c.[cod_fecha])
    and year(v.[cod_fecha]) = year(c.[cod_fecha])  
    group by  s.[id_sucursal], month([cod_fecha])
end


-- BORRAR TODO: NO DESCOMENTAR
/*
/*
/*
GO
BEGIN
DROP TABLE [ALTA_DATA].[BI_Memoria_Ram];
DROP TABLE [ALTA_DATA].[BI_Microprocesador];
DROP TABLE [ALTA_DATA].[BI_Disco_Rigido];
DROP TABLE [ALTA_DATA].[BI_Motherboard];
DROP TABLE [ALTA_DATA].[BI_Placa_Video];
DROP TABLE [ALTA_DATA].[BI_PC];
DROP TABLE [ALTA_DATA].[BI_Accesorio];
DROP TABLE [ALTA_DATA].[BI_Sucursal];
DROP TABLE [ALTA_DATA].[BI_Cliente];
DROP TABLE [ALTA_DATA].[BI_Compra];
DROP TABLE [ALTA_DATA].[BI_Venta];
DROP TABLE [ALTA_DATA].[BI_Tiempo];
END
DROP SCHEMA [ALTA_DATA];
*/
*/
*/
