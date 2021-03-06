USE [Music]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





ALTER     PROCEDURE [dbo].[FunStats]


AS
/******************************************************************************
* Description: Pulls totals for run time, # of songs, styles, artists, and albums
*			   	
*			
* Procedure Test: 
	
	EXEC [dbo].[FunStats]
		
* Change History:
* -----------------------------------------------------------------------------
* Date			|Author				|Reason
* -----------------------------------------------------------------------------
* 02/28/2022	Meadow Faulkner		Created Procedure
* 03/10/2022	Meadow Faulkner		Separated style count from first insert statement
*******************************************************************************/
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS #totalTemp	

	CREATE TABLE #totalTemp (totalHours INT, totalSongs INT, totalArtists INT, totalAlbums INT, totalStyle INT)

	INSERT INTO #totalTemp (totalSongs, totalArtists, totalAlbums)
		SELECT COUNT(DISTINCT(s.SongID)) AS totalSongs, COUNT(DISTINCT(art.ArtistID)) AS totalArtists, COUNT(DISTINCT(alb.AlbumID)) AS totalAlbums
		FROM Songs AS s
		INNER JOIN SongArtist AS sa ON s.SongID = sa.SongID
		INNER JOIN Artists AS art ON sa.ArtistID = art.ArtistID
		INNER JOIN Albums AS alb ON s.AlbumID = alb.AlbumID

	UPDATE #totalTemp
	SET totalStyle = 
		(SELECT COUNT(DISTINCT(sty.StyleID)) AS totalStyle
		FROM Style AS sty)
	WHERE totalStyle IS NULL

	UPDATE #totalTemp 
	SET totalHours = runTime
	FROM
		(SELECT TOP 1 ([run] / 3600) AS runTime
		FROM (SELECT SUM(DATEPART(ss, s.Length) + 60 * DATEPART(mi, s.Length))OVER(ORDER BY s.songID) AS run, s.SongID 
		FROM Songs AS s
		GROUP BY s.Length, s.SongID) AS sumTime
	ORDER BY runTime DESC) AS insertTime
	WHERE totalHours IS NULL

	SELECT * FROM #totalTemp

END




