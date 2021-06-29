USE GD1C2021;
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
    	  [id_motherboard] INTEGER PRIMARY KEY,
    	  [mb_fabricante] NVARCHAR(255)
    	);

    CREATE TABLE [ALTA_DATA].[BI_Placa_Video] (
    	  [id_placa_video] INTEGER PRIMARY KEY,
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
      [id_sucursal] INTEGER PRIMARY KEY,
      [suc_direccion] NVARCHAR (255),
      [suc_mail] NVARCHAR (255),
      [suc_telefono] DECIMAL
	);

-- Clientes

	CREATE TABLE [ALTA_DATA].[BI_Cliente] (
	[id_cliente] INTEGER PRIMARY KEY,
    [cli_fecha_nacimiento] DATETIME2,
    [cli_sexo] CHAR NULL
	);

-- Tiempo

	CREATE TABLE [ALTA_DATA].[BI_Tiempo] (
	      [cod_fecha] INTEGER IDENTITY(1,1) PRIMARY KEY,
    	  [fecha] DATETIME2
	);

-- Compras

	CREATE TABLE [ALTA_DATA].[BI_Compra] (
	 [id_compra] INTEGER IDENTITY(1,1) PRIMARY KEY,
     [com_fecha] DATETIME2,
     [com_precio] DECIMAL,
     [com_cantidad] DECIMAL,
     [cod_fecha] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[BI_Tiempo](cod_fecha),
     [id_pc] NVARCHAR(50) FOREIGN KEY REFERENCES [ALTA_DATA].[BI_PC](id_pc),
     [id_accesorio] DECIMAL FOREIGN KEY REFERENCES [ALTA_DATA].[BI_Accesorio](id_accesorio),
     [id_sucursal] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[BI_Sucursal](id_sucursal),
     );

-- Ventas

	CREATE TABLE [ALTA_DATA].[BI_Venta] (
	[id_venta] INTEGER IDENTITY(1,1) PRIMARY KEY,
	[ven_fecha] DATETIME2,
	[ven_precio] DECIMAL,
	[ven_cantidad] DECIMAL,
    [cod_fecha] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[BI_Tiempo](cod_fecha),
    [id_pc] NVARCHAR(50) FOREIGN KEY REFERENCES [ALTA_DATA].[BI_PC](id_pc),
    [id_accesorio] DECIMAL FOREIGN KEY REFERENCES [ALTA_DATA].[BI_Accesorio](id_accesorio),
    [id_sucursal] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[BI_Sucursal](id_sucursal),
	[id_cliente] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[BI_Cliente](id_cliente)
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
	END;

-- Motherboard
	BEGIN
		INSERT INTO [ALTA_DATA].[BI_Motherboard] (
			   [id_motherboard]
    	       ,[mb_fabricante]
			)
		SELECT DISTINCT
			   m.[id_motherboard]
              ,m.[mb_fabricante]
		FROM [ALTA_DATA].[Motherboard] m
	END;

-- Placa de video
	BEGIN
		INSERT INTO [ALTA_DATA].[BI_Placa_Video] (
              [id_placa_video]
			  ,[pv_chipset]
			  ,[pv_modelo]
			  ,[pv_velocidad]
			  ,[pv_capacidad]
			  ,[pv_fabricante]
			)
		SELECT DISTINCT
              m.[id_placa_video]
			  ,m.[pv_chipset]
			  ,m.[pv_modelo]
			  ,m.[pv_velocidad]
			  ,m.[pv_capacidad]
			  ,m.[pv_fabricante]
		FROM [ALTA_DATA].[Placa_Video] m
	END;

-- PC
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
			,m.[id_motherboard]
			,m.[pc_alto]
            ,m.[pc_ancho]
            ,m.[pc_profundidad]
		FROM [ALTA_DATA].[PC] m
	END;

-- Accesorios
	BEGIN
		INSERT INTO [ALTA_DATA].[BI_Accesorio](
			 [id_accesorio]
			,[acc_descripcion]
			)
		SELECT DISTINCT
			 m.[id_accesorio]
            ,m.[acc_descripcion]
		FROM [ALTA_DATA].[Accesorios] m

	END;

-- Sucursal
	BEGIN
		INSERT INTO [ALTA_DATA].[BI_Sucursal](
            [id_sucursal]
			,[suc_direccion]
			,[suc_mail]
			,[suc_telefono]
			)
		SELECT DISTINCT
            m.[id_sucursal]
			,m.[suc_direccion]
			,m.[suc_mail]
			,m.[suc_telefono]
		FROM [ALTA_DATA].[Sucursal] m
	END;

-- Cliente
	BEGIN
		INSERT INTO [ALTA_DATA].[BI_Cliente](
            [id_cliente]
			,[cli_fecha_nacimiento]
	        ,[cli_sexo]
			)
		SELECT DISTINCT
            m.[id_cliente]
			,m.[cli_fecha_nacimiento]
            ,m.[cli_sexo]
		FROM [ALTA_DATA].[Cliente] m
	END;

-- Tiempo
/*
Como no hay codigos de fecha dejamos que se genere un id automaticamente
Se guardan todas las fechas como el ultimo dia del mes para poder usar la funciones del tipo DATETIME2
*/
	BEGIN
		INSERT INTO [ALTA_DATA].[BI_Tiempo](
		    [fecha]
        )
		SELECT DISTINCT EOMONTH(c.com_fecha) 
		FROM [ALTA_DATA].[Compra] c
		UNION
		SELECT EOMONTH(f.fac_fecha) 
        FROM [ALTA_DATA].[Factura] f 
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
            ,[cod_fecha]
			)
		SELECT DISTINCT
		    m.[com_fecha]
		   ,i.[itemc_precio]
		   ,i.[itemc_cantidad]
		   ,i.[id_pc]
		   ,i.[id_accesorio]
		   ,m.[id_sucursal]
           ,t.[cod_fecha]
		FROM
            [ALTA_DATA].[Compra] m
            ,[ALTA_DATA].[Item_compra] i
            ,[ALTA_DATA].[BI_Tiempo] t
        WHERE 
            i.[id_compra] = m.[id_compra]
            AND t.[fecha] = EOMONTH(m.[com_fecha])
	END;

