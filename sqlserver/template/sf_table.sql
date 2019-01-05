-- Return an inline table
IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[func2]') AND type = N'TF') BEGIN
	DROP FUNCTION dbo.func2
END
GO

CREATE FUNCTION dbo.func2 (@string nvarchar(max), @separator nvarchar(1))
RETURNS @tbl TABLE (value nvarchar(max) NOT NULL)
AS
BEGIN
	IF DATALENGTH(ISNULL(@string, '')) = 0 OR LEN(ISNULL(@separator, '')) = 0 BEGIN
		RETURN
	END

	DECLARE @i int, @val nvarchar(max)

	SET @i = CHARINDEX(@separator, @string)
	WHILE @i > 0 BEGIN
		SET @val = SUBSTRING(@string, 1, @i - 1)
		INSERT INTO @tbl(value) VALUES (@val)

		SET @string = SUBSTRING(@string, @i + 1, LEN(@string))
		SET @i = CHARINDEX(@separator, @string)
	END

	INSERT INTO @tbl(value) VALUES (@string)
	RETURN
END
GO

--SELECT * FROM dbo.func2('a,b,c', ',')