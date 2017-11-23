/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[ASSET_ACTUAL_PRODUCTION]    Script Date: 04-10-2017 17:43:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- ======================================================================



-- Author:		David J



-- Create date: 19-June-2017



-- Description: ASSET_ACTUAL_PRODUCTION



-- ========================================================================



CREATE VIEW [dbo].[ASSET_ACTUAL_PRODUCTION]



AS



SELECT 



Month_id,



SUBSTRING(DATENAME(Month,CAST(CAST(Year_id as VARCHAR(4))+'-'+CAST(MONTH_ID as varchar(2))+'-'+CAST(1 as varchar(1)) as DATETIME)),1,3) Month_name,



Year_id,



asset_id,



value actualproduction,



solidwaste actualsolid,



eu.description as uom



FROM emms_production_actual eca INNER JOIN emms_master_wages_uom eu



ON eca.uom=eu.id
GO

