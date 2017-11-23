/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[ASSET_CURRENT_BASE_PROD]    Script Date: 04-10-2017 17:57:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- ======================================================================
-- Author:		David J
-- Create date: 19-June-2017
-- Description: ASSET_ACTUAL_PRODUCTION
-- ========================================================================
CREATE VIEW [dbo].[ASSET_CURRENT_BASE_PROD]
AS
SELECT
	CYP.Plant_ID,CYP.Asset_ID,BYP.base_month,BYP.base_year,CYP.current_month,CYP.current_year,
	production_BY,solidwaste_BY,solidwase_div_prod_BY,
	production_CY,solidwaste_CY,solidwase_div_prod_CY,
	CASE WHEN solidwase_div_prod_BY=0 THEN 0 ELSE (solidwase_div_prod_CY-solidwase_div_prod_BY)/solidwase_div_prod_BY END Solidwaste_percentage_change
FROM
(SELECT
	EAC.Plant_ID,EAC.ID as Asset_ID,EPA.Month_ID base_month,EPA.Year_ID base_year,
	(EPA.value) as production_BY,
	EPA.solidwaste as solidwaste_BY,
	CASE WHEN EPA.value=0 THEN 0 ELSE EPA.solidwaste/EPA.value END solidwase_div_prod_BY
FROM 
	EMMS_Asset_Classification EAC 
	INNER JOIN EMMS_production_actual EPA
	ON EAC.ID=EPA.Asset_ID INNER JOIN 
	EMMS_Plant_base_year EABY ON EAC.Plant_ID =EABY.Plant_id and EPA.Year_ID=EABY.base_year) BYP
	RIGHT JOIN
(SELECT
	EAC.Plant_ID,EAC.ID as Asset_ID,EPA.Month_ID current_month,EPA.Year_ID current_year,
	(EPA.value) as production_CY,
	EPA.solidwaste as solidwaste_CY,
	CASE WHEN EPA.value=0 THEN 0 ELSE EPA.solidwaste/EPA.value END solidwase_div_prod_CY
FROM 
	EMMS_Asset_Classification EAC 
	INNER JOIN EMMS_production_actual EPA
	ON EAC.ID=EPA.Asset_ID INNER JOIN 
	EMMS_Plant_base_year EABY ON EAC.Plant_ID =EABY.Plant_id and EPA.Year_ID<>EABY.base_year) CYP
	ON BYP.Asset_ID=CYP.asset_ID and BYP.Base_month=CYP.current_month and BYP.Plant_ID=CYP.plant_ID

	


GO

