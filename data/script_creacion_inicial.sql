-- CREAR ESQUEMA
CREATE SCHEMA [ALTA_DATA];
GO

-- CREAR TABLAS
BEGIN 
	CREATE TABLE [ALTA_DATA].[PC] (
	  [id_pc] NVARCHAR PRIMARY KEY,
	  [id_disco_rigido] NVARCHAR,
	  [id_memoria_ram] NVARCHAR,
	  [id_microprocesador] NVARCHAR,
	  [id_placa_video] INTEGER,
	  [id_motherboard] INTEGER,
	  [pc_alto] DECIMAL,
	  [pc_ancho] DECIMAL,
	  [pc_profundidad] DECIMAL
	);

	CREATE TABLE [ALTA_DATA].[Sucursal] (
	  [id_sucursal] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [id_ciudad] INTEGER,
	  [suc_direccion] NVARCHAR,
	  [suc_mail] NVARCHAR,
	  [suc_telefono] DECIMAL
	);

	CREATE TABLE [ALTA_DATA].[Item_factura] (
	  [id_itemf] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [id_factura] INTEGER,
	  [id_pc] INTEGER,
	  [id_accesorio] INTEGER,
	  [itemf_cantidad] INTEGER,
	  [itemf_precio] DECIMAL
	);

	CREATE TABLE [ALTA_DATA].[Memoria_Ram] (
	  [id_memoria_ram] NVARCHAR PRIMARY KEY,
	  [mr_tipo] NVARCHAR,
	  [mr_capacidad] NVARCHAR,
	  [mr_velocidad] NVARCHAR,
	  [mr_fabricante] NVARCHAR
	);

	CREATE TABLE [ALTA_DATA].[Compra] (
	  [id_compra] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [id_sucursal] INTEGER,
	  [com_fecha] DATETIME2,
	  [com_total] DECIMAL
	);

	CREATE TABLE [ALTA_DATA].[Item_compra] (
	  [id_itemc] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [id_compra] INTEGER,
	  [id_pc] NVARCHAR,
	  [id_accesorio] DECIMAL,
	  [itemc_cantidad] INTEGER,
	  [itemc_precio] DECIMAL
	);

	CREATE TABLE [ALTA_DATA].[Microprocesador] (
	  [id_microprocesador] NVARCHAR PRIMARY KEY,
	  [mic_cache] NVARCHAR,
	  [mic_hilos] DECIMAL,
	  [mic_velocidad] NVARCHAR,
	  [mic_fabricante] NVARCHAR
	);

	CREATE TABLE [ALTA_DATA].[Ciudad] (
	  [id_ciudad] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [ciu_nombre] NVARCHAR
	);

	CREATE TABLE [ALTA_DATA].[Stock] (
	  [id_stock] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [id_sucursal] INTEGER,
	  [id_pc (fk)] NVARCHAR,
	  [id_accesorio] DECIMAL,
	  [stock_cantidad] INTEGER
	);

	CREATE TABLE [ALTA_DATA].[Accesorios] (
	  [id_accesorio] DECIMAL,
	  [acc_descripcion] NVARCHAR,
	  [acc_fabricante] NVARCHAR
	);

	CREATE TABLE [ALTA_DATA].[Disco_Rigido] (
	  [id_disco_rigido] NVARCHAR,
	  [dr_tipo] NVARCHAR,
	  [dr_capacidad] NVARCHAR,
	  [dr_fabricante] NVARCHAR,
	  [dr_velocidad] NVARCHAR
	);

	CREATE TABLE [ALTA_DATA].[Motherboard] (
	  [id_motherboard (pk)] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [mb_fabricante] NVARCHAR
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

	CREATE TABLE [ALTA_DATA].[Placa_Video] (
	  [id_placa_video] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [pv_chipset] NVARCHAR,
	  [pv_modelo] NVARCHAR,
	  [pv_velocidad] NVARCHAR,
	  [pv_capacidad] NVARCHAR,
	  [pv_fabricante] NVARCHAR
	);

	CREATE TABLE [ALTA_DATA].[Factura] (
	  [id_factura] DECIMAL IDENTITY PRIMARY KEY,
	  [id_cliente] INTEGER,
	  [id_sucursal] INTEGER,
	  [fac_fecha] DATETIME2,
	  [fact_total] DECIMAL
	);
END
	