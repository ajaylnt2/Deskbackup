/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[ASSET_BASE_CURRENT_DETAIL]    Script Date: 04-10-2017 17:56:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- ======================================================================

-- Author:		David J

-- Create date: 19-June-2017

-- Description:	ASSET_BASE_CURRENT_DDETAIL

-- ========================================================================

CREATE VIEW [dbo].[ASSET_BASE_CURRENT_DETAIL]

AS

select 

(CASE WHEN ISNULL(b.Plant_id,0)=0 THEN a.Plant_id ELSE b.Plant_id END) as Plant_ID ,

(CASE WHEN ISNULL(b.asset_id,0)=0 THEN a.asset_id ELSE b.asset_id END) as asset_id ,

(CASE WHEN ISNULL(b.current_month,0)=0 THEN a.base_month ELSE b.current_month END) as actual_month ,

SUBSTRING(DATENAME(month,(CAST((CASE WHEN ISNULL(b.current_year,0)=0 THEN a.base_year ELSE b.current_year END) AS varchar(4))+'-'+
CAST((CASE WHEN ISNULL(b.current_month,0)=0 THEN a.base_month ELSE b.current_month END) as varchar(2))+'-'+CAST(1 as varchar(1)))),1,3) as monthName_actual,

SUBSTRING(DATENAME(month,(CAST(b.current_year as varchar(4))+'-'+CAST(b.current_month as varchar(2))+'-'+CAST(1 as varchar(1)))),1,3) as monthName_CY,
b.current_month , 

(CASE WHEN ISNULL(b.current_year,0)=0 THEN YEAR(getdate()) ELSE  b.current_year END) current_year,

a.base_month,

SUBSTRING(DATENAME(month,(CAST(a.base_year AS varchar(4))+'-'+CAST(a.base_month as varchar(2))+'-'+CAST(1 as varchar(1)))),1,3) as monthName_BY , 

a.base_year,production_BY ,

production_CY,

(CASE WHEN ISNULL(b.wages,0)=0 THEN a.wages ELSE b.wages END) as wages,

consumption_cy,

cost_cy,

consumption_BY,

cost_BY,

Consumption_div_prod_BY,

Cost_div_prod_BY,

Consumption_div_prod_CY,

Cost_div_prod_CY, 

(CASE WHEN ISNULL(b.Unitofmeasurement,0)='0' THEN a.Unitofmeasurement ELSE b.Unitofmeasurement END) as Unitofmeasurement

FROM

(SELECT

	EAC.Plant_ID,EAC.ID as Asset_ID,ETSD.Month_ID base_month,ETSD.Year_ID base_year,

	(EPA.value) as production_BY,

	ETSD.WAGES_TYPE as wages,

	ETSD.Consumption as Consumption_BY,

	ETSD.Cost_in_usd as cost_BY,

	CASE WHEN EPA.value =0 THEN 0 ELSE ETSD.Consumption/EPA.value END as [Consumption_div_prod_BY],

	CASE WHEN EPA.value =0 THEN 0 ELSE ETSD.Cost_in_usd/EPA.value END as [Cost_div_prod_BY],

	CONCAT(CONCAT(ETSD.description,'/'),EPA.description) as UnitOfmeasurement

FROM 

	EMMS_Asset_Classification EAC 

	INNER JOIN 

	(select a.*,b.description from EMMS_consumption_actual a,emms_master_wages_uom b where a.uom=b.id) ETSD ON EAC.ID=ETSD.Asset_ID INNER JOIN 

	(select a.*,b.description from EMMS_production_actual a,emms_master_wages_uom b where a.uom=b.id) EPA

	ON ETSD.Asset_ID=EPA.Asset_ID and ETSD.Year_id=EPA.Year_ID and ETSD.Month_ID=EPA.Month_ID

	INNER JOIN EMMS_Plant_base_year EABY ON EAC.Plant_id =EABY.Plant_id and ETSD.Year_ID=EABY.base_year

) a 

FULL OUTER JOIN

(SELECT

	EAC.Plant_ID,EAC.ID as Asset_ID,ETSD.Month_ID Current_month,ETSD.Year_ID Current_year,

	(EPA.value) as production_CY,

	ETSD.WAGES_TYPE as Wages,

	ETSD.Consumption as Consumption_CY,

	ETSD.Cost_in_usd as cost_CY,

	CASE WHEN EPA.value =0 THEN 0 ELSE ETSD.Consumption/EPA.value END as [Consumption_div_prod_CY],

	CASE WHEN EPA.value =0 THEN 0 ELSE ETSD.Cost_in_usd/EPA.value END as [Cost_div_prod_CY],

	CONCAT(CONCAT(ETSD.description,'/'),EPA.description) as UnitOfmeasurement

	FROM 

	EMMS_Asset_Classification EAC 

	INNER JOIN 

	(select a.*,b.description from EMMS_consumption_actual a,emms_master_wages_uom b where a.uom=b.id) ETSD ON EAC.ID=ETSD.Asset_ID INNER JOIN 

	(select a.*,b.description from EMMS_production_actual a,emms_master_wages_uom b where a.uom=b.id) EPA

	ON ETSD.Asset_ID=EPA.Asset_ID and ETSD.Year_id=EPA.Year_ID and ETSD.Month_ID=EPA.Month_ID

	INNER JOIN EMMS_Plant_base_year EABY ON EAC.Plant_id =EABY.Plant_id and ETSD.Year_ID = YEAR(getdate())

) b

ON a.asset_ID=b.asset_ID and b.current_month=a.base_month and a.plant_id=b.plant_id and a.wages=b.wages

--group by 

--b.Plant_ID,b.Asset_ID,a.base_month, a.base_year,b.current_month,b.current_year



GO

