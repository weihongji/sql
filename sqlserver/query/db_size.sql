select cast(ROUND(cast(size/128/1024.0 as decimal(8, 2)), 2) as varchar) + ' GB' as size_g, cast(size/128 as varchar) + ' MB' as size_m, name, filename from sysfiles