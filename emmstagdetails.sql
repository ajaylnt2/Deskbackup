/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2016 (13.0.4001)
    Source Database Engine Edition : Microsoft SQL Server Express Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2016
    Target Database Engine Edition : Microsoft SQL Server Express Edition
    Target Database Engine Type : Standalone SQL Server
*/

USE [TempWages]
GO

/****** Object:  Table [dbo].[EMMS_Tag_Details]    Script Date: 19-09-2017 17:13:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EMMS_Tag_Details](
	[ID] [int] IDENTITY(1,10001) NOT NULL,
	[URL] [nvarchar](100) NULL,
	[Asset_ID] [int] NOT NULL,
	[Historian_Tag] [nvarchar](50) NOT NULL,
	[UOM] [int] NOT NULL,
	[Wages_type] [int] NOT NULL,
	[isExponential] [nvarchar](1) NULL,
	[isEnabled] [nvarchar](1) NULL,
	[target] [float] NULL,
 CONSTRAINT [PK_EMMS_Tag_Details] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

