-- CREAR ESQUEMA
GO
CREATE SCHEMA [ALTA_DATA];


-- CREAR TABLAS
GO
BEGIN 

-- Componentes PC
	CREATE TABLE [ALTA_DATA].[Memoria_Ram] (
	  [id_memoria_ram] NVARCHAR(255) PRIMARY KEY,
	  [mr_tipo] NVARCHAR(255),
	  [mr_capacidad] NVARCHAR(255),
	  [mr_velocidad] NVARCHAR(255),
	  [mr_fabricante] NVARCHAR(255)
	);

	CREATE TABLE [ALTA_DATA].[Microprocesador] (
	  [id_microprocesador] NVARCHAR(50) PRIMARY KEY,
	  [mic_cache] NVARCHAR(50),
	  [mic_hilos] DECIMAL,
	  [mic_velocidad] NVARCHAR(50),
	  [mic_fabricante] NVARCHAR(255)
	);

	
	CREATE TABLE [ALTA_DATA].[Disco_Rigido] (
	  [id_disco_rigido] NVARCHAR(255) PRIMARY KEY,
	  [dr_tipo] NVARCHAR(255),
	  [dr_capacidad] NVARCHAR(255),
	  [dr_fabricante] NVARCHAR(255),
	  [dr_velocidad] NVARCHAR(255)
	);

	CREATE TABLE [ALTA_DATA].[Motherboard] (
	  [id_motherboard] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [mb_fabricante] NVARCHAR(255)
	);

	CREATE TABLE [ALTA_DATA].[Placa_Video] (
	  [id_placa_video] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [pv_chipset] NVARCHAR(50),
	  [pv_modelo] NVARCHAR(50),
	  [pv_velocidad] NVARCHAR(50),
	  [pv_capacidad] NVARCHAR(255),
	  [pv_fabricante] NVARCHAR(255)
	);

	CREATE TABLE [ALTA_DATA].[PC] (
	  [id_pc] NVARCHAR(50) PRIMARY KEY,
	  [id_disco_rigido] NVARCHAR(255) FOREIGN KEY REFERENCES [ALTA_DATA].[Disco_Rigido](id_disco_rigido),
	  [id_memoria_ram] NVARCHAR(255) FOREIGN KEY REFERENCES [ALTA_DATA].[Memoria_Ram](id_memoria_ram),
	  [id_microprocesador] NVARCHAR(50) FOREIGN KEY REFERENCES [ALTA_DATA].[Microprocesador](id_microprocesador),
	  [id_placa_video] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[Placa_Video](id_placa_video),
	  [id_motherboard] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[Motherboard](id_motherboard),
	  [pc_alto] DECIMAL,
	  [pc_ancho] DECIMAL,
	  [pc_profundidad] DECIMAL
	);

-- Accesorios

	
	CREATE TABLE [ALTA_DATA].[Accesorios] (
	  [id_accesorio] DECIMAL PRIMARY KEY,
	  [acc_descripcion] NVARCHAR(255),
	  [acc_fabricante] NVARCHAR
	);

-- Sucursales

	CREATE TABLE [ALTA_DATA].[Ciudad] (
	  [id_ciudad] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [ciu_nombre] NVARCHAR(255)
	);

	CREATE TABLE [ALTA_DATA].[Sucursal] (
	  [id_sucursal] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [id_ciudad] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[Ciudad](id_ciudad),
	  [suc_direccion] NVARCHAR(255),
	  [suc_mail] NVARCHAR(255),
	  [suc_telefono] DECIMAL
	);


	CREATE TABLE [ALTA_DATA].[Stock] (
	  [id_stock] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [id_sucursal] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[Sucursal](id_sucursal),
	  [id_pc] NVARCHAR(50) FOREIGN KEY REFERENCES [ALTA_DATA].[PC](id_pc),
	  [id_accesorio] DECIMAL FOREIGN KEY REFERENCES [ALTA_DATA].[Accesorios](id_accesorio),
	  [stock_cantidad] INTEGER
	);

	CREATE TABLE [ALTA_DATA].[Cliente] (
	  [id_cliente] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [cli_apellido] NVARCHAR(255),
	  [cli_nombre] NVARCHAR(255),
	  [cli_direccion] NVARCHAR(255),
	  [cli_dni] DECIMAL,
	  [cli_fecha_nacimiento] DATETIME2,
	  [cli_mail] NVARCHAR(255),
	  [cli_telefono] INT,
	  [cli_sexo] CHAR NULL
	);

