-- CREAR ESQUEMA
CREATE SCHEMA [ALTA_DATA];
GO

-- CREAR TABLAS
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
	  [mic_hilos] DECIMAL(18,0),
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
	  [pc_alto] DECIMAL(18,2),
	  [pc_ancho] DECIMAL(18,2),
	  [pc_profundidad] DECIMAL(18,2)
	);

-- Accesorios

	
	CREATE TABLE [ALTA_DATA].[Accesorios] (
	  [id_accesorio] DECIMAL(18,0) PRIMARY KEY,
	  [acc_descripcion] NVARCHAR(255),
	  [acc_fabricante] NVARCHAR(255)
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
	  [suc_telefono] DECIMAL(18,0)
	);


	CREATE TABLE [ALTA_DATA].[Stock] (
	  [id_stock] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [id_sucursal] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[Sucursal](id_sucursal),
	  [id_pc] NVARCHAR(50) FOREIGN KEY REFERENCES [ALTA_DATA].[PC](id_pc),
	  [id_accesorio] DECIMAL(18,0) FOREIGN KEY REFERENCES [ALTA_DATA].[Accesorios](id_accesorio),
	  [stock_cantidad] INTEGER,
	  [stock_precio] DECIMAL(18,2)
	);

	CREATE TABLE [ALTA_DATA].[Cliente] (
	  [id_cliente] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [cli_apellido] NVARCHAR(255),
	  [cli_nombre] NVARCHAR(255),
	  [cli_direccion] NVARCHAR(255),
	  [cli_dni] DECIMAL(18,0),
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
	  [com_total] DECIMAL(18,2)
	);


	CREATE TABLE [ALTA_DATA].[Item_compra] (
	  [id_itemc] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [id_compra] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[Compra](id_compra),
	  [id_pc] NVARCHAR(50) FOREIGN KEY REFERENCES [ALTA_DATA].[PC](id_pc),
	  [id_accesorio] DECIMAL(18,0) FOREIGN KEY REFERENCES [ALTA_DATA].[Accesorios](id_accesorio),
	  [itemc_cantidad] INTEGER,
	  [itemc_precio] DECIMAL(18,2)
	);


-- Ventas


	CREATE TABLE [ALTA_DATA].[Factura] (
	  [id_factura] DECIMAL(18,0) IDENTITY PRIMARY KEY,
	  [id_cliente] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[Cliente](id_cliente),
	  [id_sucursal] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[Sucursal](id_sucursal),
	  [fac_fecha] DATETIME2,
	  [fact_total] DECIMAL(18,2)
	);
	
	CREATE TABLE [ALTA_DATA].[Item_factura] (
	  [id_itemf] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [id_factura] DECIMAL(18,0) FOREIGN KEY REFERENCES [ALTA_DATA].[Factura](id_factura),
	  [id_pc] NVARCHAR(50) FOREIGN KEY REFERENCES [ALTA_DATA].[PC](id_pc),
	  [id_accesorio] DECIMAL(18,0) FOREIGN KEY REFERENCES [ALTA_DATA].[Accesorios](id_accesorio),
	  [itemf_cantidad] INTEGER,
	  [itemf_precio] DECIMAL(18,2)
	);
END
	

-- MIGRACION DE DATOS --

-- COMPONENTES PC

-- Memoria RAM

BEGIN
-- Memoria RAM
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

-- Accesorios
/*
No hay datos del fabricante de los accesorios por lo que se setea en NULL por ahora
*/
	BEGIN
		INSERT INTO [ALTA_DATA].[Accesorios] (
			   [id_accesorio]
			  ,[acc_descripcion]
			  ,[acc_fabricante]
			)
		SELECT DISTINCT
			 m.ACCESORIO_CODIGO
			,m.AC_DESCRIPCION
			,NULL
		FROM [gd_esquema].[Maestra] m
		WHERE
			m.ACCESORIO_CODIGO IS NOT NULL;
	END;


-- Ciudad
	BEGIN
		INSERT INTO [ALTA_DATA].[Ciudad] (
		  [ciu_nombre]
		)
		SELECT DISTINCT
			m.CIUDAD
		FROM [gd_esquema].[Maestra] m
		WHERE 
			m.CIUDAD IS NOT NULL;
	END;


