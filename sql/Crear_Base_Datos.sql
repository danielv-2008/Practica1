-- 1. Crear Base de Datos
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'TallerTextilDB')
BEGIN
    CREATE DATABASE TallerTextilDB;
END
GO

USE TallerTextilDB;
GO

-- 2. Tabla de Telas (HU01, HU05)
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Telas]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Telas](
        [ID] INT PRIMARY KEY IDENTITY(1,1),
        [Nombre] NVARCHAR(100) NOT NULL,
        [Color] NVARCHAR(50),
        [Metros_Stock] DECIMAL(10,2) DEFAULT 0,
        [Stock_Minimo] DECIMAL(10,2) DEFAULT 5.0
    )
END
GO

-- 3. Tabla de Costureras (HU03)
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Costureras]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Costureras](
        [ID] INT PRIMARY KEY IDENTITY(1,1),
        [Nombre] NVARCHAR(100) NOT NULL,
        [Especialidad] NVARCHAR(100)
    )
END
GO

-- 4. Tabla de Pedidos (HU02)
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pedidos]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Pedidos](
        [ID] INT PRIMARY KEY IDENTITY(1,1),
        [Cliente] NVARCHAR(100) NOT NULL,
        [Fecha_Pedido] DATETIME DEFAULT GETDATE(),
        [Estado] NVARCHAR(20) DEFAULT 'Pendiente'
    )
END
GO

-- 5. Tabla de Produccion (Relación Pedidos-Costureras)
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Produccion]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Produccion](
        [ID] INT PRIMARY KEY IDENTITY(1,1),
        [Pedido_ID] INT FOREIGN KEY REFERENCES Pedidos(ID),
        [Costurera_ID] INT FOREIGN KEY REFERENCES Costureras(ID),
        [Fecha_Terminado] DATETIME
    )
END
GO
