/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[ASSET_ROLLING_MONTH]    Script Date: 04-10-2017 17:58:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[ASSET_ROLLING_MONTH]   
  
AS   
  
select   
  
PLANT_ID,  
  
ASSET_ID,  
  
CURRENT_MONTH,  
  
CURRENT_YEAR,  
  
CAST(CAST(CURRENT_YEAR AS varchar(4))+'-'+CAST(CURRENT_MONTH as varchar(2))+'-'+CAST(1 as varchar(1)) AS DATETIME) as DATEID,   
  
FORMAT(CAST(CAST(CURRENT_YEAR AS varchar(4))+'-'+CAST(CURRENT_MONTH as varchar(2))+'-'+CAST(1 as varchar(1)) AS DATETIME),'MMM-yyyy') as MonthName,    
  
  
  
(((CASE WHEN SUM(WATER_BY_PROD_BY)=0 THEN 0 ELSE (SUM(WATER_BY_PROD_CY)-SUM(WATER_BY_PROD_BY))/SUM(WATER_BY_PROD_BY) END) +   
  
(CASE WHEN SUM(GAS_BY_PROD_BY)=0 THEN 0 ELSE (SUM(GAS_BY_PROD_CY)-SUM(GAS_BY_PROD_BY))/SUM(GAS_BY_PROD_BY) END)+   
  
(CASE WHEN SUM(ELECTRIC_BY_PROD_BY)=0 THEN 0 ELSE (SUM(ELECTRIC_BY_PROD_CY)-SUM(ELECTRIC_BY_PROD_BY))/SUM(ELECTRIC_BY_PROD_BY) END)+   
  
(CASE WHEN SUM(SOLID_BY_PROD_BY)=0 THEN 0 ELSE (SUM(SOLID_BY_PROD_CY)-SUM(SOLID_BY_PROD_BY))/SUM(SOLID_BY_PROD_BY) END))/4)  Rolling_Month   
  
from ASSET_BASE_CURRENT_DATA   
  
where    
  
CAST(CAST(current_year as varchar(4))+'-'+CAST(CURRENT_MONTH as varchar(2))+'-'+CAST(1 as varchar(2)) AS DATETIME) >= DATEADD(Month,-13,Current_timestamp)   
  
and CAST(CAST(current_year as varchar(4))+'-'+CAST(CURRENT_MONTH as varchar(2))+'-'+CAST(1 as varchar(2)) AS DATETIME) <= DATEADD(Month,-1,Current_timestamp)  
  
GROUP BY pLANT_ID,ASSET_ID,CURRENT_MONTH,CURRENT_YEAR
GO

