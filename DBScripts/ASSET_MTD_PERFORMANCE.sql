/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[ASSET_MTD_PERFORMANCE]    Script Date: 04-10-2017 17:58:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[ASSET_MTD_PERFORMANCE]
AS
select pLANT_ID,ASSET_ID,CURRENT_MONTH,CURRENT_YEAR,
((CASE WHEN SUM(WATER_BY_PROD_BY)=0 THEN 0 ELSE (SUM(WATER_BY_PROD_CY)-SUM(WATER_BY_PROD_BY))/SUM(WATER_BY_PROD_BY) END) +
(CASE WHEN SUM(GAS_BY_PROD_BY)=0 THEN 0 ELSE (SUM(GAS_BY_PROD_CY)-SUM(GAS_BY_PROD_BY))/SUM(GAS_BY_PROD_BY) END)+
(CASE WHEN SUM(ELECTRIC_BY_PROD_BY)=0 THEN 0 ELSE (SUM(ELECTRIC_BY_PROD_CY)-SUM(ELECTRIC_BY_PROD_BY))/SUM(ELECTRIC_BY_PROD_BY) END)+
(CASE WHEN SUM(SOLID_BY_PROD_BY)=0 THEN 0 ELSE (SUM(SOLID_BY_PROD_CY)-SUM(SOLID_BY_PROD_BY))/SUM(SOLID_BY_PROD_BY) END))/
((SUM(PRODUCTION_CY)-SUM(PRODUCTION_BY))/SUM(PRODUCTION_BY)) AS MTD_PERFORMANCE
from [dbo].[ASSET_BASE_CURRENT_DATA]
where current_year= format(Current_timestamp,'yyyy')
AND CURRENT_MONTH=CAST(format(Current_timestamp,'MM') AS INT)
GROUP BY pLANT_ID,ASSET_ID,CURRENT_MONTH,CURRENT_YEAR

GO

