USE [Music]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[Sort_By_Artist]

@ArtistID INT,
@AlbumID INT

AS
/******************************************************************************
* Description:  A procedure that returns the Song, Album, Artist, Run Time, Year, BPM, 
*				Album ID, and Artist ID for songs within a certain Artist and Album
*			
* Procedure Test: 
	
	EXEC dbo.Sort_By_Artist

* Change History:
* -----------------------------------------------------------------------------
* Date			|Author				|Reason
* -----------------------------------------------------------------------------
* 02/05/2022	Meadow Faulkner		Created Procedure
* 02/06/2022	Meadow Faulkner		Added Perameter @ArtistName
* 02/10/2022	Meadow Faulkner		Added Perameter @AlbumID
*******************************************************************************/
BEGIN

	SET NOCOUNT ON;
	

	
	SELECT s.SongTitle, s.SongID, a.AlbumTitle, art.ArtistName, cast(datepart(minute, s.[Length])+datepart(second, s.[Length]) / 100.00 as decimal(5,2)) as runTime, YEAR(a.[Year]) AS Date, s.BPM, a.AlbumID, art.ArtistID
	FROM Albums AS a
	INNER JOIN Songs AS s ON a.AlbumID = s.AlbumID
	INNER JOIN SongArtist AS soa ON soa.SongID = s.SongID
	INNER JOIN Artists AS art ON art.ArtistID = soa.ArtistID
	WHERE art.ArtistID = @ArtistID AND a.AlbumID = @AlbumID
	
	

END;




