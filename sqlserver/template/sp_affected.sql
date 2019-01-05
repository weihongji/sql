-- Return number of affected rows
IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'AssignLabel') BEGIN
	DROP PROCEDURE AssignLabel
END
GO

CREATE PROCEDURE AssignLabel @accounts varchar(max), @labels varchar(max)
AS
BEGIN
	SET NOCOUNT OFF
	INSERT INTO AccountLabel(AccountId, LabelId)
	SELECT AccountId, LabelId FROM (
			SELECT CAST(A.value AS int) AS AccountId, CAST(L.value AS int) AS LabelId
			FROM STRING_SPLIT(@accounts, ',') A , STRING_SPLIT(@labels, ',') L
			WHERE LEN(A.value) > 0 AND LEN(L.value) > 0
		) AS X
	WHERE NOT EXISTS(SELECT * FROM AccountLabel WHERE AccountId = X.AccountId AND LabelId = X.LabelId)
	ORDER BY AccountId, LabelId
END