USE [Music]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[Get_TimeRange]
@TimeLabel INT,
@StyleID INT
AS
/******************************************************************************
* Description: Selects distinct Style names
*			   	
*			
* Procedure Test: 
	
	EXEC dbo.Get_TimeRange

* Change History:
* -----------------------------------------------------------------------------
* Date			|Author				|Reason
* -----------------------------------------------------------------------------
* 02/07/2022	Meadow Faulkner		Created Procedure
* 02/12/2022	Meadow Faulkner		Added Parameter @StyleID
* 03/01/2022	Meadow Faulkner		Switched from CTE to tempTable
*******************************************************************************/
BEGIN

	SET NOCOUNT ON;

	SELECT DISTINCT s.SongTitle, cast(datepart(minute, s.Length)+datepart(second, s.Length) / 100.00 as decimal(5,2)) as runTime, s.BPM, a.AlbumTitle, YEAR(a.Year) AS [Date], a.AlbumID, s.SongID, sty.StyleID, 
		(CASE WHEN s.Length <= '00:01:30' THEN 1 
		WHEN s.Length BETWEEN '00:01:31' AND '00:04:59' THEN 2 
		WHEN s.Length BETWEEN '00:05:00' AND '00:07:30' THEN 3
		ELSE 4
		END) AS ordering
	INTO #timelabel
	FROM Songs AS s
	LEFT JOIN Albums AS a ON s.AlbumID = a.AlbumID
	LEFT JOIN AlbumStyle AS ast ON a.AlbumID = ast.AlbumID
	LEFT JOIN Style AS sty ON ast.StyleID = sty.StyleID

	SELECT *
	FROM #timelabel
	WHERE ordering = @TimeLabel AND StyleID = @StyleID


END;