-- Ventas
/*
Como no hay codigo de ventas dejamos que se genere un id automaticamente
*/
	BEGIN
		INSERT INTO [ALTA_DATA].[BI_Venta](
			 [ven_fecha]
			,[id_pc]
            ,[id_accesorio]
            ,[id_sucursal]
            ,[id_cliente]
            ,[cod_fecha]
            ,[ven_cantidad]
            ,[ven_precio]
			)
		SELECT DISTINCT
			 m.[fac_fecha]
		    ,i.[id_pc]
            ,i.[id_accesorio]
            ,m.[id_sucursal]
            ,m.[id_cliente]
            ,t.[cod_fecha]
            ,i.[itemf_cantidad]
            ,i.[itemf_precio]
		FROM [ALTA_DATA].[Factura] m
            ,[ALTA_DATA].[Item_factura] i
            ,[ALTA_DATA].[BI_Tiempo] t
        WHERE
            i.[id_factura] = m.[id_factura]
            AND t.[fecha] = EOMONTH(m.[fac_fecha])
	END;

END;

GO

--##############################################################################################################################

-- VISTAS

-- 1) promedio de tiempo en stock de cada modelo de pc
/*
Se calcula el promedio de tiempo en stock de un producto como los dias del mes dividido la cantidad de ventas. De esta manera se obtiene cada cuantos dias se hace una venta de cada producto
*/
CREATE VIEW [ALTA_DATA].[pc_promedio_tiempo_en_stock]
AS
    SELECT 
        p.[id_pc]
        ,FORMAT(t.[fecha], 'MM-yyyy') as Periodo
        ,DAY(EOMONTH(t.[fecha])) / SUM(v.[ven_cantidad]) as 'Promedio de tiempo en stock'
    FROM 
        [ALTA_DATA].[BI_PC] p
        ,[ALTA_DATA].[BI_Venta] v
        ,[ALTA_DATA].[BI_Compra] c
        ,[ALTA_DATA].[BI_Tiempo] t 
    WHERE
        p.[id_pc] = v.[id_pc] 
        AND p.[id_pc] = c.[id_pc]
        AND t.[cod_fecha] = v.[cod_fecha] 
        AND t.[cod_fecha] = c.[cod_fecha]
        AND p.[id_pc] IS NOT NULL -- Los accesorios tiene id_pc en NULL
    GROUP BY 
        p.[id_pc]
        ,t.[fecha]

