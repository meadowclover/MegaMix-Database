USE [Music]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[Time_Range_Label]

AS
/******************************************************************************
* Description: Creates the labels for the dbo.Get_TimeRange report perameter
*			   	
*			
* Procedure Test: 
	
	EXEC dbo.Time_Range_Label

* Change History:
* -----------------------------------------------------------------------------
* Date			|Author				|Reason
* -----------------------------------------------------------------------------
* 02/07/2022	Meadow Faulkner		Created Procedure
*
*******************************************************************************/
BEGIN

	SET NOCOUNT ON;
	
	
		
		SELECT 'Short, under 1.5 min' AS [Length],
		1 AS ordering

	UNION

		SELECT 'Medium, under 5 min' as [Length],
		2 AS ordering

	UNION

		SELECT 'Long, under 7.5 min' as [Length],
		3 AS ordering

	UNION

		SELECT 'Really Long, 7.5 min +' as [Length],
		4 AS ordering

		ORDER BY ordering

END;
