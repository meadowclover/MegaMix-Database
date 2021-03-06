USE [Music]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




ALTER   PROCEDURE [dbo].[Total_Time]

@MixID INT

AS
/******************************************************************************
* Description: Finds the total run time of a mixtape
*			   	
*			
* Procedure Test: 
	
	EXEC [dbo].[Total_Time]
		
* Change History:
* -----------------------------------------------------------------------------
* Date			|Author				|Reason
* -----------------------------------------------------------------------------
* 02/20/2022	Meadow Faulkner		Created Procedure
*
*******************************************************************************/
BEGIN
	SET NOCOUNT ON;


	
	SELECT CONVERT(Varchar(10), dateadd(second, run , 0), 108) AS totalTime, SongID, MixID
	FROM 
		(SELECT SUM(DATEPART(ss, s.Length) + 60 * DATEPART(mi, s.Length))OVER(ORDER BY ms.songID) AS run, ms.SongID, ms.MixID
		FROM MixtapeSong AS ms
		LEFT JOIN Mixtapes AS m ON ms.MixID = m.MixID
		LEFT JOIN Songs AS s ON ms.SongID = s.SongID
		WHERE m.MixID = @MixID
		GROUP BY ms.SongID, ms.MixID, s.Length) AS sumTime
	ORDER BY totalTime DESC

END