GO


--2)  Precio promedio de PCs, vendidos y comprados.

CREATE VIEW [ALTA_DATA].[pc_precio_promedio_compra_venta]
AS 
    SELECT 
        v.[id_pc]
        ,AVG(v.[ven_precio]) as 'Precio venta promedio'
        ,AVG(c.[com_precio]) as 'Precio compra promedio'
	FROM 
        [ALTA_DATA].[BI_Venta] v
       ,[ALTA_DATA].[Bi_Compra] c
    WHERE
        v.[id_pc] = c.[id_pc]
        AND v.[id_pc] IS NOT NULL
    GROUP BY 
        v.[id_pc]
GO

-- 3) Cantidad de PCs, vendidos y comprados x sucursal y mes

CREATE VIEW [ALTA_DATA].[pc_cantidad_compra_venta]
AS 
    SELECT 
        v.[id_sucursal]
        ,FORMAT(t.[fecha], 'MM-yyyy') as Periodo
        ,v.[id_pc]
        ,SUM(v.[ven_cantidad]) as Ventas
        ,SUM(c.[com_cantidad]) as Compras
    FROM    
         [ALTA_DATA].[BI_Compra] c 
        ,[ALTA_DATA].[BI_Venta] v 
        ,[ALTA_DATA].[BI_Tiempo] t
	WHERE  
        v.[id_pc] = c.[id_pc]
        AND v.[id_sucursal] = c.[id_sucursal]
		AND t.[cod_fecha] = c.[cod_fecha]
		and t.[cod_fecha] = v.[cod_fecha]
    GROUP BY 
         v.[id_sucursal]
        ,t.[fecha]
        ,v.[id_pc]
GO

-- 4) Ganancias (precio de venta – precio de compra) x Sucursal x mes

CREATE VIEW [ALTA_DATA].[pc_ganancias]
AS 
    SELECT 
        v.[id_sucursal]
        ,FORMAT(t.[fecha], 'MM-yyyy') as Periodo
        ,SUM(v.[ven_cantidad] * v.[ven_precio]) - sum(c.[com_cantidad] * c.com_precio) as ganancias
    FROM 
         [ALTA_DATA].[BI_Compra] c 
        ,[ALTA_DATA].[BI_Venta] v
        ,[ALTA_DATA].[BI_Tiempo] t
    WHERE 
        v.[id_pc] = c.[id_pc]
        AND v.[cod_fecha] = c.[cod_fecha]
        AND v.[cod_fecha] = t.[cod_fecha]
    GROUP BY 
        v.[id_sucursal],
        t.[fecha]
GO



-- ACCESORIOS


-- 5) promedio de tiempo en stock de cada modelo de ACCESORIO
-- como en cada factura no se especifica la cantidad, se asume que se venden de a una unidad. Como en las cantidades de compra en todas las filas es 1 tambien se asume lo mismo.
CREATE VIEW [ALTA_DATA].[acc_promedio_tiempo_en_stock]
AS
		SELECT 
            v.[id_accesorio]
            ,FORMAT(t.[fecha], 'MM-yyyy') as Periodo
            ,DAY(EOMONTH(t.[fecha])) / SUM(v.[ven_cantidad]) as 'Promedio de tiempo en stock'
        FROM
            [ALTA_DATA].[BI_Venta] v 
			,[ALTA_DATA].[BI_Tiempo] t 
        WHERE 
            t.[cod_fecha] = v.[cod_fecha] 
            AND v.[id_accesorio] IS NOT NULL
		GROUP BY 
            v.[id_accesorio]
            ,t.[fecha]

GO

--6)  Precio promedio de accesorios, vendidos y comprados.


