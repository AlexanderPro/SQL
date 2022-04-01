select schemaname, relname, last_analyze from pg_stat_user_tables
order by last_analyze desc
limit 100