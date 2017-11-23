/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[pv_consumption]    Script Date: 04-10-2017 18:05:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create view [dbo].[pv_consumption]
as
SELECT *
FROM (
    SELECT 
        Year_id,CONVERT(CHAR,Month_id) [Month],asset_id,wages_type,UOM, 
        consumption
    FROM emms_consumption_actual
) as s
PIVOT
(
    SUM(consumption)
    FOR [month] IN ("1","2","3","4","5", "6", "7", "8", "9", "10", "11", "12")
)AS pvt
GO

