/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[PLANT_SOLIDWASTE_UOM_V]    Script Date: 04-10-2017 18:04:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[PLANT_SOLIDWASTE_UOM_V]
AS
SELECT PlantID,solidwasteuom uomid,
description as UOM
FROM
Emms_Plant_Production_Uom_Map eppm INNER JOIN
Emms_master_wages_uom EMU ON
eppm.solidwasteuom=EMU.ID

GO

