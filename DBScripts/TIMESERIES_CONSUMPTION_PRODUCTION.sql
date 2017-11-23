/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[TIMESERIES_CONSUMPTION_PRODUCTION]    Script Date: 04-10-2017 18:06:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[TIMESERIES_CONSUMPTION_PRODUCTION]
AS
SELECT 
DATE , 
b.Asset_ID,
b.wages_type,
MAX(WUC.unit_cost) as unit_cost,
SUM(consumption) AS consumption,
b.UOM AS wages_uom,
EPD.Shift_ID,
SUM(EPD.Value) AS production ,
EPD.UOM AS production_UOM 
FROM EMMS_Tag_SummaryData a INNER JOIN EMMS_Tag_Details b 
ON a.Tag_ID=b.ID LEFT OUTER JOIN
EMMS_Production_Daily EPD 
ON EPD.Asset_ID=b.Asset_ID AND 
EPD.Date_Time=a.date INNER JOIN WAGES_UNIT_COST_USD WUC
ON a.Year_ID=WUC.Year_ID AND b.Wages_type=WUC.Wages_type
GROUP BY a.date, 
b.Asset_ID,
b.wages_type,
b.UOM ,
EPD.Shift_ID,
EPD.UOM

GO

