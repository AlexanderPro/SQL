--SELECT pg_size_pretty(pg_database_size('database_name'))
SELECT pg_size_pretty(pg_database_size(current_database()))