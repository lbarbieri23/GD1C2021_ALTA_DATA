USE [GD1C2021]
GO
/****** Object:  Schema [ALTA_DATA]    Script Date: 22/05/2021 1:43:04 ******/
CREATE SCHEMA [ALTA_DATA]
GO
/****** Object:  Schema [gd_esquema]    Script Date: 22/05/2021 1:43:04 ******/
CREATE SCHEMA [gd_esquema]
GO
/****** Object:  Table [ALTA_DATA].[BI_Dim_Accesorio]    Script Date: 22/05/2021 1:43:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ALTA_DATA].[BI_Dim_Accesorio](
	[id_accesorio] [decimal](18, 0) NOT NULL,
	[acc_fabricante] [nvarchar](1) NULL,
	[acc_descripcion] [nvarchar](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_accesorio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [ALTA_DATA].[BI_Dim_Cliente]    Script Date: 22/05/2021 1:43:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [ALTA_DATA].[BI_Dim_Cliente](
	[id_cliente] [int] IDENTITY(1,1) NOT NULL,
	[cli_fecha_nacimiento] [datetime2](7) NULL,
	[cli_sexo] [char](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [ALTA_DATA].[BI_Dim_Compra]    Script Date: 22/05/2021 1:43:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ALTA_DATA].[BI_Dim_Compra](
	[id_compra] [int] IDENTITY(1,1) NOT NULL,
	[id_pc] [nvarchar](1) NULL,
	[fecha] [datetime2](7) NULL,
	[precio] [decimal](18, 0) NULL,
	[id_accesorio] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_compra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [ALTA_DATA].[BI_Dim_Disco_Rigido]    Script Date: 22/05/2021 1:43:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ALTA_DATA].[BI_Dim_Disco_Rigido](
	[id_disco_rigido] [nvarchar](1) NOT NULL,
	[dr_tipo] [nvarchar](1) NULL,
	[dr_capacidad] [nvarchar](1) NULL,
	[dr_fabricante] [nvarchar](1) NULL,
	[dr_velocidad] [nvarchar](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_disco_rigido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [ALTA_DATA].[BI_Dim_Hechos]    Script Date: 22/05/2021 1:43:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ALTA_DATA].[BI_Dim_Hechos](
	[anio] [decimal](18, 0) NULL,
	[mes] [decimal](18, 0) NULL,
	[id_sucursal] [int] NULL,
	[id_pc] [nvarchar](1) NULL,
	[id_cliente] [int] NULL,
	[id_venta] [int] NULL,
	[id_compra] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ALTA_DATA].[BI_Dim_Memoria_Ram]    Script Date: 22/05/2021 1:43:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ALTA_DATA].[BI_Dim_Memoria_Ram](
	[id_memoria_ram] [nvarchar](1) NOT NULL,
	[mr_tipo] [nvarchar](1) NULL,
	[mr_capacidad] [nvarchar](1) NULL,
	[mr_velocidad] [nvarchar](1) NULL,
	[mr_fabricante] [nvarchar](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_memoria_ram] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [ALTA_DATA].[BI_Dim_Microprocesador]    Script Date: 22/05/2021 1:43:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ALTA_DATA].[BI_Dim_Microprocesador](
	[id_microprocesador] [nvarchar](1) NOT NULL,
	[mic_cache] [nvarchar](1) NULL,
	[mic_hilos] [decimal](18, 0) NULL,
	[mic_velocidad] [nvarchar](1) NULL,
	[mic_fabricante] [nvarchar](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_microprocesador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [ALTA_DATA].[BI_Dim_Motherboard]    Script Date: 22/05/2021 1:43:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ALTA_DATA].[BI_Dim_Motherboard](
	[id_motherboard] [int] IDENTITY(1,1) NOT NULL,
	[mb_fabricante] [nvarchar](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_motherboard] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [ALTA_DATA].[BI_Dim_PC]    Script Date: 22/05/2021 1:43:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ALTA_DATA].[BI_Dim_PC](
	[id_pc] [nvarchar](1) NOT NULL,
	[id_disco_rigido] [nvarchar](1) NULL,
	[id_memoria_ram] [nvarchar](1) NULL,
	[id_microprocesador] [nvarchar](1) NULL,
	[id_placa_video] [int] NULL,
	[id_motherboard] [int] NULL,
	[pc_alto] [decimal](18, 0) NULL,
	[pc_ancho] [decimal](18, 0) NULL,
	[pc_profundidad] [decimal](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [ALTA_DATA].[BI_Dim_Placa_Video]    Script Date: 22/05/2021 1:43:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ALTA_DATA].[BI_Dim_Placa_Video](
	[id_placa_video] [int] IDENTITY(1,1) NOT NULL,
	[pv_chipset] [nvarchar](1) NULL,
	[pv_modelo] [nvarchar](1) NULL,
	[pv_velocidad] [nvarchar](1) NULL,
	[pv_capacidad] [nvarchar](1) NULL,
	[pv_fabricante] [nvarchar](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_placa_video] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [ALTA_DATA].[BI_Dim_Sucursal]    Script Date: 22/05/2021 1:43:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ALTA_DATA].[BI_Dim_Sucursal](
	[id_sucursal] [int] IDENTITY(1,1) NOT NULL,
	[ciu_nombre] [int] NULL,
	[suc_telefono] [decimal](18, 0) NULL,
	[suc_mail] [nvarchar](1) NULL,
	[suc_direccion] [nvarchar](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_sucursal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [ALTA_DATA].[BI_Dim_Venta]    Script Date: 22/05/2021 1:43:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ALTA_DATA].[BI_Dim_Venta](
	[id_venta] [int] IDENTITY(1,1) NOT NULL,
	[fecha] [datetime2](7) NULL,
	[precio] [decimal](18, 0) NULL,
	[accesorio] [nvarchar](1) NULL,
	[codigo_pc] [nvarchar](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_venta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [gd_esquema].[Maestra]    Script Date: 22/05/2021 1:43:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [gd_esquema].[Maestra](
	[CIUDAD] [nvarchar](255) NULL,
	[SUCURSAL_DIR] [nvarchar](255) NULL,
	[SUCURSAL_MAIL] [nvarchar](255) NULL,
	[SUCURSAL_TEL] [decimal](18, 0) NULL,
	[COMPRA_FECHA] [datetime2](3) NULL,
	[COMPRA_NUMERO] [decimal](18, 0) NULL,
	[COMPRA_PRECIO] [decimal](18, 2) NULL,
	[COMPRA_CANTIDAD] [decimal](18, 0) NULL,
	[PC_CODIGO] [nvarchar](50) NULL,
	[PC_ALTO] [decimal](18, 2) NULL,
	[PC_ANCHO] [decimal](18, 2) NULL,
	[PC_PROFUNDIDAD] [decimal](18, 2) NULL,
	[DISCO_RIGIDO_CODIGO] [nvarchar](255) NULL,
	[DISCO_RIGIDO_TIPO] [nvarchar](255) NULL,
	[DISCO_RIGIDO_CAPACIDAD] [nvarchar](255) NULL,
	[DISCO_RIGIDO_VELOCIDAD] [nvarchar](255) NULL,
	[DISCO_RIGIDO_FABRICANTE] [nvarchar](255) NULL,
	[MEMORIA_RAM_CODIGO] [nvarchar](255) NULL,
	[MEMORIA_RAM_TIPO] [nvarchar](255) NULL,
	[MEMORIA_RAM_CAPACIDAD] [nvarchar](255) NULL,
	[MEMORIA_RAM_VELOCIDAD] [nvarchar](255) NULL,
	[MEMORIA_RAM_FABRICANTE] [nvarchar](255) NULL,
	[MICROPROCESADOR_CACHE] [nvarchar](50) NULL,
	[MICROPROCESADOR_CANT_HILOS] [decimal](18, 0) NULL,
	[MICROPROCESADOR_CODIGO] [nvarchar](50) NULL,
	[MICROPROCESADOR_VELOCIDAD] [nvarchar](50) NULL,
	[MICROPROCESADOR_FABRICANTE] [nvarchar](255) NULL,
	[PLACA_VIDEO_CHIPSET] [nvarchar](50) NULL,
	[PLACA_VIDEO_MODELO] [nvarchar](50) NULL,
	[PLACA_VIDEO_VELOCIDAD] [nvarchar](50) NULL,
	[PLACA_VIDEO_CAPACIDAD] [nvarchar](255) NULL,
	[PLACA_VIDEO_FABRICANTE] [nvarchar](255) NULL,
	[CLIENTE_APELLIDO] [nvarchar](255) NULL,
	[CLIENTE_NOMBRE] [nvarchar](255) NULL,
	[CLIENTE_DIRECCION] [nvarchar](255) NULL,
	[CLIENTE_DNI] [decimal](18, 0) NULL,
	[CLIENTE_FECHA_NACIMIENTO] [datetime2](3) NULL,
	[CLIENTE_MAIL] [nvarchar](255) NULL,
	[CLIENTE_TELEFONO] [int] NULL,
	[FACTURA_FECHA] [datetime2](3) NULL,
	[FACTURA_NUMERO] [decimal](18, 0) NULL,
	[ACCESORIO_CODIGO] [decimal](18, 0) NULL,
	[AC_DESCRIPCION] [nvarchar](255) NULL
) ON [PRIMARY]

GO
ALTER TABLE [ALTA_DATA].[BI_Dim_PC]  WITH CHECK ADD FOREIGN KEY([id_disco_rigido])
REFERENCES [ALTA_DATA].[BI_Dim_Disco_Rigido] ([id_disco_rigido])
GO
ALTER TABLE [ALTA_DATA].[BI_Dim_PC]  WITH CHECK ADD FOREIGN KEY([id_memoria_ram])
REFERENCES [ALTA_DATA].[BI_Dim_Memoria_Ram] ([id_memoria_ram])
GO
ALTER TABLE [ALTA_DATA].[BI_Dim_PC]  WITH CHECK ADD FOREIGN KEY([id_microprocesador])
REFERENCES [ALTA_DATA].[BI_Dim_Microprocesador] ([id_microprocesador])
GO
ALTER TABLE [ALTA_DATA].[BI_Dim_PC]  WITH CHECK ADD FOREIGN KEY([id_motherboard])
REFERENCES [ALTA_DATA].[BI_Dim_Motherboard] ([id_motherboard])
GO
ALTER TABLE [ALTA_DATA].[BI_Dim_PC]  WITH CHECK ADD FOREIGN KEY([id_placa_video])
REFERENCES [ALTA_DATA].[BI_Dim_Placa_Video] ([id_placa_video])
GO
