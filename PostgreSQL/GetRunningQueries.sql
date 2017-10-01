SELECT pid, now() - query_start as "runtime", age(query_start, clock_timestamp()), usename, datname, state, query
FROM pg_stat_activity 
WHERE query != '<IDLE>' AND query NOT ILIKE '%pg_stat_activity%' 
ORDER BY query_start DESC