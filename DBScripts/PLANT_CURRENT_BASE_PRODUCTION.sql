/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[PLANT_CURRENT_BASE_PRODUCTION]    Script Date: 04-10-2017 18:03:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- ======================================================================
-- Author:		David J
-- Create date: 25-MAY-2017
-- Description:	Current and base year production 
-- ========================================================================

CREATE VIEW [dbo].[PLANT_CURRENT_BASE_PRODUCTION]
AS
SELECT CYP.plant_ID,CYP.ASSET_ID,CYP.current_month,CYP.current_year,BYC.base_year,
CYP.current_yr_production,
CYP.current_yr_solidwaste,
BYC.base_yr_production,
BYC.base_yr_solidwaste,CYP.UOM,
ROUND((CASE WHEN BYC.base_yr_production =0 THEN 0 ELSE BYC.base_yr_solidwaste/BYC.base_yr_production END),2) as solidwaste_prod_BY,
ROUND((CASE WHEN CYP.current_yr_production =0 THEN 0 ELSE CYP.current_yr_solidwaste/CYP.current_yr_production END),2)  as solidwaste_prod_CY,
(CASE WHEN ROUND((CASE WHEN BYC.base_yr_production =0 THEN 0 ELSE BYC.base_yr_solidwaste/BYC.base_yr_production END),2) =0 THEN 0 ELSE
ROUND(((CASE WHEN BYC.base_yr_production =0 THEN 0 ELSE BYC.base_yr_solidwaste/BYC.base_yr_production END)-
(CASE WHEN CYP.current_yr_production =0 THEN 0 ELSE CYP.current_yr_solidwaste/CYP.current_yr_production END))/
(CASE WHEN BYC.base_yr_production =0 THEN 0 ELSE BYC.base_yr_solidwaste/BYC.base_yr_production END),2) END ) as Solidwaste_variance,
(CASE WHEN BYC.base_yr_production=0 THEN 0 ELSE 
ROUND((BYC.base_yr_production-CYP.current_yr_production)/BYC.base_yr_production,2) END ) as Production_variance
FROM
(SELECT
EAC.plant_ID,EAC.ID AS ASSET_ID,EPA.Month_ID current_month,
EPA.Year_ID current_year,EPA.Value current_yr_production,
EPA.solidwaste current_yr_solidwaste,EPA.UOM
FROM EMMS_Production_ACTUAL EPA INNER JOIN EMMS_ASSET_CLASSIFICATION EAC ON
EPA.ASSET_ID =EAC.ID INNER JOIN EMMS_Plant_Config EPG ON 
 EAC.ID =EPG.asset_id and EPA.Year_ID=EPG.Current_year) CYP
INNER JOIN
(SELECT
EAC.plant_ID,EAC.ID AS ASSET_ID,EPA.Month_ID base_month,EPG.Current_year as current_year,
EPA.Year_ID base_year,EPA.Value base_yr_production,
EPA.solidwaste base_yr_solidwaste,EPA.UOM
FROM EMMS_Production_ACTUAL EPA INNER JOIN EMMS_ASSET_CLASSIFICATION EAC ON
EPA.ASSET_ID =EAC.ID INNER JOIN EMMS_Plant_Config EPG ON 
 EAC.ID =EPG.asset_id and EPA.Year_ID=EPG.base_year) BYC
ON CYP.current_year=BYC.current_year and CYP.current_month=BYC.base_month and 
CYP.plant_ID=BYC.plant_ID AND CYP.ASSET_ID=BYC.ASSET_ID






GO

