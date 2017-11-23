/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dbo].[PLANT_TAG_ALARM_V]    Script Date: 04-10-2017 18:04:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[PLANT_TAG_ALARM_V]



AS



SELECT PlantID,Historian_tag,Wages_type,EMW.description as UOM,Value,Timestamp as AlarmTime,

DATEPART(YEAR,Timestamp) as YearID,

DATEPART(MONTH,Timestamp) as MonthID,

SUBSTRING(DATENAME(MONTH,Timestamp),1,3) as Month,

CONVERT(DATE,Timestamp) as DATEID



FROM



EMMS_AlarmEventDetails EPA INNER JOIN



Emms_tag_details ETD ON



EPA.TagID=ETD.ID INNER JOIN EMMS_MASTER_WAGES_UOM EMW



ON ETD.UOM=EMW.ID
GO

