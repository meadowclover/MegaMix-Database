USE [Music]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[GetArtists]



AS
/******************************************************************************
* Description:  A procedure that returns distinct artist names
*			   	
*			
* Procedure Test: 
	
	EXEC dbo.GetArtists

* Change History:
* -----------------------------------------------------------------------------
* Date			|Author				|Reason
* -----------------------------------------------------------------------------
* 01/11/2022	Meadow Faulkner		Created Procedure
*******************************************************************************/
BEGIN

	SET NOCOUNT ON;
	

		SELECT DISTINCT art.ArtistName, art.ArtistID
		FROM Artists AS art
		ORDER BY art.ArtistName ASC
		
	

END;
