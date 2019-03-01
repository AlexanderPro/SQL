--SELECT relname, relpages FROM pg_class WHERE relkind = 'r' ORDER BY relpages DESC

--SELECT nspname || '.' || relname AS "relation", pg_size_pretty(pg_total_relation_size(C.oid)) AS "total_size"
--FROM pg_class C
--LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace)
--WHERE nspname IN ('public') AND C.relkind <> 'i' AND nspname !~ '^pg_toast'
--ORDER BY pg_total_relation_size(C.oid) DESC

SELECT
    TABLE_NAME,
    pg_size_pretty(table_size) AS table_size,
    pg_size_pretty(indexes_size) AS indexes_size,
    pg_size_pretty(total_size) AS total_size
FROM (
    SELECT
        TABLE_NAME,
        pg_table_size(TABLE_NAME) AS table_size,
        pg_indexes_size(TABLE_NAME) AS indexes_size,
        pg_total_relation_size(TABLE_NAME) AS total_size
    FROM (
        SELECT ('"' || table_schema || '"."' || TABLE_NAME || '"') AS TABLE_NAME
        FROM information_schema.tables
        WHERE table_schema = 'public'
    ) AS all_tables
    ORDER BY total_size DESC
) AS pretty_sizes;