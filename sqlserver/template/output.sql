INSERT INTO SYSTEMINFO (KEYWORD, KEYWORDVALUE)
OUTPUT inserted.KEYWORD, inserted.KEYWORDVALUE INTO RollbackDB.dbo.ANE_10011_SYSTEMINFO(KEYWORD, KEYWORDVALUE)
VALUES ('keyword', 'value')

UPDATE SYSTEMINFO SET KEYWORDVALUE = 'value'
OUTPUT deleted.KEYWORD, deleted.KEYWORDVALUE INTO RollbackDB.dbo.ANE_10011_SYSTEMINFO(KEYWORD, KEYWORDVALUE)
WHERE KEYWORD = 'keyword' AND KEYWORDVALUE NOT LIKE 'value'