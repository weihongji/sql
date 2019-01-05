drop view dbo.DBs
GO
CREATE VIEW dbo.DBs
AS
	SELECT db.name AS DB, sum(mf.size)*8/1024/1000 as Size, MIN(physical_name) AS Physical_File, CONVERT(varchar(16), db.create_date, 120) AS Created_Date, suser_sname(db.owner_sid) AS Created_By
	FROM sys.databases db
		LEFT JOIN sys.master_files mf ON db.database_id = mf.database_id
		LEFT JOIN sys.syslogins lg on db.owner_sid = lg.sid
	GROUP BY db.name, db.create_date, db.owner_sid --, lg.name
