/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[Current_Month]    Script Date: 04-10-2017 17:59:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[Current_Month]

AS

select B.PLANT_ID,A.asset_id,year_ID,

FORMAT(CAST(CAST(YEAR_ID AS VARCHAR(4))+'-'+CAST(MAX(MONTH_ID) AS VARCHAR(2))+'-'+CAST(1 AS VARCHAR(1)) AS DATETIME),'MMM-yyyy') MonthName

 from emms_consumption_actual A

INNER JOIN EMMS_ASSET_CLASSIFICATION B ON A.ASSET_ID=B.ID WHERE B.TYPE=1

AND CONSUMPTION<>0

group by B.PLANT_ID,A.asset_id,year_ID
GO

