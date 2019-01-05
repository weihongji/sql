-- Return query result, e.g., returned by SELECT statement.
IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'SearchLabel') BEGIN
	DROP PROCEDURE SearchLabel
END
GO

CREATE PROCEDURE SearchLabel
	@keyword nvarchar(100) = null
AS
BEGIN
	SET NOCOUNT ON
	
	IF LEN(@keyword) > 0 BEGIN
		SELECT * FROM Label WHERE Name LIKE N'%' + @keyword + '%' OR  Description LIKE N'%' + @keyword + '%'
	END
	ELSE BEGIN
		SELECT * FROM Label
	END
END
GO

--EXEC SearchLabel N'银行'