-- Compras
	

	CREATE TABLE [ALTA_DATA].[Compra] (
	  [id_compra] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [id_sucursal] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[Sucursal](id_sucursal) ,
	  [com_fecha] DATETIME2,
	  [com_total] DECIMAL
	);


	CREATE TABLE [ALTA_DATA].[Item_compra] (
	  [id_itemc] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [id_compra] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[Compra](id_compra),
	  [id_pc] NVARCHAR(50) FOREIGN KEY REFERENCES [ALTA_DATA].[PC](id_pc),
	  [id_accesorio] DECIMAL FOREIGN KEY REFERENCES [ALTA_DATA].[Accesorios](id_accesorio),
	  [itemc_cantidad] INTEGER,
	  [itemc_precio] DECIMAL
	);


-- Ventas


	CREATE TABLE [ALTA_DATA].[Factura] (
	  [id_factura] DECIMAL IDENTITY PRIMARY KEY,
	  [id_cliente] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[Cliente](id_cliente),
	  [id_sucursal] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[Sucursal](id_sucursal),
	  [fac_fecha] DATETIME2,
	  [fact_total] DECIMAL
	);
	
	CREATE TABLE [ALTA_DATA].[Item_factura] (
	  [id_itemf] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [id_factura] DECIMAL FOREIGN KEY REFERENCES [ALTA_DATA].[Factura](id_factura),
	  [id_pc] NVARCHAR(50) FOREIGN KEY REFERENCES [ALTA_DATA].[PC](id_pc),
	  [id_accesorio] DECIMAL FOREIGN KEY REFERENCES [ALTA_DATA].[Accesorios](id_accesorio),
	  [itemf_cantidad] INTEGER,
	  [itemf_precio] DECIMAL
	);
END
	

-- MIGRACION DE DATOS --

-- COMPONENTES PC

-- Memoria RAM
GO
BEGIN
	BEGIN
		INSERT INTO [ALTA_DATA].[Memoria_Ram](
			 [id_memoria_ram]
			,[mr_tipo]
			,[mr_capacidad]
			,[mr_velocidad]
			,[mr_fabricante]
			)
		SELECT DISTINCT 
			 m.MEMORIA_RAM_CODIGO
			,m.MEMORIA_RAM_TIPO
			,m.MEMORIA_RAM_CAPACIDAD
			,m.MEMORIA_RAM_VELOCIDAD 
			,m.MEMORIA_RAM_FABRICANTE
		FROM [gd_esquema].[Maestra] m
			WHERE m.MEMORIA_RAM_CODIGO IS NOT NULL

	END;
-- Microprocesador
	BEGIN
		INSERT INTO [ALTA_DATA].[Microprocesador](
			   [id_microprocesador]
			  ,[mic_cache]
			  ,[mic_hilos]
			  ,[mic_velocidad]
			  ,[mic_fabricante]
			 )
		SELECT DISTINCT
			 m.MICROPROCESADOR_CODIGO
			,m.MICROPROCESADOR_CACHE
			,m.MICROPROCESADOR_CANT_HILOS
			,m.MICROPROCESADOR_VELOCIDAD
			,m.MICROPROCESADOR_FABRICANTE
		FROM [gd_esquema].[Maestra] m
			WHERE m.MICROPROCESADOR_CODIGO IS NOT NULL;
	END;
-- Disco rigido
	BEGIN
		INSERT INTO [ALTA_DATA].[Disco_Rigido] (
			   [id_disco_rigido]
			  ,[dr_tipo] 
			  ,[dr_capacidad] 
			  ,[dr_fabricante]
			  ,[dr_velocidad] 
			)
		SELECT DISTINCT
			 m.DISCO_RIGIDO_CODIGO
			,m.DISCO_RIGIDO_TIPO
			,m.DISCO_RIGIDO_CAPACIDAD
			,m.DISCO_RIGIDO_FABRICANTE
			,m.DISCO_RIGIDO_VELOCIDAD
		FROM [gd_esquema].[Maestra] m
			WHERE m.DISCO_RIGIDO_CODIGO IS NOT NULL;
	END
-- Motherboard
/*
No hay datos de las motherboards en la tabla original
*/
	
-- Placa de video
/* 
Como no hay codigos de las placas de video dejamos que se genere un id automaticamente
Ademas, como no sabemos si todas las columnas tienen valores no nulos lo mejor es filtrar 
en el where todas aquellas filas que tengan al menos un campo de la placa de video no nulo
*/
	BEGIN
		INSERT INTO [ALTA_DATA].[Placa_Video] (
			   [pv_chipset]
			  ,[pv_modelo]
			  ,[pv_velocidad]
			  ,[pv_capacidad]
			  ,[pv_fabricante]
			)
		SELECT DISTINCT
			 m.PLACA_VIDEO_CHIPSET 
			,m.PLACA_VIDEO_MODELO
			,m.PLACA_VIDEO_VELOCIDAD 
			,m.PLACA_VIDEO_CAPACIDAD 
			,m.PLACA_VIDEO_FABRICANTE			
		FROM [gd_esquema].[Maestra] m
			WHERE m.PLACA_VIDEO_CAPACIDAD IS NOT NULL
				OR m.PLACA_VIDEO_CHIPSET IS NOT NULL
				OR PLACA_VIDEO_FABRICANTE IS NOT NULL
				OR PLACA_VIDEO_MODELO IS NOT NULL
				OR PLACA_VIDEO_VELOCIDAD IS NOT NULL;
	END;

