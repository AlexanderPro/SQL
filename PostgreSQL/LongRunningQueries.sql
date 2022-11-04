SELECT pid, now() - query_start as "runtime", usename, datname, state, query
FROM  pg_stat_activity
WHERE now() - query_start > '60 second'::interval
ORDER BY runtime DESC