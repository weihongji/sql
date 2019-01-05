/*
STRING_SPLIT inputs a string that has delimited substrings, and inputs one character to use as the delimiter or separator.
STRING_SPLIT outputs a single-column table whose rows contain the substrings. The name of the output column is value.

Example:
	Parse a comma-separated list of values and return all non-empty tokens:

	DECLARE @tags NVARCHAR(400) = 'clothing,road,,touring,bike'
	SELECT value FROM STRING_SPLIT(@tags, ',') WHERE RTRIM(value) <> '';

Notes:
1. Space character cannot be used as separator. If need a blank character, use tab instead.
2. STRING_SPLIT will return empty string if there is nothing between separator.
3. Such function is ready in SQL Server 2016 and later.
   Reference: https://docs.microsoft.com/en-us/sql/t-sql/functions/string-split-transact-sql?view=sql-server-2017
*/
IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STRING_SPLIT]') AND type = N'TF') BEGIN
	DROP FUNCTION dbo.STRING_SPLIT
END
GO

CREATE FUNCTION dbo.STRING_SPLIT (@string nvarchar(max), @separator nvarchar(1))
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
