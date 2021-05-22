-- CREAR ESQUEMA
CREATE SCHEMA [ALTA_DATA];
GO

-- CREAR TABLAS
BEGIN 

-- Componentes PC
	CREATE TABLE [ALTA_DATA].[Memoria_Ram] (
	  [id_memoria_ram] NVARCHAR PRIMARY KEY,
	  [mr_tipo] NVARCHAR,
	  [mr_capacidad] NVARCHAR,
	  [mr_velocidad] NVARCHAR,
	  [mr_fabricante] NVARCHAR
	);

	CREATE TABLE [ALTA_DATA].[Microprocesador] (
	  [id_microprocesador] NVARCHAR PRIMARY KEY,
	  [mic_cache] NVARCHAR,
	  [mic_hilos] DECIMAL,
	  [mic_velocidad] NVARCHAR,
	  [mic_fabricante] NVARCHAR
	);

	
	CREATE TABLE [ALTA_DATA].[Disco_Rigido] (
	  [id_disco_rigido] NVARCHAR PRIMARY KEY,
	  [dr_tipo] NVARCHAR,
	  [dr_capacidad] NVARCHAR,
	  [dr_fabricante] NVARCHAR,
	  [dr_velocidad] NVARCHAR
	);

	CREATE TABLE [ALTA_DATA].[Motherboard] (
	  [id_motherboard] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [mb_fabricante] NVARCHAR
	);

	CREATE TABLE [ALTA_DATA].[Placa_Video] (
	  [id_placa_video] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [pv_chipset] NVARCHAR,
	  [pv_modelo] NVARCHAR,
	  [pv_velocidad] NVARCHAR,
	  [pv_capacidad] NVARCHAR,
	  [pv_fabricante] NVARCHAR
	);

	CREATE TABLE [ALTA_DATA].[PC] (
	  [id_pc] NVARCHAR PRIMARY KEY,
	  [id_disco_rigido] NVARCHAR FOREIGN KEY REFERENCES [ALTA_DATA].[Disco_Rigido](id_disco_rigido),
	  [id_memoria_ram] NVARCHAR FOREIGN KEY REFERENCES [ALTA_DATA].[Memoria_Ram](id_memoria_ram),
	  [id_microprocesador] NVARCHAR FOREIGN KEY REFERENCES [ALTA_DATA].[Microprocesador](id_microprocesador),
	  [id_placa_video] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[Placa_Video](id_placa_video),
	  [id_motherboard] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[Motherboard](id_motherboard),
	  [pc_alto] DECIMAL,
	  [pc_ancho] DECIMAL,
	  [pc_profundidad] DECIMAL
	);

-- Accesorios

	
	CREATE TABLE [ALTA_DATA].[Accesorios] (
	  [id_accesorio] DECIMAL PRIMARY KEY,
	  [acc_descripcion] NVARCHAR,
	  [acc_fabricante] NVARCHAR
	);

-- Sucursales

	CREATE TABLE [ALTA_DATA].[Ciudad] (
	  [id_ciudad] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [ciu_nombre] NVARCHAR
	);

	CREATE TABLE [ALTA_DATA].[Sucursal] (
	  [id_sucursal] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [id_ciudad] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[Ciudad](id_ciudad),
	  [suc_direccion] NVARCHAR,
	  [suc_mail] NVARCHAR,
	  [suc_telefono] DECIMAL
	);


	CREATE TABLE [ALTA_DATA].[Stock] (
	  [id_stock] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [id_sucursal] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[Sucursal](id_sucursal),
	  [id_pc (fk)] NVARCHAR FOREIGN KEY REFERENCES [ALTA_DATA].[PC](id_pc),
	  [id_accesorio] DECIMAL FOREIGN KEY REFERENCES [ALTA_DATA].[Accesorios](id_accesorio),
	  [stock_cantidad] INTEGER
	);

	CREATE TABLE [ALTA_DATA].[Cliente] (
	  [id_cliente] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [cli_apellido] NVARCHAR,
	  [cli_nombre] NVARCHAR,
	  [cli_direccion] NVARCHAR,
	  [cli_dni] DECIMAL,
	  [cli_fecha_nacimiento] DATETIME2,
	  [cli_mail] NVARCHAR,
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
	  [id_pc] NVARCHAR FOREIGN KEY REFERENCES [ALTA_DATA].[PC](id_pc),
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
	  [id_pc] NVARCHAR FOREIGN KEY REFERENCES [ALTA_DATA].[PC](id_pc),
	  [id_accesorio] DECIMAL FOREIGN KEY REFERENCES [ALTA_DATA].[Accesorios](id_accesorio),
	  [itemf_cantidad] INTEGER,
	  [itemf_precio] DECIMAL
	);
END
	
