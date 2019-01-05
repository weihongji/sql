-- Return a scalar value
IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[func1]') AND type = N'FN') BEGIN
	DROP FUNCTION dbo.func1
END
GO

CREATE FUNCTION dbo.func1 (@string varchar(100))
RETURNS varchar(100)
AS
BEGIN
	DECLARE @s nvarchar(max) = ISNULL(@string, '')
	RETURN UPPER(@s)
END
GO

--SELECT dbo.func1('Abc')