-- Sucursal
/*
Las sucursales no tienen un id, por lo que dejamos que se genere automaticamente
*/
	BEGIN
		INSERT INTO [ALTA_DATA].[Sucursal] (
		   [id_ciudad]
		  ,[suc_direccion]
		  ,[suc_mail]
		  ,[suc_telefono]
		)
		SELECT DISTINCT
			 id_ciudad
			,m.SUCURSAL_DIR
			,m.SUCURSAL_MAIL
			,m.SUCURSAL_TEL
		FROM [gd_esquema].[Maestra] m
		LEFT JOIN [ALTA_DATA].[Ciudad]
			ON
				ciu_nombre = m.CIUDAD
		WHERE
			m.SUCURSAL_DIR IS NOT NULL
			OR m.SUCURSAL_MAIL IS NOT NULL
			OR m.SUCURSAL_TEL IS NOT NULL;
		

		/* Queries de verificacion */
		/*
		SELECT DISTINCT
			 id_ciudad
			,m.SUCURSAL_DIR
			,m.SUCURSAL_MAIL
			,m.SUCURSAL_TEL
		FROM [gd_esquema].[Maestra] m
		LEFT JOIN (
			SELECT DISTINCT
				ROW_NUMBER() OVER(ORDER BY m.CIUDAD) id_ciudad
				,m.CIUDAD nombre
			FROM [gd_esquema].[Maestra] m
			WHERE 
				m.CIUDAD IS NOT NULL
			GROUP BY 
				m.CIUDAD
			) ciu
			ON
				ciu.nombre = m.CIUDAD
		WHERE
			m.SUCURSAL_DIR IS NOT NULL
			OR m.SUCURSAL_MAIL IS NOT NULL
			OR m.SUCURSAL_TEL IS NOT NULL
		ORDER BY 1

		*/


	END;




-- Cliente
/*
No hay datos sobre el sexo de los clientes por lo que por ahora se setea en NULL
Dado que no hay un id de cliente vamos a tomar por valido cualquier cliente que tenga al menos un campo que no sea NULL
*/
	BEGIN
		INSERT INTO [ALTA_DATA].[Cliente] (
		   [cli_apellido]
		  ,[cli_nombre]
		  ,[cli_direccion]
		  ,[cli_dni]
		  ,[cli_fecha_nacimiento]
		  ,[cli_mail]
		  ,[cli_telefono] 
		  ,[cli_sexo]
		)
		SELECT DISTINCT
			 m.CLIENTE_APELLIDO
			,m.CLIENTE_NOMBRE
			,m.CLIENTE_DIRECCION
			,m.CLIENTE_DNI
			,m.CLIENTE_FECHA_NACIMIENTO
			,m.CLIENTE_MAIL
			,m.CLIENTE_TELEFONO
			,NULL

		FROM [gd_esquema].[Maestra] m
		WHERE 
			m.CLIENTE_APELLIDO IS NOT NULL
			OR m.CLIENTE_NOMBRE IS NOT NULL
			OR m.CLIENTE_DIRECCION IS NOT NULL
			OR m.CLIENTE_DNI IS NOT NULL
			OR m.CLIENTE_FECHA_NACIMIENTO IS NOT NULL
			OR m.CLIENTE_MAIL IS NOT NULL
			OR m.CLIENTE_TELEFONO IS NOT NULL;
	END;


-- Compra
/* 
Para poder mantener el identity en el campo id (Y que sea autonumerico al insertar) y a la vez poder conservar los ids de la tabla maestra
es necesario permitir insertar identity en la tabla. Luego se deshabilita para impedir que se ingresen IDs invalidos durante el funcionamiento normal
*/
	BEGIN
		SET IDENTITY_INSERT [ALTA_DATA].[Compra] ON;
		INSERT INTO [ALTA_DATA].[Compra] (
		   [id_compra]
		  ,[id_sucursal]
		  ,[com_fecha] 
		  ,[com_total] 
		)
		SELECT DISTINCT
			 m.COMPRA_NUMERO
			,id_sucursal
			,m.COMPRA_FECHA
			,SUM(COMPRA_PRECIO)

		FROM [gd_esquema].[Maestra] m
		LEFT JOIN [ALTA_DATA].[Sucursal]
			ON
				suc_direccion = m.SUCURSAL_DIR
				AND suc_mail = m.SUCURSAL_MAIL
				AND suc_telefono = m.SUCURSAL_TEL
		WHERE 
			m.COMPRA_NUMERO IS NOT NULL
		GROUP BY 
			 m.COMPRA_NUMERO
			,id_sucursal
			,m.COMPRA_FECHA;
		SET IDENTITY_INSERT [ALTA_DATA].[Compra] OFF;
		/* Query de prueba */
		/*
		SELECT DISTINCT
			 m.COMPRA_NUMERO
			,m.COMPRA_FECHA
			,SUM(COMPRA_PRECIO)

		FROM [gd_esquema].[Maestra] m
		WHERE 
			m.COMPRA_NUMERO IS NOT NULL
		GROUP BY 
			 m.COMPRA_NUMERO
			,m.COMPRA_FECHA;
		*/

	END;
		


