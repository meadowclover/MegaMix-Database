USE [Music]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




ALTER  PROCEDURE [dbo].[Insert_Mix_Details]

@mixID INT,
@mixName NVARCHAR(50),
@Description NVARCHAR(300)
AS
/******************************************************************************
* Description: Inserts title and description for a new playlist into the Mixtapes table
*			   	
*			
* Procedure Test: 
	
	EXEC [dbo].[Insert_Mix_Details]
	
* Change History:
* -----------------------------------------------------------------------------
* Date			|Author				|Reason
* -----------------------------------------------------------------------------
* 02/15/2022	Meadow Faulkner		Created Procedure
* 02/17/2022	Meadow Faulkner		Added parameter @mixID
*******************************************************************************/
BEGIN

	SET NOCOUNT ON;
	

	
	IF (SELECT COUNT(mixID) 
	FROM Mixtapes
	WHERE mixID = @mixID) > 0 BEGIN
	SELECT 'Sorry, there''s already a mix associated with that ID' AS message, 0 AS mixID
	RETURN
END
	
	ELSE IF LEN(@mixName) > 50 BEGIN
		SELECT 'Slow down there, partner! Your title is too long!' AS message, 0 AS mixID
		RETURN
	END

	ELSE IF LEN(@mixName) < 1 BEGIN
		SELECT 'Hey there, bud! You forgot to name your mixtape!' AS message, 0 AS mixID
		RETURN
	END
	
	ELSE IF @mixName = 
		(SELECT MixName
		FROM Mixtapes
		WHERE @mixName = MixName) BEGIN
		SELECT 'Sorry, A mix using the name ' + RTRIM(@mixName) + ' already exists.' AS message, 0 AS mixID
		RETURN
	END
	
	ELSE BEGIN
	INSERT INTO Mixtapes (MixName, MixDescription)
	VALUES (@mixName, @Description)

	SELECT 'Huzzah! Your Mix ' + RTRIM(@mixName) + ' was added successfully' AS message, IDENT_CURRENT('Mixtapes') AS mixID
	END
	
END


