/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[ASSET_DAILY_SOLIDWASTE_V]    Script Date: 04-10-2017 17:57:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[ASSET_DAILY_SOLIDWASTE_V]
AS
select date_time,Asset_id,Value as solidwaste from emms_solidwaste_daily epd
GO

