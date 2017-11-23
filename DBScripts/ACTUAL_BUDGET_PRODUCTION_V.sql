/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[ACTUAL_BUDGET_PRODUCTION_V]    Script Date: 04-10-2017 17:40:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- ======================================================================



-- Author:		David J



-- Create date: 7-July-2017



-- Description: ACTUAL_BUDGET_PRODUCTION_V



-- ========================================================================



CREATE VIEW [dbo].[ACTUAL_BUDGET_PRODUCTION_V]



AS



SELECT



Month_ID,



SUBSTRING(DATENAME(month,(CAST(Year_id AS varchar(4))+'-'+CAST(Month_ID as varchar(2))+'-'+CAST(1 as varchar(1)))),1,3) as monthName,



Year_id,



asset_id,



uom_id,



production,



solidwaste,



productionbudget,



solidwastebudget,



eu.description as uom



FROM



(SELECT 



CASE WHEN IsNULL(eca.Month_id,0)=0 THEN eecb.Month_id ELSE eca.Month_id END as Month_ID,



CASE WHEN IsNULL(eca.Year_id,0)=0 THEN eecb.Year_id ELSE eca.Year_id END as Year_id,



CASE WHEN IsNULL(eca.asset_id,0)=0 THEN eecb.asset_id ELSE eca.asset_id END as asset_id,



CASE WHEN IsNULL(eca.uom,0)=0 THEN eecb.uom ELSE eca.uom END as uom_id,



IsNULL(eca.value,0) production,



IsNULL(eca.solidwaste,0) solidwaste,


IsNULL(eca.solidwst_cost,0) solidwastecost,


IsNULL(eecb.value,0) as productionbudget,



IsNULL(eecb.solidwaste,0) as solidwastebudget,

IsNULL(eecb.solidwst_cost,0) solidwastecostbudget


FROM emms_production_actual eca LEFT JOIN



emms_production_budget eecb ON eca.month_id=eecb.month_ID and eca.year_id=eecb.year_id and eca.asset_id =eecb.asset_id ) a



INNER JOIN emms_master_wages_uom eu



ON a.uom_id=eu.id  





GO

