/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[PLANT_CURRENT_BASE_CONSUMPTION]    Script Date: 04-10-2017 18:02:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- ======================================================================
-- Author:		David J
-- Create date: 25-MAY-2017
-- Description:	Current and base year consumption 
-- ========================================================================

CREATE VIEW [dbo].[PLANT_CURRENT_BASE_CONSUMPTION]
AS
SELECT CYC.plant_ID,CYC.Plant_name,CYC.Asset_ID,CYC.current_month,CYC.current_year,BYC.base_year,CYC.current_yr_consumption,
CYC.current_yr_cost,
BYC.base_yr_consumption,
BYC.base_yr_cost,
CYC.Wages_type,CYC.UOM
FROM
(SELECT
EPD.ID Plant_ID,EPD.Plant_name,EAC.ID as Asset_ID,ETSD.Month_ID current_month,ETSD.Year_ID current_year,
SUM(ETSD.Consumption) current_yr_consumption,
SUM(ETSD.Consumption*WUC.unit_cost )current_yr_cost,ETSD.Wages_type,ETSD.UOM
FROM 
EMMS_Plant_Details EPD INNER JOIN
EMMS_Asset_Classification EAC ON EPD.ID=EAC.Plant_ID
INNER JOIN EMMS_consumption_actual ETSD ON EAC.ID=ETSD.Asset_ID INNER JOIN 
WAGES_UNIT_COST_USD WUC ON ETSD.Year_ID=WUC.Year_ID and ETSD.Wages_type=WUC.Wages_type
INNER JOIN EMMS_Plant_Config EPG ON EAC.ID =EPG.asset_id and ETSD.Year_ID=EPG.Current_year
group by 
EPD.ID ,EPD.Plant_name,EAC.ID,ETSD.Month_ID,ETSD.Year_ID ,ETSD.Wages_type,ETSD.UOM) CYC
INNER JOIN
(SELECT 
EPD.ID Plant_ID,EPD.Plant_name,EAC.ID Asset_ID,ETSD.Month_ID base_month,EPG.Current_year as current_year,
ETSD.Year_ID base_year,
SUM(ETSD.Consumption) base_yr_consumption,
SUM(ETSD.Consumption*WUC.unit_cost ) base_yr_cost,ETSD.Wages_type,ETSD.UOM
FROM 
EMMS_Plant_Details EPD INNER JOIN
EMMS_Asset_Classification EAC ON EPD.ID=EAC.Plant_ID
INNER JOIN EMMS_consumption_actual ETSD ON EAC.ID=ETSD.Asset_ID INNER JOIN 
WAGES_UNIT_COST_USD WUC ON ETSD.Year_ID=WUC.Year_ID and ETSD.Wages_type=WUC.Wages_type
INNER JOIN EMMS_Plant_Config EPG ON EAC.ID =EPG.asset_id and ETSD.Year_ID=EPG.base_year
group by 
EPD.ID ,EPD.Plant_name,EAC.ID,ETSD.Month_ID,EPG.Current_year,ETSD.Year_ID ,ETSD.Wages_type,ETSD.UOM) BYC
ON CYC.current_year=BYC.current_year and CYC.current_month=BYC.base_month 
and CYC.plant_ID=BYC.plant_ID and CYC.Wages_type=BYC.Wages_type and CYC.asset_id=BYC.asset_ID



GO