-- Item_compra		
/*
Al no haber un id para cada item de una compra se deja que el identity genere uno automaticamente
*/
	BEGIN
		INSERT INTO [ALTA_DATA].[Item_compra] (
		   [id_compra]
		  ,[id_pc] 
		  ,[id_accesorio] 
		  ,[itemc_cantidad]
		  ,[itemc_precio]
		)
		SELECT DISTINCT
			 m.COMPRA_NUMERO
			,m.PC_CODIGO
			,m.ACCESORIO_CODIGO
			,m.COMPRA_CANTIDAD
			,m.COMPRA_PRECIO

		FROM [gd_esquema].[Maestra] m
		WHERE COMPRA_NUMERO IS NOT NULL
	END;

-- Facturas
/*
Idem caso de los ids con la tabla de Compra
Dado que los precios de venta son calculados en base a los precios de compra de cada producto. Por ahora se deja en NULL el precio total de la factura
*/
	BEGIN
		SET IDENTITY_INSERT [ALTA_DATA].[Factura] ON;
		INSERT INTO [ALTA_DATA].[Factura] (
		   [id_factura]
		  ,[id_cliente]
		  ,[id_sucursal]
		  ,[fac_fecha]
		  ,[fact_total]
		)
		SELECT DISTINCT
			 m.FACTURA_NUMERO
			,id_cliente
			,id_sucursal
			,m.FACTURA_FECHA
			,NULL
		FROM [gd_esquema].[Maestra] m
		LEFT JOIN [ALTA_DATA].[Cliente]
			ON
				m.CLIENTE_APELLIDO = cli_apellido
				AND m.CLIENTE_NOMBRE = cli_nombre
				AND m.CLIENTE_DIRECCION = cli_direccion
				AND m.CLIENTE_DNI = cli_dni
				AND m.CLIENTE_FECHA_NACIMIENTO = cli_fecha_nacimiento
				AND m.CLIENTE_MAIL = cli_mail
				AND m.CLIENTE_TELEFONO = cli_telefono
		LEFT JOIN [ALTA_DATA].[Sucursal]
			ON
				m.SUCURSAL_DIR = suc_direccion
				AND m.SUCURSAL_MAIL = suc_mail
				AND m.SUCURSAL_TEL = suc_telefono
		WHERE
			m.FACTURA_NUMERO IS NOT NULL;
		SET IDENTITY_INSERT [ALTA_DATA].[Factura] OFF;
	END;
	
-- Item_factura
/*
Al no haber un id para cada item vendido en una factura se deja que el IDENTITY lo genere automaticamente
Como no se especifica la cantidad de items vendidos se asume que se vende una sola unidad de cada producto
Los precios se calculan como el promedio del precio de compra del producto mas el 20%
*/
	BEGIN
	INSERT INTO [ALTA_DATA].[Item_factura] (
	   [id_factura]
	  ,[id_pc] 
	  ,[id_accesorio] 
	  ,[itemf_cantidad]
	  ,[itemf_precio]
	)
	SELECT DISTINCT
		 m.FACTURA_NUMERO
		,m.PC_CODIGO
		,m.ACCESORIO_CODIGO
		,1
		,(
			SELECT TOP 1
				AVG(itc.itemc_precio)*1.2
			FROM [ALTA_DATA].[Item_compra] itc
			WHERE 
				itc.id_accesorio = m.ACCESORIO_CODIGO
				OR itc.id_pc = m.PC_CODIGO
			GROUP BY
				 itc.id_pc
				,itc.id_accesorio
		)

	FROM [gd_esquema].[Maestra] m
	WHERE
		m.FACTURA_NUMERO IS NOT NULL

		/* Queries de prueba */
		/*
		select 
			 id_accesorio
			,id_pc
			,avg(itemc_precio)*1.2
		from ALTA_DATA.Item_compra
		group by
			id_accesorio
			,id_pc
		*/
	END;

