/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[ACTUAL_BUDGET_CONSUMPTION_V]    Script Date: 04-10-2017 17:39:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- ======================================================================

-- Author:		David J

-- Create date: 7-July-2017

-- Description: ACTUAL_BUDGET_CONSUMPTION_V

-- ========================================================================

CREATE VIEW [dbo].[ACTUAL_BUDGET_CONSUMPTION_V]

AS

SELECT

Month_ID,

SUBSTRING(DATENAME(month,(CAST(Year_id AS varchar(4))+'-'+CAST(Month_ID as varchar(2))+'-'+CAST(1 as varchar(1)))),1,3) as monthName,

Year_id,

wages_type,

asset_id,

uom_id,

cost_in_usd,

consumption,

cost_budget,

consumption_budget,

eu.description as uom

FROM

(SELECT 

CASE WHEN IsNULL(eca.Month_id,0)=0 THEN eecb.Month_id ELSE eca.Month_id END as Month_ID,

CASE WHEN IsNULL(eca.Year_id,0)=0 THEN eecb.Year_id ELSE eca.Year_id END as Year_id,

CASE WHEN IsNULL(eca.wages_type,0)=0 THEN eecb.wages_type ELSE eca.wages_type END as wages_type,

CASE WHEN IsNULL(eca.asset_id,0)=0 THEN eecb.asset_id ELSE eca.asset_id END as asset_id,

CASE WHEN IsNULL(eca.uom,0)=0 THEN eecb.uom ELSE eca.uom END as uom_id,

IsNULL(eca.cost_in_usd,0) cost_in_usd,

IsNULL(eca.consumption,0) consumption,

IsNULL(eecb.cost_in_usd,0) as cost_budget,

IsNULL(eecb.consumption,0) as consumption_budget

FROM emms_consumption_actual eca LEFT JOIN

emms_energy_consumption_budget eecb ON eca.month_id=eecb.month_ID and eca.year_id=eecb.year_id and eca.asset_id =eecb.asset_id and eca.wages_type=eecb.wages_type) a

INNER JOIN emms_master_wages_uom eu

ON a.uom_id=eu.id  



GO

