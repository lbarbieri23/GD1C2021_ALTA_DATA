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

-- Clientes

	CREATE TABLE [ALTA_DATA].[BI_Cliente] (
	[id_cliente] INTEGER IDENTITY(1,1) PRIMARY KEY,
    [cli_fecha_nacimiento] DATETIME2,
    [cli_sexo] CHAR NULL
	);

-- Sucursales

	CREATE TABLE [ALTA_DATA].[BI_Sucursal] (
      [id_sucursal] INTEGER IDENTITY(1,1) PRIMARY KEY,
      [ciu_nombre] INTEGER,
      [suc_telefono] DECIMAL,
      [suc_mail] NVARCHAR (255),
      [suc_direccion] NVARCHAR (255)
	);

-- Compras

	CREATE TABLE [ALTA_DATA].[BI_Compra] (
	 [id_compra] INTEGER IDENTITY(1,1) PRIMARY KEY,
     [id_pc] NVARCHAR(50),
     [fecha] DATETIME2,
     [precio] DECIMAL,
     [id_accesorio] INTEGER
     );

-- Ventas

	CREATE TABLE [ALTA_DATA].[BI_Venta] (
	[id_venta] INTEGER IDENTITY(1,1) PRIMARY KEY,
	[fecha] DATETIME2,
	[precio] DECIMAL,
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

END