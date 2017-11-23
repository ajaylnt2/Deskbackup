/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[TIMESERIES_OTHERS_CONSUMPTION_V]    Script Date: 04-10-2017 18:07:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[TIMESERIES_OTHERS_CONSUMPTION_V] 







AS







SELECT 



   EAC.Plant_ID,





	ETD.Asset_ID,







	ETD.Wages_type,







	EU.Description UOM,







	DATEID,







	ett.MONTHID,







	FORMAT(ETT.DATE_TIME,'MMM') Monthly,







	ett.YearID,







	Concat(FORMAT(ETT.DATE_TIME,'HH'),':00') Hourly,



	
    Concat(FORMAT(ETT.DATE_TIME,'mm'),':00') Minutes,



	ETT.Actual_CONSUMPTION CONSUMPTION ,







	ETD.target ConsumptionTarget,







	WUC.unit_cost,



	(ETT.Actual_CONSUMPTION)*(WUC.unit_cost) as EstimatedCost







FROM







EMMS_TAG_TIMESERIESDATA ETT INNER JOIN EMMS_TAG_DETAILS ETD ON 







ETT.TAG_ID=ETD.ID  INNER JOIN EMMS_ASSET_CLASSIFICATION EAc ON ETD.asset_ID=EAC.ID INNER JOIN







EMMS_MASTER_WAGES_UOM EU ON ETD.uom=EU.ID







LEFT JOIN WAGES_UNIT_COST_USD WUC ON ett.YEARid=WUC.Year_ID and ETD.Wages_type=WUC.Wages_type







AND ETD.Asset_ID=WUC.Asset_ID 







WHERE EAC.type >9









GO

