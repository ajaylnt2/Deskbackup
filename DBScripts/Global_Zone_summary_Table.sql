/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[Global_Zone_summary_Table]    Script Date: 04-10-2017 18:02:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- ======================================================================
-- Author:		David J
-- Create date: 25-MAY-2017
-- Description:	Global_Zone_summary View 
-- ========================================================================

CREATE VIEW [dbo].[Global_Zone_summary_Table] AS
SELECT A.Month_ID ,A.Year_ID,A.Zone,A.Plant_ID,A.plant_name, A.ASSET_ID,
SUM(B.production_MT) production_MT,
SUM(B.solidwaste_MT) solidwaste_MT,
SUM(B.base_production_MT) currentproduction_MT,
SUM(B.base_solidwaste_MT) basesolidwaste_MT,
SUM(A.Utility_cost) as cost,
SUM(A.base_Utility_cost) as basecost
FROM
(SELECT EPD.ID Plant_ID,ECA.ASSET_ID,ECA.current_month Month_ID,ECA.current_year Year_ID,
EMZ.Name as Zone,EPD.Plant_name,
SUM(ECA.current_yr_cost) as Utility_cost,
SUM(ECA.base_yr_cost) as base_Utility_cost
FROM
EMMS_Plant_Details EPD INNER JOIN EMMS_Master_Zone EMZ ON EPD.Zone_id=EMZ.ID INNER JOIN
PLANT_CURRENT_BASE_CONSUMPTION ECA ON EPD.ID=ECA.plant_ID 
group by ECA.current_month,ECA.current_year,
EMZ.Name,EPD.Plant_name,EPD.ID,ECA.ASSET_ID) A 
INNER JOIN
(SELECT EPA.Plant_ID, EPA.ASSET_ID, EPA.current_month Month_ID, EPA.current_year Year_ID,
SUM(EPA.current_yr_production) as production_MT,SUM(EPA.current_yr_solidwaste) as solidwaste_MT,
SUM(EPA.base_yr_production) as base_production_MT,SUM(EPA.base_yr_solidwaste) as base_solidwaste_MT FROM
PLANT_CURRENT_BASE_PRODUCTION EPA 
group by  EPA.Plant_ID,EPA.ASSET_ID,EPA.current_month, EPA.current_year) B 
ON A.Plant_ID=B.Plant_ID and A.ASSET_ID=B.ASSET_ID
and A.Month_ID=B.Month_ID and A.Year_ID=B.Year_ID
Group by Zone,A.Plant_ID,A.Plant_name,A.ASSET_ID,A.Month_ID ,A.Year_ID

GO

