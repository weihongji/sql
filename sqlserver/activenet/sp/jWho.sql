USE Jesse

jWho 'portlandparks'

--drop PROCEDURE jWho

CREATE PROCEDURE jWho @dbname varchar(100)
AS
BEGIN
	IF NOT EXISTS (select * from sys.tables where name= 'who') BEGIN
		create table Who(spid int, ecid int, status varchar(100), loginame varchar(100), hostame varchar(100), blk int, dbname varchar(100), cmd varchar(100), request_id int)
	END

	DELETE FROM Who

	INSERT INTO Who EXEC sp_who

	SELECT * FROM Who WHERE dbname = @dbname
END