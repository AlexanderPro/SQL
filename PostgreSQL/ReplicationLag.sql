 --Before PG10
select
client_addr as client, usename as user, application_name as name, state,
sync_state as mode,
(pg_wal_lsn_diff(pg_current_wal_lsn(),sent_lsn) / 1024)::int as pending,
(pg_wal_lsn_diff(sent_lsn,write_lsn) / 1024)::int as write,
(pg_wal_lsn_diff(write_lsn,flush_lsn) / 1024)::int as flush,
(pg_wal_lsn_diff(flush_lsn,replay_lsn) / 1024)::int as replay,
(pg_wal_lsn_diff(pg_current_wal_lsn(),replay_lsn) / 1024)::int / 1024 as
total_lag
from pg_stat_replication;
 
--After PG10
select
client_addr as client, usename as user, application_name as name, state,
sync_state as mode,
(pg_xlog_location_diff(pg_current_xlog_location(),sent_location) /
1024)::int as pending,
(pg_xlog_location_diff(sent_location,write_location) / 1024)::int as write,
(pg_xlog_location_diff(write_location,flush_location) / 1024)::int as
flush,
(pg_xlog_location_diff(flush_location,replay_location) / 1024)::int as
replay,
(pg_xlog_location_diff(pg_current_xlog_location(),replay_location) /
1024)::int / 1024 as total_lag
from pg_stat_replication;