/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[ASSET_CONSUMPTION_PRODUCTION]    Script Date: 04-10-2017 17:57:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[ASSET_CONSUMPTION_PRODUCTION] 
AS
SELECT CYC.plant_ID,CYC.Plant_name,CYC.Asset_ID,CYC.current_month,CYC.current_year,BYC.base_year,CYC.current_yr_consumption,
CYC.current_yr_cost,
BYC.base_yr_consumption,
BYC.base_yr_cost,
CYC.Wages_type,CYC.UOM,
current_yr_solidwaste,
current_yr_production,
base_yr_solidwaste,
base_yr_production,
(CASE WHEN base_yr_production =0 THEN 0 ELSE BYC.base_yr_consumption/base_yr_production END) as Specific_consumption_BY,
(CASE WHEN current_yr_production =0 THEN 0 ELSE CYC.Current_yr_consumption/current_yr_production END) as Specific_consumption_CY,
(CASE WHEN 
(CASE WHEN base_yr_production =0 THEN 0 ELSE BYC.base_yr_consumption/base_yr_production END)=0 THEN 0 ELSE 
((CASE WHEN base_yr_production =0 THEN 0 ELSE BYC.base_yr_consumption/base_yr_production END)-
(CASE WHEN current_yr_production =0 THEN 0 ELSE CYC.Current_yr_consumption/current_yr_production END))/
(CASE WHEN base_yr_production =0 THEN 0 ELSE BYC.base_yr_consumption/base_yr_production END) END ) as consumption_variance
FROM
(SELECT
EPD.ID Plant_ID,EPD.Plant_name,EAC.ID as Asset_ID,ETSD.Month_ID current_month,ETSD.Year_ID current_year,
SUM(EPA.value) as current_yr_production,
SUM(EPA.solidwaste) as current_yr_solidwaste,
SUM(ETSD.Consumption) current_yr_consumption,
SUM(ETSD.Consumption*WUC.unit_cost )current_yr_cost,ETSD.Wages_type,ETSD.UOM
FROM 
EMMS_Plant_Details EPD INNER JOIN
EMMS_Asset_Classification EAC ON EPD.ID=EAC.Plant_ID
INNER JOIN EMMS_consumption_actual ETSD ON EAC.ID=ETSD.Asset_ID INNER JOIN EMMS_production_actual EPA
ON ETSD.Asset_ID=EPA.Asset_ID and ETSD.Year_id=EPA.Year_ID and ETSD.Month_ID=EPA.Month_ID 
INNER JOIN EMMS_Plant_Config EPG ON EAC.ID =EPG.asset_id and ETSD.Year_ID=EPG.Current_year
LEFT JOIN WAGES_UNIT_COST_USD WUC ON ETSD.Year_ID=WUC.Year_ID and ETSD.Wages_type=WUC.Wages_type and ETSD.asset_ID=WUC.asset_ID
group by 
EPD.ID ,EPD.Plant_name,EAC.ID,ETSD.Month_ID,ETSD.Year_ID ,ETSD.Wages_type,ETSD.UOM) CYC
INNER JOIN
(SELECT 
EPD.ID Plant_ID,EPD.Plant_name,EAC.ID Asset_ID,ETSD.Month_ID base_month,EPG.Current_year as current_year,
ETSD.Year_ID base_year,
SUM(EPA.value) as base_yr_production,
SUM(EPA.solidwaste) as base_yr_solidwaste,
SUM(ETSD.Consumption) base_yr_consumption,
SUM(ETSD.Consumption*WUC.unit_cost ) base_yr_cost,ETSD.Wages_type,ETSD.UOM
FROM 
EMMS_Plant_Details EPD INNER JOIN
EMMS_Asset_Classification EAC ON EPD.ID=EAC.Plant_ID
INNER JOIN EMMS_consumption_actual ETSD ON EAC.ID=ETSD.Asset_ID INNER JOIN EMMS_production_actual EPA
ON ETSD.Asset_ID=EPA.Asset_ID and ETSD.Year_id=EPA.Year_ID and ETSD.Month_ID=EPA.Month_ID 
INNER JOIN EMMS_Plant_Config EPG ON EAC.ID =EPG.asset_id and ETSD.Year_ID=EPG.base_year
LEFT JOIN WAGES_UNIT_COST_USD WUC ON ETSD.Year_ID=WUC.Year_ID and ETSD.Wages_type=WUC.Wages_type and ETSD.asset_ID=WUC.asset_ID
group by 
EPD.ID ,EPD.Plant_name,EAC.ID,ETSD.Month_ID,EPG.Current_year,ETSD.Year_ID ,ETSD.Wages_type,ETSD.UOM) BYC
ON CYC.current_year=BYC.current_year and CYC.current_month=BYC.base_month 
and CYC.plant_ID=BYC.plant_ID and CYC.Wages_type=BYC.Wages_type and CYC.asset_id=BYC.asset_ID





GO

