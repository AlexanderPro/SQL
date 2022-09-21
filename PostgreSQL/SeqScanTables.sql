select schemaname, relname, seq_scan, seq_tup_read, seq_tup_read / seq_scan as avg, idx_scan 
from pg_stat_user_tables
where seq_scan > 0
order by seq_tup_read desc
limit 20