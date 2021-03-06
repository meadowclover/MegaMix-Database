USE [Music]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[GetAlbums]
@ArtistID INT
AS
/******************************************************************************
* Description: A procedure that returns Albums by a given artist
*			   	
*			
* Procedure Test: 
	
	EXEC dbo.GetAlbums

* Change History:
* -----------------------------------------------------------------------------
* Date			|Author				|Reason
* -----------------------------------------------------------------------------
* 01/11/2022	Meadow Faulkner		Created Procedure
*******************************************************************************/
BEGIN

	SET NOCOUNT ON;
	

		SELECT DISTINCT a.AlbumTitle, a.AlbumID, art.ArtistID
		FROM Artists AS art
		INNER JOIN SongArtist AS sa ON art.ArtistID = sa.ArtistID
		INNER JOIN Songs AS s ON sa.SongID = s.SongID
		INNER JOIN Albums AS a ON s.AlbumID = a.AlbumID
		WHERE art.ArtistID = @ArtistID
		
	

END;
