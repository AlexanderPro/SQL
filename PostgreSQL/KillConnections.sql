-- Select connections
SELECT pid, usename, client_addr, backend_start, query FROM pg_stat_activity WHERE datname = 'dbname';

-- Kill connections except the current
SELECT pg_terminate_backend( pid ) FROM pg_stat_activity WHERE pid <> pg_backend_pid( ) AND datname = 'dbname';