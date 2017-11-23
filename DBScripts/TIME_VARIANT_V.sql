/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[TIME_VARIANT_V]    Script Date: 04-10-2017 18:05:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[TIME_VARIANT_V]

as

select month_ID,year_ID,

SUBSTRING(DATENAME(MONTH,CAST(CAST(YEAR_ID as varchar(4))+'-'+CAST(MONTH_ID as varchar(2))+'-'+CAST(1 as varchar(1)) as DATE)),1,3) as monthname,

CAST(CAST(YEAR_ID as varchar(4))+'-'+CAST(MONTH_ID as varchar(2))+'-'+CAST(1 as varchar(1)) as DATE) as DATEID

FROM (

select  distinct

CASE WHEN ISNULL(a.month_id,0)=0 THEN b.month_id ELSE a.month_id END Month_ID,

CASE WHEN ISNULL(a.year_id,0)=0 THEN b.year_id ELSE a.year_id END Year_ID

FROM

emms_consumption_actual a full outer join emms_energy_consumption_budget b

ON a.month_id=b.month_id and a.Year_ID=b.Year_ID WHERE a.year_ID>0 and b.Year_ID>0) a
GO

