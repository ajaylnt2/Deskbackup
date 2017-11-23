/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[GLOBAL_WAGES_DATA_V]    Script Date: 04-10-2017 18:01:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


 -- Author:  David J     







-- Create date: 19-June-2017     







-- Description: GLOBAL_WAGES_DATA_V







-- ========================================================================     







CREATE VIEW [dbo].[GLOBAL_WAGES_DATA_V]     







AS   







SELECT Plant_ID,Asset_ID,current_month, current_year, 







CAST(CAST(current_year as varchar(4))+'-'+CAST(current_month as varchar(2))+'-'+CAST(1 as varchar(1)) as DATE) as DATEID,   







SUBSTRING(DATENAME(month,(CAST(current_year AS varchar(4))+'-'+CAST(current_month as varchar(2))+'-'+CAST(1 as varchar(1)))),1,3) as current_monthName ,  







MAX(  production_CY)  production_CY, 







MAX(  solidwaste_CY)  solidwaste_CY, 







MAX(  solidwastecost_CY)  solidwastecost_CY, 







SUM( Water_consumption_CY) Water_consumption_CY, 







SUM(  Air_Consumption_CY)  Air_Consumption_CY, 







SUM(  Gas_Consumption_CY)  Gas_Consumption_CY, 







SUM( Electricity_Consumption_CY) Electricity_Consumption_CY, 







SUM( Steam_Consumption_CY) Steam_Consumption_CY, 







SUM(  Water_cost_CY)  Water_cost_CY, 







SUM( Air_cost_CY) Air_cost_CY, 







SUM(  Gas_cost_CY)  Gas_cost_CY, 







SUM( Electricity_cost_CY) Electricity_cost_CY, 







SUM( Steam_cost_CY    ) Steam_cost_CY    







  FROM







(Select b.Plant_ID,b.Asset_ID,







b.current_month, 







b.current_year,     







ISNULL((production_CY),0)  production_CY,     







ISNULL((solidwaste_CY),0)  solidwaste_CY,     







ISNULL((solidwastecost_CY),0)  solidwastecost_CY,  







ISNULL((CASE WHEN b.WAGES_TYPE=1 THEN (b.GlobalEnergyConsumption) END),0 ) Water_consumption_CY,     







ISNULL((CASE WHEN b.WAGES_TYPE=2 THEN (b.GlobalEnergyConsumption) END),0)  Air_Consumption_CY,     







ISNULL((CASE WHEN b.WAGES_TYPE=3 THEN (b.GlobalEnergyConsumption) END),0)  Gas_Consumption_CY,     







ISNULL((CASE WHEN b.WAGES_TYPE=4 THEN (b.GlobalEnergyConsumption) END ),0) Electricity_Consumption_CY,     







ISNULL((CASE WHEN b.WAGES_TYPE=5 THEN (b.GlobalEnergyConsumption) END ),0) Steam_Consumption_CY,     







ISNULL((CASE WHEN b.WAGES_TYPE=1 THEN (b.cost_CY ) END),0)  Water_cost_CY,     







ISNULL((CASE WHEN b.WAGES_TYPE=2 THEN (b.cost_CY ) END ),0) Air_cost_CY,      







ISNULL((CASE WHEN b.WAGES_TYPE=3 THEN (b.cost_CY) END),0)  Gas_cost_CY,     







ISNULL((CASE WHEN b.WAGES_TYPE=4 THEN (b.cost_CY ) END) ,0) Electricity_cost_CY,     







ISNULL((CASE WHEN b.WAGES_TYPE=5 THEN (b.cost_CY ) END ),0) Steam_cost_CY     







FROM  







(



SELECT   EAC.Plant_id,A.*



FROM      







EMMS_Asset_Classification EAC      







INNER JOIN  



	(SELECT 



	isNULL(ETSD.Month_ID,EPA.Month_ID) as Current_month,



	isNULL(ETSD.Year_ID,EPA.Year_ID) as Current_year,



	isNULL(ETSD.Asset_ID,EPA.Asset_ID) as Asset_ID,



	ETSD.Wages_type , Cost_USD as Cost_CY,consumption as Consumption_CY,GlobalEnergyConsumption,



	Globalsolidwaste_cost as solidwasteCost_CY,GlobalProduction as production_CY,Globalsolidwaste as solidwaste_CY



	FROM



    (SELECT 



	ECA.Month_ID,ECA.Year_ID,ECA.Wages_type,ECA.Asset_ID,(Eca.cost_in_usd*EPG.USD_Exchange) as Cost_USD,consumption,



    (Eca.consumption*(IsnULL((CASE WHEN ECA.wages_type=1 THEN UC.water 



							       WHEN ECA.wages_type=2 THEN UC.Air      



								   WHEN ECA.wages_type=3 THEN UC.gas       



								   WHEN ECA.wages_type=4 THEN UC.Electricity       



								   WHEN ECA.wages_type=5 THEN UC.Steam END ),1))) as GlobalEnergyConsumption     



     FROM EMMS_consumption_actual ECA 



	 INNER JOIN UOM_Conversion UC ON (ECA.uom=UC.UOM_ID)      



	 INNER JOIN EMMS_PLANT_CONFIG EPG ON ECA.Asset_ID=EPG.asset_ID AND ECA.Year_ID=EPG.current_year) ETSD  



     FULL OUTER JOIN  



    (SELECT ECA.Month_ID,ECA.Year_ID,ECA.Asset_ID,(Eca.solidwst_cost*EPG.USD_Exchange) as Globalsolidwaste_cost, 



    (Eca.value*(IsnULL(UC.production,1))) as GlobalProduction,      (Eca.solidwaste*(IsnULL(UC.production,1))) as Globalsolidwaste   



     FROM EMMS_production_actual ECA INNER JOIN UOM_Conversion UC ON (ECA.uom=UC.UOM_ID)       



	 INNER JOIN EMMS_PLANT_CONFIG EPG ON ECA.Asset_ID=EPG.asset_ID AND ECA.Year_ID=EPG.current_year) EPA 



	 ON ETSD.Asset_ID=EPA.Asset_ID and ETSD.Year_id=EPA.Year_ID and ETSD.Month_ID=EPA.Month_ID ) A 



	 ON EAC.ID = A.Asset_ID and EAC.type=1



) b



) glb

WHERE glb.current_month<=MONTH(getdate()) and glb.current_year<=YEAR(getdate())

group by   Plant_ID,Asset_ID,current_month,current_year 
GO

