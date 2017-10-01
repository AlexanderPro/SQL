--SELECT relname, relpages FROM pg_class WHERE relkind = 'r' ORDER BY relpages DESC

SELECT nspname || '.' || relname AS "relation", pg_size_pretty(pg_total_relation_size(C.oid)) AS "total_size"
FROM pg_class C
LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace)
WHERE nspname IN ('public') AND C.relkind <> 'i' AND nspname !~ '^pg_toast'
ORDER BY pg_total_relation_size(C.oid) DESC