-- PC
/*
No hay datos de las motherboards asi que por ahora va a quedar en NULL este campo
*/

	BEGIN
		INSERT INTO [ALTA_DATA].[PC] (
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
			 m.PC_CODIGO
			,m.DISCO_RIGIDO_CODIGO
			,m.MEMORIA_RAM_CODIGO
			,m.MICROPROCESADOR_CODIGO
			,id_placa_video
			,NULL 
			,m.PC_ALTO
			,m.PC_ANCHO
			,m.PC_PROFUNDIDAD
		FROM [gd_esquema].[Maestra] m

		LEFT JOIN [ALTA_DATA].[Placa_Video] 
			ON
				m.PLACA_VIDEO_CAPACIDAD = pv_capacidad
				AND m.PLACA_VIDEO_CHIPSET = pv_chipset
				AND m.PLACA_VIDEO_FABRICANTE = pv_fabricante
				AND m.PLACA_VIDEO_MODELO = pv_modelo
				AND m.PLACA_VIDEO_VELOCIDAD = pv_velocidad
		WHERE m.PC_CODIGO IS NOT NULL;

	END;

/* Queries verificacion PCs
SELECT DISTINCT
	 m.PC_CODIGO
	,m.DISCO_RIGIDO_CODIGO
	,m.MEMORIA_RAM_CODIGO
	,m.MICROPROCESADOR_CODIGO
	,id_placa_video
	,NULL 
	,m.PC_ALTO
	,m.PC_ANCHO
	,m.PC_PROFUNDIDAD
FROM [gd_esquema].[Maestra] m

-- La tabla de placa_video esta como una subquery
LEFT JOIN ( 
	SELECT DISTINCT
		ROW_NUMBER() OVER(ORDER BY m.PLACA_VIDEO_CHIPSET) id_placa_video -- Genero un id al vuelo con ROW_NUMBER
		,m.PLACA_VIDEO_CAPACIDAD pv_capacidad
		,m.PLACA_VIDEO_CHIPSET pv_chipset
		,m.PLACA_VIDEO_FABRICANTE pv_fabricante
		,m.PLACA_VIDEO_MODELO pv_modelo
		,m.PLACA_VIDEO_VELOCIDAD pv_velocidad
	FROM [gd_esquema].[Maestra] m
		WHERE m.PLACA_VIDEO_CAPACIDAD IS NOT NULL
			OR m.PLACA_VIDEO_CHIPSET IS NOT NULL
			OR PLACA_VIDEO_FABRICANTE IS NOT NULL
			OR PLACA_VIDEO_MODELO IS NOT NULL
			OR PLACA_VIDEO_VELOCIDAD IS NOT NULL
	GROUP BY m.PLACA_VIDEO_CAPACIDAD -- El group by es para que el row_number no me cree un id para cada fila que tiene placa de video en la tabla maestra
								,m.PLACA_VIDEO_CHIPSET 
								,m.PLACA_VIDEO_FABRICANTE 
								,m.PLACA_VIDEO_MODELO 
								,m.PLACA_VIDEO_VELOCIDAD
	) pv
		ON
		m.PLACA_VIDEO_CAPACIDAD = pv_capacidad
		AND m.PLACA_VIDEO_CHIPSET = pv_chipset
		AND PLACA_VIDEO_FABRICANTE = pv_fabricante
		AND PLACA_VIDEO_MODELO = pv_modelo
		AND PLACA_VIDEO_VELOCIDAD = pv_velocidad
WHERE PC_CODIGO IS NOT NULL


select distinct pc_codigo
from gd_esquema.Maestra
where pc_codigo is not null
*/















END;
GO

-- BORRAR TODO: NO DESCOMENTAR
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
DROP TABLE  [ALTA_DATA].[Memoria_Ram];
DROP TABLE [ALTA_DATA].[Microprocesador];
DROP TABLE [ALTA_DATA].[Disco_Rigido];
DROP TABLE [ALTA_DATA].[Motherboard];
DROP TABLE [ALTA_DATA].[Placa_Video];
END
DROP SCHEMA [ALTA_DATA];
*/
*/
*/