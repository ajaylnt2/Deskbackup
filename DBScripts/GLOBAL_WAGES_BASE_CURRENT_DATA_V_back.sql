/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[GLOBAL_WAGES_BASE_CURRENT_DATA_V_back]    Script Date: 04-10-2017 18:01:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






-- Author:  David J    





-- Create date: 19-June-2017    





-- Description: GLOBAL_WAGES_BASE_CURRENT_DATA_V Backup 





-- ========================================================================    





CREATE VIEW [dbo].[GLOBAL_WAGES_BASE_CURRENT_DATA_V_back]    





AS    





Select   





CAST(CAST(current_year as varchar(4))+'-'+CAST(current_month as varchar(2))+'-'+CAST(1 as varchar(1)) as DATE) as DATEID,  





Plant_ID,Asset_ID,    





base_month,    





SUBSTRING(DATENAME(month,(CAST(base_year AS varchar(4))+'-'+CAST(base_month as varchar(2))+'-'+CAST(1 as varchar(1)))),1,3) as base_monthName ,     





base_year,    





current_month,    





SUBSTRING(DATENAME(month,(CAST(current_year AS varchar(4))+'-'+CAST(current_month as varchar(2))+'-'+CAST(1 as varchar(1)))),1,3) as current_monthName ,     





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





ISNULL(solidwastecost_BY,0) solidwastecost_BY, 





ISNULL(solidwastecost_CY,0) solidwastecost_CY,    





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





ISNULL((CASE WHEN production_CY=0 THEN 0 ELSE (solidwastecost_CY/production_CY) END),0) solidcost_by_prod_CY,    





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





ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (solidwastecost_BY/production_BY) END),0) solidcost_by_prod_BY,    





ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Water_cost_BY/production_BY) END),0) watercost_by_prod_BY,    





ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Air_cost_BY/production_BY) END),0) aircost_by_prod_BY,    





ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Gas_cost_BY/production_BY) END),0) gascost_by_prod_BY,    





ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Electricity_cost_BY/production_BY) END),0) electriccost_by_prod_BY,    





ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Steam_cost_BY/production_BY) END),0) steamcost_by_prod_BY,  

((CASE WHEN ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (solidwaste_BY/production_BY) END),0)=0 THEn 0 ELSE 

((ISNULL((CASE WHEN production_CY=0 THEN 0 ELSE (solidwaste_CY/production_CY) END),0) - ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (solidwaste_BY/production_BY) END),0))/ 

ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (solidwaste_BY/production_BY) END),0)) END)+   (CASE WHEN ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Electricity_consumption_BY/production_BY) END),0)=0 THEn 0 ELSE 

((ISNULL((CASE WHEN production_CY=0 THEN 0 ELSE (Electricity_consumption_CY/production_CY) END),0) - ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Electricity_consumption_BY/production_BY) END),0))/ 

ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Electricity_consumption_BY/production_BY) END),0)) END)+ 

(CASE WHEN ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Water_consumption_BY/production_BY) END),0)=0 THEn 0 ELSE 

((ISNULL((CASE WHEN production_CY=0 THEN 0 ELSE (Water_consumption_CY/production_CY) END),0) - ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Water_consumption_BY/production_BY) END),0))/ 

ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Water_consumption_BY/production_BY) END),0)) END)+  

(CASE WHEN ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Gas_consumption_BY/production_BY) END),0)=0 THEn 0 ELSE 

((ISNULL((CASE WHEN production_CY=0 THEN 0 ELSE (Gas_consumption_CY/production_CY) END),0) - ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Gas_consumption_BY/production_BY) END),0))/ 

ISNULL((CASE WHEN production_BY=0 THEN 0 ELSE (Gas_consumption_BY/production_BY) END),0)) END))/4 as 

 Difference_cons_solidwst     

FROM     



