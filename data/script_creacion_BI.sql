-- CREAR ESQUEMA

GO

CREATE SCHEMA [ALTA_DATA];


-- CREAR TABLAS

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
    	  [id_disco_rigido] NVARCHAR FOREIGN KEY REFERENCES [ALTA_DATA].[BI_Disco_Rigido](id_disco_rigido),
    	  [id_memoria_ram] NVARCHAR FOREIGN KEY REFERENCES [ALTA_DATA].[BI_Memoria_Ram](id_memoria_ram),
    	  [id_microprocesador] NVARCHAR FOREIGN KEY REFERENCES [ALTA_DATA].[BI_Microprocesador](id_microprocesador),
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
      [ciu_nombre] INTEGER,
      [suc_telefono] DECIMAL,
      [suc_mail] NVARCHAR (255),
      [suc_direccion] NVARCHAR (255)
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
     [id_pc] NVARCHAR(50),
     [com_fecha] DATETIME2,
     [com_precio] DECIMAL,
     [com_cantidad] DECIMAL,
     [id_accesorio] INTEGER
     );

-- Ventas

	CREATE TABLE [ALTA_DATA].[BI_Venta] (
	[id_venta] INTEGER IDENTITY(1,1) PRIMARY KEY,
	[ven_fecha] DATETIME2,
	[ven_precio] DECIMAL,
	[ven_cantidad] DECIMAL,
	[accesorio] NVARCHAR(255),
	[codigo_pc] NVARCHAR(255)
	);

-- Tiempo

	CREATE TABLE [ALTA_DATA].[BI_Hechos] (
    	  [anio] DECIMAL,
    	  [mes] DECIMAL,
    	  [id_sucursal] INTEGER,
    	  [id_pc] NVARCHAR(50),
    	  [id_accesorio] DECIMAL,
    	  [id_cliente] INTEGER,
    	  [id_venta] INTEGER,
    	  [id_compra] INTEGER
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
Ademas, como no sabemos si todas las columnas tienen valores no nulos lo mejor es filtrar
en el where todas aquellas filas que tengan al menos un campo de la placa de video no nulo
*/
	BEGIN
		INSERT INTO [ALTA_DATA].[BI_Placa_Video] (
		       [id_placa_video]
			   [pv_chipset]
			  ,[pv_modelo]
			  ,[pv_velocidad]
			  ,[pv_capacidad]
			  ,[pv_fabricante]
			)
		SELECT DISTINCT
               m.[id_placa_video]
			   m.[pv_chipset]
			  ,m.[pv_modelo]
			  ,m.[pv_velocidad]
			  ,m.[pv_capacidad]
			  ,m.[pv_fabricante]
		FROM [ALTA_DATA].[Placa_Video] m
			WHERE m.[pv_capacidad]IS NOT NULL
				OR m.[pv_chipset] IS NOT NULL
				OR m.[pv_fabricante]IS NOT NULL
				OR m.[pv_modelo] IS NOT NULL
				OR m.[pv_velocidad] IS NOT NULL;
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

		LEFT JOIN [ALTA_DATA].[BI_Placa_Video]
			ON
				m.pv_capacidad = pv_capacidad
				AND m.pv_chipset = pv_chipset
				AND m.pv_fabricante = pv_fabricante
				AND m.pv_modelo = pv_modelo
				AND m.pv_velocidad = pv_velocidad
		WHERE m.[id_pc] IS NOT NULL;

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
			 [suc_mail]
			,[suc_telefono]
			,[suc_direccion]
			)
		SELECT DISTINCT
			 m.[suc_mail]
			,m.[suc_telefono]
			,m.[suc_direccion]
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

-- Compra
/*
Como no hay codigos de compra, dejamos que se genere un id automaticamente, falta tambien el precio
*/
	BEGIN
		INSERT INTO [ALTA_DATA].[BI_Compra](
			 [com_fecha]
			,[id_pc]
			,[id_accesorio]
			)
		SELECT DISTINCT
			m.[com_fecha]
		   ,p.[id_pc]
		   ,a.[id_accesorio]
		FROM [ALTA_DATA].[Compra] m, [ALTA_DATA].[PC] p , [ALTA_DATA].[Accesorios] a
			WHERE m.[com_fecha] IS NOT NULL
	END;

-- Ventas
/*
Como no hay codigo de ventas dejamos que se genere un id automaticamente, falta tambien el precio
*/
	BEGIN
		INSERT INTO [ALTA_DATA].[BI_Ventas](
			 [ven_fecha]
			,[accesorio]
			,[codigo_pc]
			)
		SELECT DISTINCT
			 m.[ven_fecha]
			,[accesorio]
            ,[codigo_pc]
		FROM [ALTA_DATA].[Ventas] m, [ALTA_DATA].[PC] p, [ALTA_DATA].[Accesorios] a
			WHERE m.[ven_fecha] IS NOT NULL;
	END;

-- Hechos
/*
Como no hay datos de mes y anio en el medelo inicial, ni tampoco id de compra ni de venta
*/
	BEGIN
		INSERT INTO [ALTA_DATA].[BI_Hechos](
			 [id_sucursal]
			,[id_pc]
			,[id_accesorio]
			,[id_cliente]
			)
		SELECT DISTINCT
			 s.[id_sucursal]
            ,p.[id_pc]
            ,a.[id_accesorio]
            ,c.[id_cliente]
		FROM [ALTA_DATA].[Sucursal] s, [ALTA_DATA].[PC] p, [ALTA_DATA].[Accesorios] a, [ALTA_DATA].[Cliente] c
	END;



END;
GO

-- BORRAR NO DESCOMENTAR
/*
/*
/*
GO
BEGIN
DROP TABLE [ALTA_DATA].[Item_factura];
DROP TABLE [ALTA_DATA].[Factura];
DROP TABLE [ALTA_DATA].[Item_compra];
DROP TABLE [ALTA_DATA].[Compra];
DROP TABLE [ALTA_DATA].[Cliente];
DROP TABLE [ALTA_DATA].[Stock];
DROP TABLE [ALTA_DATA].[Sucursal];
DROP TABLE [ALTA_DATA].[Ciudad];
DROP TABLE [ALTA_DATA].[Accesorios];
DROP TABLE [ALTA_DATA].[PC];
DROP TABLE [ALTA_DATA].[Memoria_Ram];
DROP TABLE [ALTA_DATA].[Microprocesador];
DROP TABLE [ALTA_DATA].[Disco_Rigido];
DROP TABLE [ALTA_DATA].[Motherboard];
DROP TABLE [ALTA_DATA].[Placa_Video];
END
DROP SCHEMA [ALTA_DATA];
*/
*/
*/


