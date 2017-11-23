/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[PLANT_MASTER_DETAILS_V]    Script Date: 04-10-2017 18:03:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- ======================================================================
-- Author:		David J
-- Create date: 19-June-2017
-- Description: PLANT_MASTER_DETAILS
-- ========================================================================

CREATE VIEW [dbo].[PLANT_MASTER_DETAILS_V]
AS
SELECT
a.ID as Plant_ID,
Plant_name,
b.Name as Zone,
c.name as country,
GPS_Lon,
GPS_lat,
Address
FROM
EMMS_PLANT_DETAILS a,
EMMS_MASTER_ZONE b,
EMMS_MASTER_COUNTRY c
WHERE
a.zone_id=b.id AND a.country=c.id

GO

