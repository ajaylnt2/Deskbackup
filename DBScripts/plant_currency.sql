/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[plant_currency]    Script Date: 04-10-2017 18:02:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



create view [dbo].[plant_currency]
as
select distinct EAC.Plant_ID,EAC.ID as asset_ID,currency from emms_plant_config epg
inner join Emms_asset_classification eac on eac.id=epg.asset_ID
GO