CREATE VIEW [ALTA_DATA].[acc_precio_promedio_compra_venta]
AS 
    SELECT 
        v.[id_accesorio]
        ,AVG(v.[ven_precio]) as 'Precio venta promedio'
        ,AVG(c.[com_precio]) as 'Precio compra promedio'
	FROM 
        [ALTA_DATA].[BI_Venta] v
       ,[ALTA_DATA].[Bi_Compra] c
    WHERE
        v.[id_accesorio] = c.[id_accesorio]
        AND v.[id_accesorio] IS NOT NULL
    GROUP BY 
        v.[id_accesorio]

GO
-- 7) Cantidad de accesorios, vendidos y comprados x sucursal y mes

CREATE VIEW [ALTA_DATA].[acc_cantidad_compra_venta]
AS 
    SELECT 
        v.[id_sucursal]
        ,FORMAT(t.[fecha], 'MM-yyyy') AS Periodo
        ,v.[id_accesorio]
        ,SUM(v.[ven_cantidad]) AS Ventas
        ,SUM(c.[com_cantidad]) AS Compras
    FROM    
         [ALTA_DATA].[BI_Compra] c 
        ,[ALTA_DATA].[BI_Venta] v 
        ,[ALTA_DATA].[BI_Tiempo] t
	WHERE  
        v.[id_accesorio] = c.[id_accesorio]
        AND v.[id_sucursal] = c.[id_sucursal]
		AND t.[cod_fecha] = c.[cod_fecha]
		and t.[cod_fecha] = v.[cod_fecha]
    GROUP BY 
        v.[id_sucursal]
        ,t.[fecha]
        ,v.[id_accesorio]
GO

-- 8) Ganancias (precio de venta – precio de compra) x Sucursal x mes
CREATE VIEW [ALTA_DATA].[acc_ganancias]
AS 
    SELECT 
        v.[id_sucursal]
        ,FORMAT(t.[fecha], 'MM-yyyy') as Periodo
        ,SUM(v.[ven_cantidad] * v.[ven_precio]) - sum(c.[com_cantidad] * c.com_precio) as ganancias
    FROM 
         [ALTA_DATA].[BI_Compra] c 
        ,[ALTA_DATA].[BI_Venta] v
        ,[ALTA_DATA].[BI_Tiempo] t
    WHERE 
        v.[id_accesorio] = c.[id_accesorio]
        AND v.[cod_fecha] = c.[cod_fecha]
        AND v.[cod_fecha] = t.[cod_fecha]
    GROUP BY 
        v.[id_sucursal],
        t.[fecha]
GO

-- BORRAR TODO: NO DESCOMENTAR
/*
/*
/*
GO
BEGIN
DROP TABLE [ALTA_DATA].[BI_Compra];
DROP TABLE [ALTA_DATA].[BI_Venta];
DROP TABLE [ALTA_DATA].[BI_Tiempo];
DROP TABLE [ALTA_DATA].[BI_Sucursal];
DROP TABLE [ALTA_DATA].[BI_Cliente];
DROP TABLE [ALTA_DATA].[BI_PC];
DROP TABLE [ALTA_DATA].[BI_Accesorio];
DROP TABLE [ALTA_DATA].[BI_Memoria_Ram];
DROP TABLE [ALTA_DATA].[BI_Microprocesador];
DROP TABLE [ALTA_DATA].[BI_Disco_Rigido];
DROP TABLE [ALTA_DATA].[BI_Motherboard];
DROP TABLE [ALTA_DATA].[BI_Placa_Video];
DROP VIEW [ALTA_DATA].[pc_promedio_tiempo_en_stock];
DROP VIEW [ALTA_DATA].[pc_precio_promedio_compra_venta];
DROP VIEW [ALTA_DATA].[pc_cantidad_compra_venta];
DROP VIEW [ALTA_DATA].[pc_ganancias];
DROP VIEW [ALTA_DATA].[acc_promedio_tiempo_en_stock];
DROP VIEW [ALTA_DATA].[acc_precio_promedio_compra_venta];
DROP VIEW [ALTA_DATA].[acc_cantidad_compra_venta];
DROP VIEW [ALTA_DATA].[acc_ganancias];
END
DROP SCHEMA [ALTA_DATA];
*/
*/
*/
