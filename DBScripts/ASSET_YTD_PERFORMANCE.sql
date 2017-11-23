/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[ASSET_YTD_PERFORMANCE]    Script Date: 04-10-2017 17:59:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[ASSET_YTD_PERFORMANCE]  
  
  
  
AS  
  
  
  
select pLANT_ID,ASSET_ID,CURRENT_YEAR,    
((CASE WHEN (WATER_BY)=0 THEN 0 ELSE ((WATER_CY)-(WATER_BY))/(WATER_BY) END) +   
(CASE WHEN (GAS_BY)=0 THEN 0 ELSE ((GAS_CY)-(GAS_BY))/(GAS_BY) END) +  
(CASE WHEN (solidwaste_BY)=0 THEN 0 ELSE ((SOLIDwaste_CY)-(solidwaste_BY))/(solidwaste_BY) END)+  
(CASE WHEN (electricity_BY)=0 THEN 0 ELSE ((ELECTRICity_CY)-(electricity_BY))/(electricity_BY) END))/4 YTD_PERFORMANCE
from 
(
Select pLANT_ID,ASSET_ID,CURRENT_YEAR,  
CASE WHEN SUM(Production_BY)=0 THEN 0 ELSE  SUM(WATER_consumption_BY)/SUM(Production_BY) END as water_BY,
CASE WHEN SUM(Production_BY)=0 THEN 0 ELSE  SUM(GAS_consumption_BY)/SUM(Production_BY) END as GAS_BY,
CASE WHEN SUM(Production_BY)=0 THEN 0 ELSE  SUM(solidwaste_by)/SUM(Production_BY) END as solidwaste_BY,
CASE WHEN SUM(Production_BY)=0 THEN 0 ELSE  SUM(electricity_consumption_BY)/SUM(Production_BY) END as electricity_BY,
CASE WHEN SUM(Production_CY)=0 THEN 0 ELSE  SUM(WATER_consumption_CY)/SUM(Production_CY) END as WATER_CY,
CASE WHEN SUM(Production_CY)=0 THEN 0 ELSE  SUM(GAS_consumption_CY)/SUM(Production_CY) END as GAS_CY,
CASE WHEN SUM(Production_CY)=0 THEN 0 ELSE  SUM(SOLIDwaste_CY)/SUM(Production_CY) END as SOLIDwaste_CY,
CASE WHEN SUM(Production_CY)=0 THEN 0 ELSE  SUM(ELECTRICity_consumption_CY)/SUM(Production_CY) END as ELECTRICity_CY
from  [dbo].[ASSET_BASE_CURRENT_DATA] 
where 
current_year= format(Current_timestamp,'yyyy')  
and current_month< MONTH(Current_timestamp)  
GROUP BY pLANT_ID,ASSET_ID,CURRENT_YEAR   
 ) a

GO

