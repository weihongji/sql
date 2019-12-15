--https://dataedo.com/kb/query/sql-server/list-tables-with-their-primary-keys
select tab.[name] as table_name, pk.[name] as pk_name, substring(column_names, 1, len(column_names)-1) as [columns]
from sys.tables tab
	left outer join sys.indexes pk on tab.object_id = pk.object_id and pk.is_primary_key = 1
	cross apply (
		select col.[name] + ', ' from sys.index_columns ic inner join sys.columns col on ic.object_id = col.object_id and ic.column_id = col.column_id
		where ic.object_id = tab.object_id and ic.index_id = pk.index_id
		order by col.column_id
		for xml path ('') 
	) D (column_names)
--where tab.name in ('ARTRANSACTIONS','CREDITCARDS','CUST_COMP_LINK')
order by schema_name(tab.schema_id), tab.[name]