(

SELECT



Plant_ID,Asset_ID,base_month, base_year,current_month, current_year, 





MAX(  production_BY)  production_BY,





MAX(  solidwaste_BY)  solidwaste_BY,





MAX(  solidwastecost_BY)  solidwastecost_BY,





MAX(  production_CY)  production_CY,





MAX(  solidwaste_CY)  solidwaste_CY,





MAX(  solidwastecost_CY)  solidwastecost_CY,





SUM(  Water_consumption_BY)  Water_consumption_BY,



SUM( Air_Consumption_BY) Air_Consumption_BY,





SUM( Gas_Consumption_BY) Gas_Consumption_BY,





SUM(  Electricity_Consumption_BY)  Electricity_Consumption_BY,



SUM( Steam_Consumption_BY) Steam_Consumption_BY,





SUM( Water_cost_BY) Water_cost_BY,





SUM(  Air_cost_BY)  Air_cost_BY,





SUM( Gas_cost_BY) Gas_cost_BY,





SUM( Electricity_cost_BY) Electricity_cost_BY,





SUM(  Steam_cost_BY)  Steam_cost_BY,





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

(Select b.Plant_ID,b.Asset_ID,(CASE WHEN ISNULL(a.base_month,0)=0 THEN b.current_month ELSE a.base_month END) base_month, 





--SUBSTRING(DATENAME(month,(CAST(a.base_year AS varchar(4))+'-'+CAST(a.base_month as varchar(2))+'-'+CAST(1 as varchar(1)))),1,3) as base_monthName ,     





(CASE WHEN ISNULL(a.base_year,0)=0 THEN EABY.base_year else  a.base_year end) base_year,b.current_month,    





--SUBSTRING(DATENAME(month,(CAST(b.current_year AS varchar(4))+'-'+CAST(b.current_month as varchar(2))+'-'+CAST(1 as varchar(1)))),1,3) as current_monthName ,     





b.current_year,    





ISNULL((production_BY),0)  production_BY,    





ISNULL((solidwaste_BY),0)  solidwaste_BY,    





ISNULL((solidwastecost_BY),0)  solidwastecost_BY,    





ISNULL((production_CY),0)  production_CY,    





ISNULL((solidwaste_CY),0)  solidwaste_CY,    





ISNULL((solidwastecost_CY),0)  solidwastecost_CY,    





ISNULL((CASE WHEN a.WAGES_TYPE=1 THEN (a.Consumption_BY) END),0)  Water_consumption_BY,     



ISNULL((CASE WHEN a.WAGES_TYPE=2 THEN (a.Consumption_BY) END ),0) Air_Consumption_BY,    





ISNULL((CASE WHEN a.WAGES_TYPE=3 THEN (a.Consumption_BY) END ),0) Gas_Consumption_BY,    





ISNULL((CASE WHEN a.WAGES_TYPE=4 THEN (a.Consumption_BY) END),0)  Electricity_Consumption_BY,     



ISNULL((CASE WHEN a.WAGES_TYPE=5 THEN (a.Consumption_BY) END ),0) Steam_Consumption_BY,    





ISNULL((CASE WHEN a.WAGES_TYPE=1 THEN (a.cost_BY ) END ),0) Water_cost_BY,    





ISNULL((CASE WHEN a.WAGES_TYPE=2 THEN (a.cost_BY ) END),0)  Air_cost_BY,    





ISNULL((CASE WHEN a.WAGES_TYPE=3 THEN (a.cost_BY) END ),0) Gas_cost_BY,    





ISNULL((CASE WHEN a.WAGES_TYPE=4 THEN (a.cost_BY ) END ),0) Electricity_cost_BY,    





ISNULL((CASE WHEN a.WAGES_TYPE=5 THEN (a.cost_BY ) END),0)  Steam_cost_BY,    





ISNULL((CASE WHEN b.WAGES_TYPE=1 THEN (b.Consumption_CY) END),0 ) Water_consumption_CY,    





ISNULL((CASE WHEN b.WAGES_TYPE=2 THEN (b.Consumption_CY) END),0)  Air_Consumption_CY,    





ISNULL((CASE WHEN b.WAGES_TYPE=3 THEN (b.Consumption_CY) END),0)  Gas_Consumption_CY,    





ISNULL((CASE WHEN b.WAGES_TYPE=4 THEN (b.Consumption_CY) END ),0) Electricity_Consumption_CY,    





ISNULL((CASE WHEN b.WAGES_TYPE=5 THEN (b.Consumption_CY) END ),0) Steam_Consumption_CY,    





ISNULL((CASE WHEN b.WAGES_TYPE=1 THEN (b.cost_CY ) END),0)  Water_cost_CY,    





ISNULL((CASE WHEN b.WAGES_TYPE=2 THEN (b.cost_CY ) END ),0) Air_cost_CY,     



ISNULL((CASE WHEN b.WAGES_TYPE=3 THEN (b.cost_CY) END),0)  Gas_cost_CY,    





ISNULL((CASE WHEN b.WAGES_TYPE=4 THEN (b.cost_CY ) END) ,0) Electricity_cost_CY,    





ISNULL((CASE WHEN b.WAGES_TYPE=5 THEN (b.cost_CY ) END ),0) Steam_cost_CY    





FROM    





(SELECT    





EAC.Plant_ID,EAC.ID as Asset_ID,ETSD.Month_ID base_month,ETSD.Year_ID base_year,WAGES_TYPE,    





(EPA.GlobalProduction) as production_BY,    





(EPA.Globalsolidwaste) as solidwaste_BY,    





(EPA.Globalsolidwaste_cost) as solidwasteCost_BY,    





 ETSD.WAGES_TYPE as wages,    





 ETSD.GlobalEnergyConsumption as Consumption_BY,    





 ETSD.Cost_usd as Cost_BY    





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





     INNER JOIN EMMS_PLANT_CONFIG EPG ON ECA.Asset_ID=EPG.asset_ID AND ECA.Year_ID=EPG.current_year) ETSD   





     ON EAC.ID=ETSD.Asset_ID INNER JOIN   





     (select ECA.Month_ID,ECA.Year_ID,ECA.Asset_ID,(Eca.solidwst_cost*EPG.USD_Exchange) as Globalsolidwaste_cost,  





                   (Eca.value*(IsnULL(UC.production,1))) as GlobalProduction,  





       (Eca.solidwaste*(IsnULL(UC.production,1))) as Globalsolidwaste     





     from EMMS_production_actual ECA INNER JOIN UOM_Conversion UC ON (ECA.uom=UC.UOM_ID) 





     INNER JOIN EMMS_PLANT_CONFIG EPG ON ECA.Asset_ID=EPG.asset_ID AND ECA.Year_ID=EPG.current_year) EPA 





ON ETSD.Asset_ID=EPA.Asset_ID and ETSD.Year_id=EPA.Year_ID and ETSD.Month_ID=EPA.Month_ID   INNER JOIN EMMS_Plant_base_year EABY ON EAC.Plant_id =EABY.Plant_id and ETSD.Year_ID=EABY.base_year  

) a RIGHT JOIN 



(SELECT  EAC.Plant_ID,EAC.ID as Asset_ID,ETSD.Month_ID Current_month,ETSD.Year_ID Current_year,WAGES_TYPE,  

(EPA.GlobalProduction) as production_CY,  

(EPA.Globalsolidwaste) as solidwaste_CY,  

(EPA.Globalsolidwaste_cost) as solidwasteCost_CY,   

 ETSD.WAGES_TYPE as wages,  



 ETSD.Consumption as Consumption_CY,   ETSD.Cost_usd as Cost_CY  FROM  





EMMS_Asset_Classification EAC  





INNER JOIN  



(select ECA.Month_ID,ECA.Year_ID,ECA.Wages_type,ECA.Asset_ID,(Eca.cost_in_usd*EPG.USD_Exchange) as Cost_USD,consumption, 





(Eca.consumption*(IsnULL((CASE WHEN ECA.wages_type=1 THEN UC.water  

     WHEN ECA.wages_type=2 THEN UC.Air       WHEN ECA.wages_type=3 THEN UC.gas       WHEN ECA.wages_type=4 THEN UC.Electricity       WHEN ECA.wages_type=5 THEN UC.Steam END ),1))) as GlobalEnergyConsumption      

     from EMMS_consumption_actual ECA INNER JOIN UOM_Conversion UC ON (ECA.uom=UC.UOM_ID) 



     INNER JOIN EMMS_PLANT_CONFIG EPG ON ECA.Asset_ID=EPG.asset_ID AND ECA.Year_ID=EPG.current_year) ETSD  

     ON EAC.ID=ETSD.Asset_ID INNER JOIN  

      (select ECA.Month_ID,ECA.Year_ID,ECA.Asset_ID,(Eca.solidwst_cost*EPG.USD_Exchange) as Globalsolidwaste_cost, 

                   (Eca.value*(IsnULL(UC.production,1))) as GlobalProduction,      (Eca.solidwaste*(IsnULL(UC.production,1))) as Globalsolidwaste    

     from EMMS_production_actual ECA INNER JOIN UOM_Conversion UC ON (ECA.uom=UC.UOM_ID)       INNER JOIN EMMS_PLANT_CONFIG EPG ON ECA.Asset_ID=EPG.asset_ID AND ECA.Year_ID=EPG.current_year) EPA 



ON ETSD.Asset_ID=EPA.Asset_ID and ETSD.Year_id=EPA.Year_ID and ETSD.Month_ID=EPA.Month_ID  

INNER JOIN EMMS_Plant_base_year EABY ON EAC.Plant_ID =EABY.Plant_id and ETSD.Year_ID<>EABY.base_year 

) b 

ON a.asset_ID=b.asset_ID and b.current_month=a.base_month and a.plant_id=b.plant_id and a.wages_type=b.wages_type 

INNER JOIN EMMS_Plant_base_year EABY ON b.plant_Id=eaby.plant_Id and b.asset_ID=eaby.asset_ID )  a

group by  



Plant_ID,Asset_ID,base_year,base_month,current_month,current_year 

) a 



GO

