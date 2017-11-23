/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[ASSET_WAGES_MASTER]    Script Date: 04-10-2017 17:59:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[ASSET_WAGES_MASTER]
AS
SELECT 
a.plant_ID,
a.wages_type as wages_ID,
ISNULL(b.wages_display,a.wagesname) as wages_name,
wages_category,
CASE WHEN wages_category=1 THEN 'CONSUMPTION' ELSE 'PERFORMANCE' END as category
FROM
(SELECT 
a.ID as plant_ID,
b.Id as wages_type,
b.wages_category,
b.description as wagesname
FROM emms_plant_details a cross join
(SELECT * FROM emms_master_wages_type) b
WHERE a.active='Y') a
left join
Emms_wages_display b
ON a.plant_id=b.plant_id and a.wages_type=b.wages_type
GO

