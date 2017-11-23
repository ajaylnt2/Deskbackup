/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[WAGES_UNIT_COST_USD]    Script Date: 04-10-2017 18:08:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






-- ======================================================================

-- Author:		David J

-- Create date: 25-MAY-2017

-- Description:	WAGES_UNIT_COST_USD

-- ========================================================================



CREATE VIEW [dbo].[WAGES_UNIT_COST_USD]

AS

SELECT EAC.Plant_id,ECA.ASSET_ID,Year_ID,Wages_type,
(case when sum(consumption)=0 OR sum(cost_in_usd)=0 THEN 0 ELSE round(sum(cost_in_usd)/sum(consumption),2) END) AS unit_cost 

FROM EMMS_Consumption_ACTUAL ECA,EMMS_ASSET_CLASSIFICATION EAC

WHERE 

ECA.ASSET_ID =EAC.ID AND EAC.type=1 AND

Year_ID< YEAR(CURRENT_TIMESTAMP)

GROUP BY EAC.Plant_id,ECA.ASSET_ID,Year_ID,Wages_type

UNION

SELECT EAC.Plant_id,EECA.ASSET_ID,Year_ID,Wages_type,(case when sum(consumption)=0 OR sum(cost_in_usd)=0 THEN 0 ELSE round(sum(cost_in_usd)/sum(consumption),2) END) AS unit_cost 

FROM EMMS_Energy_Consumption_Budget EECA,EMMS_ASSET_CLASSIFICATION EAC

WHERE 

EECA.ASSET_ID =EAC.ID AND  EAC.type=1 AND

Year_ID= YEAR(CURRENT_TIMESTAMP)

GROUP BY EAC.Plant_id,EECA.ASSET_ID,Year_ID,Wages_type
GO

