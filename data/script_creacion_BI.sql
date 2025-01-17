
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

--1 Promedio de tiempo en stock de cada modelo de Pc.


/* hay que ver como hacer el tema del tiempo en stock (restar fechas) */

--2 Precio promedio de PCs, vendidos y comprados - PC

CREATE VIEW precio_promedio_pc_compra_venta
AS
	SELECT v.id_pc,
	 AVG(ISNULL(v.ven_precio,0))  AS promedio_precio_venta,
     AVG(ISNULL(c.com_precio,0))  AS promedio_precio_compra
	FROM ALTA_DATA.BI_Venta v, ALTA_DATA.BI_Compra c
    GROUP BY v.id_pc
GO


/*El precio promedio de venta no se puede hacer por que no se cuenta con esa informacion desde Item Factura - Ventas */


--3 Cantidad de PCs, vendidos y comprados x sucursal y mes - PC

    CREATE VIEW cantidad_pc_compradas_por_sucursal_por_mes
	AS
	    DECLARE @codigopc NVARCHAR(50)
		DECLARE @suc INTEGER
		DECLARE @mes DECIMAL
		SELECT c.id_pc, c.id_sucursal, t.mes,
		SUM(com_cantidad) cantidad
		FROM ALTA_DATA.BI_Compra c, ALTA_DATA.BI_Tiempo t
		WHERE c.id_pc= @codigopc
		AND c.id_sucursal = @suc
		AND t.mes = @mes
GO

--4 Ganancias (precio de venta – precio de compra) x Sucursal x mes - PC

CREATE VIEW ganancia_por_sucursal_por_mes
AS
	DECLARE @suc INTEGER
	DECLARE @mes DECIMAL
	SELECT v.ven_precio, c.com_precio, s.id_sucursal, t.mes, (v.ven_precio - c.com_precio) ganancia
	FROM ALTA_DATA.BI_Venta v, ALTA_DATA.BI_Compra c, ALTA_DATA.BI_Sucursal s, ALTA_DATA.BI_Tiempo t
	WHERE c.id_sucursal = @suc
		AND t.mes = @mes
	RETURN ganancia
GO



----------------------------------------------------------------------------------------------------------------


--1 Precio promedio, vendido y comprado - Accesorio

CREATE VIEW precio_promedio_acc_compra_venta
AS
	SELECT v.id_accesorio,
	 AVG(ISNULL(v.ven_precio,0))  AS promedio_precio_venta,
     AVG(ISNULL(c.com_precio,0))  AS promedio_precio_compra
	FROM ALTA_DATA.BI_Venta v, ALTA_DATA.BI_Compra c
    GROUP BY v.id_accesorio
GO

/*El precio promedio de venta no se puede hacer por que no se cuenta con esa informacion desde Item Factura - Ventas */


--2 Ganancias (precio de venta – precio de compra) x Sucursal x mes - Accesorio

CREATE VIEW ganancia_por_sucursal_por_mes
AS
	DECLARE @suc INTEGER
	DECLARE @mes DECIMAL
	SELECT v.ven_precio, c.com_precio, s.id_sucursal, t.mes, (v.ven_precio - c.com_precio) ganancia
	FROM ALTA_DATA.BI_Venta v, ALTA_DATA.BI_Compra c, ALTA_DATA.BI_Sucursal s, ALTA_DATA.BI_Tiempo t
	WHERE c.id_sucursal = @suc
		AND t.mes = @mes
	RETURN ganancia
GO

--3 Promedio de tiempo en stock de cada modelo - Accesorio


/* hay que ver como hacer el tema del tiempo en stock (restar fechas) */


--4 Máxima cantidad de stock por cada sucursal (anual)- Accesorio

    CREATE VIEW max_cantidad_acc_por_sucursal_por_mes
	AS
		DECLARE @codigoacc NVARCHAR(50)
		DECLARE @suc INTEGER
		DECLARE @mes DECIMAL
		SELECT c.id_accesorio, c.id_sucursal, t.mes,
-- Hay que ver como hacer el tema del stock, Debido a que no hay ninguna entidad STOCK
		FROM ALTA_DATA.BI_Compra c, ALTA_DATA.BI_Tiempo t
		WHERE c.id_accesorio= @codigoacc
		AND c.id_sucursal = @suc
		AND t.mes = @mes
GO



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