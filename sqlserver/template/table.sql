IF NOT EXISTS(SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('Label')) BEGIN
	CREATE TABLE dbo.Label(
		Id int IDENTITY(1,1) NOT NULL,
		Name nvarchar(100) NOT NULL,
		Description nvarchar(500) NULL,
		DateStamp datetime NOT NULL CONSTRAINT DF_Label_DateStamp DEFAULT (getdate()),
		CONSTRAINT PK_Label PRIMARY KEY CLUSTERED
		(
			Id ASC
		)
	) ON [PRIMARY]
END