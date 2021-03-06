USE [master]
GO
/****** Object:  Database [ProductInformatin]    Script Date: 5/15/2015 7:11:28 PM ******/
CREATE DATABASE [ProductInformatin]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ProductInformatin', FILENAME = N'i:\SetupFiles\SQLServer\MSSQL11.SQLEXPRESS\MSSQL\DATA\ProductInformatin.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ProductInformatin_log', FILENAME = N'i:\SetupFiles\SQLServer\MSSQL11.SQLEXPRESS\MSSQL\DATA\ProductInformatin_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ProductInformatin] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ProductInformatin].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ProductInformatin] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ProductInformatin] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ProductInformatin] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ProductInformatin] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ProductInformatin] SET ARITHABORT OFF 
GO
ALTER DATABASE [ProductInformatin] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ProductInformatin] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ProductInformatin] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ProductInformatin] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ProductInformatin] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ProductInformatin] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ProductInformatin] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ProductInformatin] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ProductInformatin] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ProductInformatin] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ProductInformatin] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ProductInformatin] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ProductInformatin] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ProductInformatin] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ProductInformatin] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ProductInformatin] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ProductInformatin] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ProductInformatin] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ProductInformatin] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ProductInformatin] SET  MULTI_USER 
GO
ALTER DATABASE [ProductInformatin] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ProductInformatin] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ProductInformatin] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ProductInformatin] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [ProductInformatin]
GO
/****** Object:  StoredProcedure [dbo].[spGetAllProductAndTotalQuantity]    Script Date: 5/15/2015 7:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spGetAllProductAndTotalQuantity]

@TotalQuantity int output
as
begin
     select * from tblProduct
	 select @TotalQuantity= SUM(Quantity) from tblProduct
end

GO
/****** Object:  Table [dbo].[tblProduct]    Script Date: 5/15/2015 7:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblProduct](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductCode] [varchar](50) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_tblProduct] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tblProduct] ON 

INSERT [dbo].[tblProduct] ([ID], [ProductCode], [Name], [Quantity]) VALUES (1, N'SEIP100FT', N'Water 2 Litre', 22)
INSERT [dbo].[tblProduct] ([ID], [ProductCode], [Name], [Quantity]) VALUES (2, N'SEIP101GT', N'Bombay Chips', 30)
INSERT [dbo].[tblProduct] ([ID], [ProductCode], [Name], [Quantity]) VALUES (3, N'SEIP202HT', N'Pepsi 2 Litre', 200)
INSERT [dbo].[tblProduct] ([ID], [ProductCode], [Name], [Quantity]) VALUES (4, N'SEIP303HT', N'Fan', 10)
SET IDENTITY_INSERT [dbo].[tblProduct] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_tblProduct]    Script Date: 5/15/2015 7:11:28 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblProduct] ON [dbo].[tblProduct]
(
	[ProductCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [ProductInformatin] SET  READ_WRITE 
GO
