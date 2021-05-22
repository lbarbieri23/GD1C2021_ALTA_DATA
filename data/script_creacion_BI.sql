-- CREAR ESQUEMA
CREATE SCHEMA [ALTA_DATA];
GO

-- CREAR TABLAS
BEGIN

	CREATE TABLE [ALTA_DATA].[BI_Dim_Compra] (
	  [id_compra] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [id_pc] NVARCHAR,
	  [fecha] DATETIME2,
	  [precio] DECIMAL,
	  [id_accesorio] INTEGER
	);


	CREATE TABLE [ALTA_DATA].[BI_Dim_Accesorio] (
	  [id_accesorio] DECIMAL PRIMARY KEY,
	  [acc_fabricante] NVARCHAR,
	  [acc_descripcion] NVARCHAR
	);

	CREATE TABLE [ALTA_DATA].[BI_Dim_Sucursal] (
	  [id_sucursal] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [ciu_nombre] INTEGER,
	  [suc_telefono] DECIMAL,
	  [suc_mail] NVARCHAR,
	  [suc_direccion] NVARCHAR
	);

	CREATE TABLE [ALTA_DATA].[BI_Dim_Cliente] (
	  [id_cliente] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [cli_fecha_nacimiento] DATETIME2,
	  [cli_sexo] CHAR NULL
	);

	CREATE TABLE [ALTA_DATA].[BI_Dim_Venta] (
	  [id_venta] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [fecha] DATETIME2,
	  [precio] DECIMAL,
	  [accesorio] NVARCHAR,
	  [codigo_pc] NVARCHAR
	);

	CREATE TABLE [ALTA_DATA].[BI_Dim_Hechos] (
	  [anio] DECIMAL,
	  [mes] DECIMAL,
	  [id_sucursal] INTEGER,
	  [id_pc] NVARCHAR,
	  [id_cliente] INTEGER,
	  [id_venta] INTEGER,
	  [id_compra] INTEGER
	);

	CREATE TABLE [ALTA_DATA].[BI_Dim_Memoria_Ram] (
	  [id_memoria_ram] NVARCHAR PRIMARY KEY,
	  [mr_tipo] NVARCHAR,
	  [mr_capacidad] NVARCHAR,
	  [mr_velocidad] NVARCHAR,
	  [mr_fabricante] NVARCHAR
	);

	CREATE TABLE [ALTA_DATA].[BI_Dim_Microprocesador] (
	  [id_microprocesador] NVARCHAR PRIMARY KEY,
	  [mic_cache] NVARCHAR,
	  [mic_hilos] DECIMAL,
	  [mic_velocidad] NVARCHAR,
	  [mic_fabricante] NVARCHAR
	);

	CREATE TABLE [ALTA_DATA].[BI_Dim_Disco_Rigido] (
	  [id_disco_rigido] NVARCHAR PRIMARY KEY,
	  [dr_tipo] NVARCHAR,
	  [dr_capacidad] NVARCHAR,
	  [dr_fabricante] NVARCHAR,
	  [dr_velocidad] NVARCHAR
	);

	CREATE TABLE [ALTA_DATA].[BI_Dim_Placa_Video] (
	  [id_placa_video] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [pv_chipset] NVARCHAR,
	  [pv_modelo] NVARCHAR,
	  [pv_velocidad] NVARCHAR,
	  [pv_capacidad] NVARCHAR,
	  [pv_fabricante] NVARCHAR
	);

	CREATE TABLE [ALTA_DATA].[BI_Dim_Motherboard] (
	  [id_motherboard] INTEGER IDENTITY(1,1) PRIMARY KEY,
	  [mb_fabricante] NVARCHAR
	);

	CREATE TABLE [ALTA_DATA].[BI_Dim_PC] (
	  [id_pc] NVARCHAR PRIMARY KEY,
	  [id_disco_rigido] NVARCHAR FOREIGN KEY REFERENCES [ALTA_DATA].[BI_Dim_Disco_Rigido](id_disco_rigido),
	  [id_memoria_ram] NVARCHAR FOREIGN KEY REFERENCES [ALTA_DATA].[BI_Dim_Memoria_Ram](id_memoria_ram),
	  [id_microprocesador] NVARCHAR FOREIGN KEY REFERENCES [ALTA_DATA].[BI_Dim_Microprocesador](id_microprocesador),
	  [id_placa_video] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[BI_Dim_Placa_Video](id_placa_video),
	  [id_motherboard] INTEGER FOREIGN KEY REFERENCES [ALTA_DATA].[BI_Dim_Motherboard](id_motherboard),
	  [pc_alto] DECIMAL,
	  [pc_ancho] DECIMAL,
	  [pc_profundidad] DECIMAL
	);

END