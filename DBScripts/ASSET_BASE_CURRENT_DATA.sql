/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[ASSET_BASE_CURRENT_DATA]    Script Date: 04-10-2017 17:44:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- ======================================================================
-- Author:		David J
-- Create date: 19-June-2017
-- Description:	ASSET_BASE_CURRENT_DATA
-- ========================================================================
CREATE VIEW [dbo].[ASSET_BASE_CURRENT_DATA]
AS
Select 
Plant_ID,Asset_ID,
base_month,
base_monthName , 
base_year,
current_month,
current_monthName ,
current_year,
ISNULL(production_CY,0) production_CY,
ISNULL(solidwaste_CY,0) solidwaste_CY,
ISNULL(Water_consumption_CY,0) Water_consumption_CY,
ISNULL(Air_consumption_CY,0) Air_consumption_CY,
ISNULL(Gas_consumption_CY,0) Gas_consumption_CY,
ISNULL(Electricity_consumption_CY,0) Electricity_consumption_CY,
ISNULL(Steam_consumption_CY,0) Steam_consumption_CY,
ISNULL(Water_cost_CY,0) Water_cost_CY,
ISNULL(Air_cost_CY,0) Air_cost_CY,
ISNULL(Gas_cost_CY,0) Gas_cost_CY,
ISNULL(Electricity_cost_CY,0) Electricity_cost_CY,
ISNULL(Steam_cost_CY,0) Steam_cost_CY,
ISNULL(production_BY,0) production_BY,
ISNULL(solidwaste_BY,0) solidwaste_BY,
ISNULL(Water_consumption_BY,0) Water_consumption_BY,
ISNULL(Air_consumption_BY,0) Air_consumption_BY,
ISNULL(Gas_consumption_BY,0) Gas_consumption_BY,
ISNULL(Electricity_consumption_BY,0) Electricity_consumption_BY,
ISNULL(Steam_consumption_BY,0) Steam_consumption_BY,
ISNULL(Water_cost_BY,0) Water_cost_BY,
ISNULL(Air_cost_BY,0) Air_cost_BY,
ISNULL(Gas_cost_BY,0) Gas_cost_BY,
ISNULL(Electricity_cost_BY,0) Electricity_cost_BY,
ISNULL(Steam_cost_BY,0) Steam_cost_BY,
-- Current Year Consumption and cost
ISNULL((CASE WHEN production_CY=0 THEN 0 ELSE (solidwaste_CY/production_CY) END),0) solid_by_prod_CY,
ISNULL((CASE WHEN production_CY=0 THEN 0 ELSE (Water_consumption_CY/production_CY) END),0) water_by_prod_CY,
ISNULL((CASE WHEN production_CY=0 THEN 0 ELSE (Air_consumption_CY/production_CY) END),0) air_by_prod_CY,
ISNULL((CASE WHEN production_CY=0 THEN 0 ELSE (Gas_consumption_CY/production_CY) END),0) gas_by_prod_CY,
ISNULL((CASE WHEN production_CY=0 THEN 0 ELSE (Electricity_consumption_CY/production_CY) END),0) electric_by_prod_CY,
ISNULL((CASE WHEN production_CY=0 THEN 0 ELSE (Steam_consumption_CY/production_CY) END),0) steam_by_prod_CY,
ISNULL((CASE WHEN production_CY=0 THEN 0 ELSE (Water_cost_CY/production_CY) END),0) watercost_by_prod_CY,
ISNULL((CASE WHEN production_CY=0 THEN 0 ELSE (Air_cost_CY/production_CY) END),0) aircost_by_prod_CY,
ISNULL((CASE WHEN production_CY=0 THEN 0 ELSE (Gas_cost_CY/production_CY) END),0) gascost_by_prod_CY,
ISNULL((CASE WHEN production_CY=0 THEN 0 ELSE (Electricity_cost_CY/production_CY) END),0) electriccost_by_prod_CY,
ISNULL((CASE WHEN production_CY=0 THEN 0 ELSE (Steam_cost_CY/production_CY) END),0) steamcost_by_prod_CY,

