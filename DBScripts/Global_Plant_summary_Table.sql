/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[Global_Plant_summary_Table]    Script Date: 04-10-2017 18:00:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[Global_Plant_summary_Table] AS
SELECT A.Month_ID ,A.Year_ID,
A.Asset_ID ,
SUM(B.production_MT) production_MT,SUM(B.solidwaste_MT) solidwaste_MT,
SUM(A.Water_cost) Water_cost,
SUM(A.Gas_cost) Gas_cost,
Sum(A.steam_cost) Steam_Cost,
Sum(A.Air_cost) Air_Cost,
sum(A.electricity_cost) as electricity_cost,
sum(A.electricity_Kwh) as Electricity_Kwh,
sum(A.Water_Gal) as Water_Gal,
sum(A.gas_Scf) as gas_Scf,
sum(A.Steam_Scf) as Steam_Scf,
sum(A.Air_Scf) as Air_Scf
FROM
(SELECT ETSD.Year_ID Year_ID,ETSD.Month_ID Month_ID,ETSD.Asset_ID,
SUM(CASE WHEN ETSD.Wages_type =4 THEN WUC.unit_cost*ETSD.Consumption END) as Electricity_cost,
SUM(CASE WHEN ETSD.Wages_type =1 THEN WUC.unit_cost*ETSD.Consumption END) as Water_cost,
SUM(CASE WHEN ETSD.Wages_type =3 THEN WUC.unit_cost*ETSD.Consumption END) as gas_cost,
SUM(CASE WHEN ETSD.Wages_type =5 THEN WUC.unit_cost*ETSD.Consumption END) as Steam_cost,
SUM(CASE WHEN ETSD.Wages_type =2 THEN WUC.unit_cost*ETSD.Consumption END) as Air_cost,
SUM(CASE WHEN ETSD.Wages_type =4 THEN ETSD.Consumption END) as Electricity_Kwh,
SUM(CASE WHEN ETSD.Wages_type =1 THEN ETSD.Consumption END) as Water_Gal,
SUM(CASE WHEN ETSD.Wages_type =3 THEN ETSD.Consumption END) as gas_Scf,
SUM(CASE WHEN ETSD.Wages_type =5 THEN ETSD.Consumption END) as Steam_Scf,
SUM(CASE WHEN ETSD.Wages_type =2 THEN ETSD.Consumption END) as Air_Scf
FROM
EMMS_CONSUMPTION_ACTUAL ETSD INNER JOIN 
WAGES_UNIT_COST_USD WUC ON ETSD.Year_ID=WUC.Year_ID and ETSD.Wages_type=WUC.Wages_type
WHERE ETSD.Year_ID=YEAR(CURRENT_TIMESTAMP)
group by ETSD.Year_ID,ETSD.Month_ID,
ETSD.Asset_ID) A 
LEFT OUTER JOIN
(SELECT EPA.Asset_id,EPA.Month_ID,Epa.Year_ID,
(EPA.Value) as production_MT,(Epa.solidwaste) as Solidwaste_MT FROM
EMMS_Production_Actual EPA ) B 
ON A.Asset_ID=B.Asset_ID AND A.Month_ID=B.Month_ID and A.Year_ID=B.Year_ID
Group by A.Month_ID ,A.Year_ID,A.Asset_ID


GO

