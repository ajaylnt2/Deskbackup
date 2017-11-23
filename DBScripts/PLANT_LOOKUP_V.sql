/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[PLANT_LOOKUP_V]    Script Date: 04-10-2017 18:03:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- ======================================================================
-- Author:		David J
-- Create date: 16-June-2017
-- Description:	PLANT_LOOKUP
-- ========================================================================

CREATE VIEW [dbo].[PLANT_LOOKUP_V]
AS
SELECT 
a.ID as Plant_ID,
Plant_name as Plant,
GPS_lon,
GPS_lat,
Address,
b.Name as Zone,
c.Name as Country 
FROM  
EMMS_PLANT_DETAILS a,
EMMS_MASTER_ZONE b,
EMMS_MASTER_COUNTRY c
WHERE a.zone_id=b.id AND a.country=c.ID


GO