-- Base Year Consumption and cost
ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (solidwaste_BY/production_BY) END),0) solid_by_prod_BY,
ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Water_consumption_BY/production_BY) END),0) water_by_prod_BY,
ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Air_consumption_BY/production_BY)END),0)  air_by_prod_BY,
ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Gas_consumption_BY/production_BY) END),0) gas_by_prod_BY,
ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Electricity_consumption_BY/production_BY) END),0) electric_by_prod_BY,
ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Steam_consumption_BY/production_BY) END),0) steam_by_prod_BY,
ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Water_cost_BY/production_BY) END),0) watercost_by_prod_BY,
ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Air_cost_BY/production_BY) END),0) aircost_by_prod_BY,
ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Gas_cost_BY/production_BY) END),0) gascost_by_prod_BY,
ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Electricity_cost_BY/production_BY) END),0) electriccost_by_prod_BY,
ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Steam_cost_BY/production_BY) END),0) steamcost_by_prod_BY
FROM
(Select b.Plant_ID,b.Asset_ID,a.base_month,
SUBSTRING(DATENAME(month,(CAST(a.base_year AS varchar(4))+'-'+CAST(a.base_month as varchar(2))+'-'+CAST(1 as varchar(1)))),1,3) as base_monthName , 
a.base_year,b.current_month,
SUBSTRING(DATENAME(month,(CAST(b.current_year AS varchar(4))+'-'+CAST(b.current_month as varchar(2))+'-'+CAST(1 as varchar(1)))),1,3) as current_monthName , 
b.current_year,
ISNULL(MAX(production_BY),0)  production_BY,
ISNULL(MAX(solidwaste_BY),0)  solidwaste_BY,
ISNULL(MAX(production_CY),0)  production_CY,
ISNULL(MAX(solidwaste_CY),0)  solidwaste_CY,
ISNULL(SUM(CASE WHEN a.WAGES_TYPE=1 THEN (a.Consumption_BY) END),0)  Water_consumption_BY, 
ISNULL(SUM(CASE WHEN a.WAGES_TYPE=2 THEN (a.Consumption_BY) END ),0) Air_Consumption_BY,
ISNULL(SUM(CASE WHEN a.WAGES_TYPE=3 THEN (a.Consumption_BY) END ),0) Gas_Consumption_BY,
ISNULL(SUM(CASE WHEN a.WAGES_TYPE=4 THEN (a.Consumption_BY) END),0)  Electricity_Consumption_BY,
ISNULL(SUM(CASE WHEN a.WAGES_TYPE=5 THEN (a.Consumption_BY) END ),0) Steam_Consumption_BY,
ISNULL(SUM(CASE WHEN a.WAGES_TYPE=1 THEN (a.cost_BY ) END ),0) Water_cost_BY,
ISNULL(SUM(CASE WHEN a.WAGES_TYPE=2 THEN (a.cost_BY ) END),0)  Air_cost_BY,
ISNULL(SUM(CASE WHEN a.WAGES_TYPE=3 THEN (a.cost_BY) END ),0) Gas_cost_BY,
ISNULL(SUM(CASE WHEN a.WAGES_TYPE=4 THEN (a.cost_BY ) END ),0) Electricity_cost_BY,
ISNULL(SUM(CASE WHEN a.WAGES_TYPE=5 THEN (a.cost_BY ) END),0)  Steam_cost_BY,
ISNULL(SUM(CASE WHEN b.WAGES_TYPE=1 THEN (b.Consumption_CY) END),0 ) Water_consumption_CY,
ISNULL(SUM(CASE WHEN b.WAGES_TYPE=2 THEN (b.Consumption_CY) END),0)  Air_Consumption_CY,
ISNULL(SUM(CASE WHEN b.WAGES_TYPE=3 THEN (b.Consumption_CY) END),0)  Gas_Consumption_CY,
ISNULL(SUM(CASE WHEN b.WAGES_TYPE=4 THEN (b.Consumption_CY) END ),0) Electricity_Consumption_CY,
ISNULL(SUM(CASE WHEN b.WAGES_TYPE=5 THEN (b.Consumption_CY) END ),0) Steam_Consumption_CY,
ISNULL(SUM(CASE WHEN b.WAGES_TYPE=1 THEN (b.cost_CY ) END),0)  Water_cost_CY,
ISNULL(SUM(CASE WHEN b.WAGES_TYPE=2 THEN (b.cost_CY ) END ),0) Air_cost_CY,
ISNULL(SUM(CASE WHEN b.WAGES_TYPE=3 THEN (b.cost_CY) END),0)  Gas_cost_CY,
ISNULL(SUM(CASE WHEN b.WAGES_TYPE=4 THEN (b.cost_CY ) END) ,0) Electricity_cost_CY,
ISNULL(SUM(CASE WHEN b.WAGES_TYPE=5 THEN (b.cost_CY ) END ),0) Steam_cost_CY
FROM
(SELECT
EAC.Plant_ID,EAC.ID as Asset_ID,ETSD.Month_ID base_month,ETSD.Year_ID base_year,WAGES_TYPE,
(EPA.value) as production_BY,
(EPA.solidwaste) as solidwaste_BY,
	ETSD.WAGES_TYPE as wages,
	ETSD.Consumption as Consumption_BY,
	ETSD.Cost_in_usd as Cost_BY
FROM 
EMMS_Asset_Classification EAC 
INNER JOIN EMMS_consumption_actual ETSD ON EAC.ID=ETSD.Asset_ID INNER JOIN EMMS_production_actual EPA
ON ETSD.Asset_ID=EPA.Asset_ID and ETSD.Year_id=EPA.Year_ID and ETSD.Month_ID=EPA.Month_ID 
INNER JOIN EMMS_Plant_base_year EABY ON EAC.Plant_id =EABY.Plant_id and ETSD.Year_ID=EABY.base_year
) a INNER JOIN
(SELECT
EAC.Plant_ID,EAC.ID as Asset_ID,ETSD.Month_ID Current_month,ETSD.Year_ID Current_year,WAGES_TYPE,
(EPA.value) as production_CY,
(EPA.solidwaste) as solidwaste_CY,
	ETSD.WAGES_TYPE as wages,
	ETSD.Consumption as Consumption_CY,
	ETSD.Cost_in_usd as Cost_CY
FROM 
EMMS_Asset_Classification EAC 
INNER JOIN EMMS_consumption_actual ETSD ON EAC.ID=ETSD.Asset_ID INNER JOIN EMMS_production_actual EPA
ON ETSD.Asset_ID=EPA.Asset_ID and ETSD.Year_id=EPA.Year_ID and ETSD.Month_ID=EPA.Month_ID 
INNER JOIN EMMS_Plant_base_year EABY ON EAC.Plant_ID =EABY.Plant_id and ETSD.Year_ID<>EABY.base_year
) b
ON a.asset_ID=b.asset_ID and b.current_month=a.base_month and a.plant_id=b.plant_id and a.wages_type=b.wages_type
group by 
b.Plant_ID,b.Asset_ID,a.base_month, a.base_year,b.current_month,b.current_year
) a








GO

