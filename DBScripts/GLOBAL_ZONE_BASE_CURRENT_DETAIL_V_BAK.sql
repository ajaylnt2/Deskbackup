/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[GLOBAL_ZONE_BASE_CURRENT_DETAIL_V_BAK]    Script Date: 04-10-2017 18:01:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


 -- ====================================================================== 

-- Author:		David J 

-- Create date: 10-July-2017 

-- Description:	GLOBAL_ZONE_BASE_CURRENT_DETAIL_V backup 

-- ======================================================================== 

CREATE VIEW [dbo].[GLOBAL_ZONE_BASE_CURRENT_DETAIL_V_BAK] 

AS 

select 



CAST(CAST(current_year as varchar(4))+'-'+CAST(current_month as varchar(2))+'-'+CAST(1 as varchar(1)) as DATE) as DATEID,



b.Plant_id, 

b.asset_id, 

b.current_month , 

SUBSTRING(DATENAME(month,(CAST(b.current_year AS varchar(4))+'-'+CAST(b.current_month as varchar(2))+'-'+CAST(1 as varchar(1)))),1,3) as monthName_CY, 

b.current_year , 

a.base_month, 

SUBSTRING(DATENAME(month,(CAST(a.base_year AS varchar(4))+'-'+CAST(a.base_month as varchar(2))+'-'+CAST(1 as varchar(1)))),1,3) as monthName_BY ,  

a.base_year,production_BY , 

production_CY, 

b.wages, 

consumption_cy, 

cost_cy, 

consumption_BY, 

cost_BY, 

Consumption_div_prod_BY, 

Cost_div_prod_BY, 

Consumption_div_prod_CY, 

Cost_div_prod_CY 

FROM 

(SELECT 

	EAC.Plant_ID,EAC.ID as Asset_ID,ETSD.Month_ID base_month,ETSD.Year_ID base_year, 

	(EPA.globalproduction) as production_BY, 

	ETSD.WAGES_TYPE as wages, 

	ETSD.GlobalEnergyConsumption as Consumption_BY, 

	ETSD.Cost_usd as cost_BY, 

	CASE WHEN EPA.globalproduction =0 THEN 0 ELSE ETSD.GlobalEnergyConsumption/EPA.globalproduction END as [Consumption_div_prod_BY], 

	CASE WHEN EPA.globalproduction =0 THEN 0 ELSE ETSD.Cost_usd/EPA.globalproduction END as [Cost_div_prod_BY] 

FROM  

	EMMS_Asset_Classification EAC  

	INNER JOIN  

	(select ECA.Month_ID,ECA.Year_ID,ECA.Wages_type,ECA.Asset_ID,(Eca.cost_in_usd*EPG.USD_Exchange) as Cost_USD,consumption,



                   (Eca.consumption*(IsnULL((CASE WHEN ECA.wages_type=1 THEN UC.water 



					WHEN ECA.wages_type=2 THEN UC.Air 



					WHEN ECA.wages_type=3 THEN UC.gas 



					WHEN ECA.wages_type=4 THEN UC.Electricity 



					WHEN ECA.wages_type=5 THEN UC.Steam END ),1))) as GlobalEnergyConsumption					



			  from EMMS_consumption_actual ECA INNER JOIN UOM_Conversion UC ON (ECA.uom=UC.UOM_ID)



			  INNER JOIN EMMS_PLANT_CONFIG EPG ON ECA.Asset_ID=EPG.asset_ID AND ECA.Year_ID=EPG.current_year) ETSD ON EAC.ID=ETSD.Asset_ID INNER JOIN  

	(select ECA.Month_ID,ECA.Year_ID,ECA.Asset_ID,(Eca.value*(IsnULL(UC.production,1))) as GlobalProduction



			  from EMMS_production_actual ECA INNER JOIN UOM_Conversion UC ON ECA.uom=UC.UOM_ID)  EPA 

	ON ETSD.Asset_ID=EPA.Asset_ID and ETSD.Year_id=EPA.Year_ID and ETSD.Month_ID=EPA.Month_ID 

	INNER JOIN EMMS_Plant_base_year EABY ON EAC.Plant_id =EABY.Plant_id and ETSD.Year_ID=EABY.base_year   

) a  

RIGHT JOIN 

(SELECT 

	EAC.Plant_ID,EAC.ID as Asset_ID,ETSD.Month_ID Current_month,ETSD.Year_ID Current_year, 

	(EPA.globalproduction) as production_CY, 

	ETSD.WAGES_TYPE as Wages, 

	ETSD.GlobalEnergyConsumption as Consumption_CY, 

	ETSD.Cost_usd as cost_CY, 

	CASE WHEN EPA.globalproduction =0 THEN 0 ELSE ETSD.Consumption/EPA.globalproduction END as [Consumption_div_prod_CY], 

	CASE WHEN EPA.globalproduction =0 THEN 0 ELSE ETSD.Cost_usd/EPA.globalproduction END as [Cost_div_prod_CY] 

	FROM  

	EMMS_Asset_Classification EAC  

	INNER JOIN  

	(select ECA.Month_ID,ECA.Year_ID,ECA.Wages_type,ECA.Asset_ID,(Eca.cost_in_usd*EPG.USD_Exchange) as Cost_USD,consumption,



                   (Eca.consumption*(IsnULL((CASE WHEN ECA.wages_type=1 THEN UC.water 



					WHEN ECA.wages_type=2 THEN UC.Air 



					WHEN ECA.wages_type=3 THEN UC.gas 



					WHEN ECA.wages_type=4 THEN UC.Electricity 



					WHEN ECA.wages_type=5 THEN UC.Steam END ),1))) as GlobalEnergyConsumption					



			  from EMMS_consumption_actual ECA INNER JOIN UOM_Conversion UC ON (ECA.uom=UC.UOM_ID)



			  INNER JOIN EMMS_PLANT_CONFIG EPG ON ECA.Asset_ID=EPG.asset_ID AND ECA.Year_ID=EPG.current_year) ETSD ON EAC.ID=ETSD.Asset_ID INNER JOIN  

	(select ECA.Month_ID,ECA.Year_ID,ECA.Asset_ID,(Eca.value*(IsnULL(UC.production,1))) as GlobalProduction



			  from EMMS_production_actual ECA INNER JOIN UOM_Conversion UC ON ECA.uom=UC.UOM_ID)  EPA 

	ON ETSD.Asset_ID=EPA.Asset_ID and ETSD.Year_id=EPA.Year_ID and ETSD.Month_ID=EPA.Month_ID 

	INNER JOIN EMMS_Plant_base_year EABY ON EAC.Plant_id =EABY.Plant_id and ETSD.Year_ID<>EABY.base_year 

) b 

ON a.asset_ID=b.asset_ID and b.current_month=a.base_month and a.plant_id=b.plant_id and a.wages=b.wages 

--group by  

--b.Plant_ID,b.Asset_ID,a.base_month, a.base_year,b.current_month,b.current_year 





GO

