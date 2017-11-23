/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[ASSET_CLASSIFICATION_LOOKUP]    Script Date: 04-10-2017 17:56:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[ASSET_CLASSIFICATION_LOOKUP]

AS

SELECT 

EAC.ID as Asset_ID, 

EAC.Name Asset_name,

EAC.Description ,

EAC.Plant_ID ,

EMAT.ID as Asset_type_ID,

EMAT.Name as Asset_type 

FROM

EMMS_ASSET_CLASSIFICATION EAC RIGHT JOIN

EMMS_MASTER_ASSET_TYPE EMAT

ON EAC.type=EMAT.ID
GO