-- Actualizacion total factura
/*
Se actualizan los precios totales de cada factura segun la suma de los items vendidos en esa factura
*/
	BEGIN
		UPDATE [ALTA_DATA].[Factura]
		SET	fact_total = itf.total
		FROM [ALTA_DATA].[Factura] f
		JOIN (
			SELECT
				id_factura id_factura
				,SUM(itemf_cantidad * itemf_precio) total
			FROM [ALTA_DATA].[Item_factura]
			GROUP BY
				id_factura
			) itf
		ON
			itf.id_factura = f.id_factura
	END;


-- Stock
/* 
El Stock se hace al final porque tenemos que calcular el stock actual en base a todas las compras y ventas que se hicieron
El precio en stock se calcula como el precio promedio de compra de cada producto mas el 20%
*/
	BEGIN
		INSERT INTO [ALTA_DATA].[Stock] (
		   [id_sucursal]
		  ,[id_pc]
		  ,[id_accesorio]
		  ,[stock_cantidad]
		  ,[stock_precio]
		)
		SELECT
			 f.id_sucursal
			,itf.id_pc
			,itf.id_accesorio
			,(SELECT TOP 1
					SUM(itc.itemc_cantidad)
				FROM [ALTA_DATA].[Item_compra] itc, [ALTA_DATA].[Compra] c
				WHERE
					c.id_sucursal = f.id_sucursal
					AND c.id_compra = itc.id_compra
					AND (itc.id_pc = itf.id_pc 
					OR itc.id_accesorio = itf.id_accesorio)
				GROUP BY
					c.id_sucursal
					,itc.id_pc
					,itc.id_accesorio
				) - SUM(itf.itemf_cantidad)
			,(SELECT TOP 1
					AVG(itc.itemc_precio) * 1.2
				FROM [ALTA_DATA].[Item_compra] itc, [ALTA_DATA].[Compra] c
				WHERE
					c.id_sucursal = f.id_sucursal
					AND c.id_compra = itc.id_compra
					AND (itc.id_pc = itf.id_pc 
					OR itc.id_accesorio = itf.id_accesorio)
				GROUP BY
					c.id_sucursal
					,itc.id_pc
					,itc.id_accesorio
				)
		FROM [ALTA_DATA].[Item_factura] itf
		JOIN [ALTA_DATA].[Factura] f
			ON f.id_factura = itf.id_factura

		GROUP BY
			f.id_sucursal,
			itf.id_pc,
			itf.id_accesorio;
	END;
	

-- Constraints adicionales

	BEGIN
	--Stock
	/*
	Como el stock de un producto para determinada sucursal no puede ser menor a cero agregamos una constraint para eso
	*/
		ALTER TABLE [ALTA_DATA].[Stock]
		ADD CONSTRAINT stock_positivo
		CHECK (stock_cantidad >= 0);

	END;
END;
GO

	
-- Triggers

-- Actualizar el stock al crearse una factura
CREATE TRIGGER [ALTA_DATA].[actualizar_stock_al_facturar]
ON [ALTA_DATA].[Item_factura]
AFTER INSERT
AS

	UPDATE s
	SET	s.stock_cantidad = s.stock_cantidad - i.itemf_cantidad
	FROM [ALTA_DATA].[Stock] s

	JOIN [ALTA_DATA].[Factura] f
		ON
			f.id_sucursal = s.id_sucursal
	JOIN Inserted i
		ON 
			i.id_factura = f.id_factura
	WHERE 
		f.id_sucursal = s.id_sucursal
		AND
			(s.id_pc = i.id_pc
			OR s.id_accesorio = i.id_accesorio)
GO

-- Actualizaz el stock al hacer una compra y el precio del producto
/*
Cuando se hace una compra de un producto se actualiza el precio de ese producto al precio de compra mas un 20%. De esta manera se puede
mantener un precio actualizado ante los cambios del mercado
*/
CREATE TRIGGER [ALTA_DATA].[actualizar_stock_al_comprar]
ON [ALTA_DATA].[Item_compra]
AFTER INSERT
AS

	UPDATE s
	SET	
		 s.stock_cantidad = s.stock_cantidad - i.itemc_cantidad
		,s.stock_precio = i.itemc_precio * 1.2
	FROM [ALTA_DATA].[Stock] s

	JOIN [ALTA_DATA].[Compra] c
		ON
			c.id_sucursal = s.id_sucursal
	JOIN Inserted i
		ON 
			i.id_compra = c.id_compra
	WHERE 
		c.id_sucursal = s.id_sucursal
		AND
			(s.id_pc = i.id_pc
			OR s.id_accesorio = i.id_accesorio)
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