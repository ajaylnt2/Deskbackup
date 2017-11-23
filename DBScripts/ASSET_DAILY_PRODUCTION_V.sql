/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[ASSET_DAILY_PRODUCTION_V]    Script Date: 04-10-2017 17:57:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[ASSET_DAILY_PRODUCTION_V]  
AS  
select 
ISNULL(epd.date_time,eps.date_time) date_time,
DATEPART(MONTH,ISNULL(epd.date_time,eps.date_time)) as MonthID,
Substring(DATENAME(MONTH,ISNULL(epd.date_time,eps.date_time)),1,3) as Month,
DATENAME(YEAR,ISNULL(epd.date_time,eps.date_time))  as Year,
ISNULL(epd.Asset_id,eps.Asset_id) Asset_id,
ISNULL(epd.Value,0) as Production ,
ISNULL(eps.Value,0) as solidwaste 
from emms_production_daily epd
FULL OUTER JOIN 
emms_solidwaste_daily eps
ON epd.Date_time=eps.Date_time and epd.asset_id=eps.Asset_id
GO

