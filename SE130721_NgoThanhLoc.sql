USE [master]
GO
/****** Object:  Database [SE1403]    Script Date: 3/24/2020 7:11:53 PM ******/
CREATE DATABASE [SE1403]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SE1403', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\SE1403.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SE1403_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\SE1403_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SE1403] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SE1403].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SE1403] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SE1403] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SE1403] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SE1403] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SE1403] SET ARITHABORT OFF 
GO
ALTER DATABASE [SE1403] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SE1403] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SE1403] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SE1403] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SE1403] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SE1403] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SE1403] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SE1403] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SE1403] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SE1403] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SE1403] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SE1403] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SE1403] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SE1403] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SE1403] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SE1403] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SE1403] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SE1403] SET RECOVERY FULL 
GO
ALTER DATABASE [SE1403] SET  MULTI_USER 
GO
ALTER DATABASE [SE1403] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SE1403] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SE1403] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SE1403] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [SE1403] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'SE1403', N'ON'
GO
USE [SE1403]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 3/24/2020 7:11:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[productName] [nvarchar](50) NOT NULL,
	[Quantity] [int] NULL,
	[CartID] [int] NOT NULL,
 CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED 
(
	[productName] ASC,
	[CartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 3/24/2020 7:11:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[Cartid] [int] NOT NULL,
	[username] [varchar](20) NULL,
 CONSTRAINT [PK_CheckOut_1] PRIMARY KEY CLUSTERED 
(
	[Cartid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product]    Script Date: 3/24/2020 7:11:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[name] [nvarchar](50) NOT NULL,
	[quantity] [int] NULL,
 CONSTRAINT [PK_Product_1] PRIMARY KEY CLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Registration]    Script Date: 3/24/2020 7:11:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Registration](
	[username] [varchar](20) NOT NULL,
	[password] [varchar](30) NULL,
	[lastname] [nvarchar](250) NULL,
	[isAdmin] [bit] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Cart] ([productName], [Quantity], [CartID]) VALUES (N'EJB2', 3, 1)
INSERT [dbo].[Cart] ([productName], [Quantity], [CartID]) VALUES (N'EJB2', 2, 4)
INSERT [dbo].[Cart] ([productName], [Quantity], [CartID]) VALUES (N'EJB2', 3, 6)
INSERT [dbo].[Cart] ([productName], [Quantity], [CartID]) VALUES (N'EJB3', 2, 3)
INSERT [dbo].[Cart] ([productName], [Quantity], [CartID]) VALUES (N'JBoss', 1, 2)
INSERT [dbo].[Cart] ([productName], [Quantity], [CartID]) VALUES (N'Servlet', 1, 7)
INSERT [dbo].[Cart] ([productName], [Quantity], [CartID]) VALUES (N'Tomcat', 1, 5)
INSERT [dbo].[OrderDetail] ([Cartid], [username]) VALUES (1, N'admin')
INSERT [dbo].[OrderDetail] ([Cartid], [username]) VALUES (2, N'admin')
INSERT [dbo].[OrderDetail] ([Cartid], [username]) VALUES (3, N'admin')
INSERT [dbo].[OrderDetail] ([Cartid], [username]) VALUES (4, N'admin123')
INSERT [dbo].[OrderDetail] ([Cartid], [username]) VALUES (5, N'admin')
INSERT [dbo].[OrderDetail] ([Cartid], [username]) VALUES (6, N'admin')
INSERT [dbo].[OrderDetail] ([Cartid], [username]) VALUES (7, N'admin')
INSERT [dbo].[Product] ([name], [quantity]) VALUES (N'EJB2', 10)
INSERT [dbo].[Product] ([name], [quantity]) VALUES (N'EJB3', 20)
INSERT [dbo].[Product] ([name], [quantity]) VALUES (N'J2EE', 30)
INSERT [dbo].[Product] ([name], [quantity]) VALUES (N'JavaEE', 10)
INSERT [dbo].[Product] ([name], [quantity]) VALUES (N'JBoss', 20)
INSERT [dbo].[Product] ([name], [quantity]) VALUES (N'JDBC', 30)
INSERT [dbo].[Product] ([name], [quantity]) VALUES (N'Orthers', 10)
INSERT [dbo].[Product] ([name], [quantity]) VALUES (N'Servlet', 52)
INSERT [dbo].[Product] ([name], [quantity]) VALUES (N'Tomcat', 20)
INSERT [dbo].[Registration] ([username], [password], [lastname], [isAdmin]) VALUES (N'admin', N'1', N'Thành Lộc', 1)
INSERT [dbo].[Registration] ([username], [password], [lastname], [isAdmin]) VALUES (N'admin123123', N'123456', N'ngo thanh loc', 0)
INSERT [dbo].[Registration] ([username], [password], [lastname], [isAdmin]) VALUES (N'thanhloc123', N'123', N'thanh loc', 1)
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_OrderDetail] FOREIGN KEY([CartID])
REFERENCES [dbo].[OrderDetail] ([Cartid])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_OrderDetail]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Product] FOREIGN KEY([productName])
REFERENCES [dbo].[Product] ([name])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Product]
GO
USE [master]
GO
ALTER DATABASE [SE1403] SET  READ_WRITE 
GO
