WITH raw_data AS (
  SELECT
    pg_namespace.nspname,
    pg_class.relname,
    pg_class.oid AS relid,
    pg_class.reltuples,
    pg_stat_all_tables.n_dead_tup,
    pg_stat_all_tables.n_mod_since_analyze,
    (SELECT split_part(x, '=', 2) FROM unnest(pg_class.reloptions) q (x) WHERE x ~ '^autovacuum_analyze_scale_factor=' ) as c_analyze_factor,
    (SELECT split_part(x, '=', 2) FROM unnest(pg_class.reloptions) q (x) WHERE x ~ '^autovacuum_analyze_threshold=' ) as c_analyze_threshold,
    (SELECT split_part(x, '=', 2) FROM unnest(pg_class.reloptions) q (x) WHERE x ~ '^autovacuum_vacuum_scale_factor=' ) as c_vacuum_factor,
    (SELECT split_part(x, '=', 2) FROM unnest(pg_class.reloptions) q (x) WHERE x ~ '^autovacuum_vacuum_threshold=' ) as c_vacuum_threshold,
    to_char(pg_stat_all_tables.last_vacuum, 'YYYY-MM-DD HH24:MI:SS') as last_vacuum,
    to_char(pg_stat_all_tables.last_autovacuum, 'YYYY-MM-DD HH24:MI:SS') as last_autovacuum
  FROM
    pg_class
  JOIN pg_namespace ON pg_class.relnamespace = pg_namespace.oid
    LEFT OUTER JOIN pg_stat_all_tables ON pg_class.oid = pg_stat_all_tables.relid
  WHERE
    n_dead_tup IS NOT NULL
    AND nspname NOT IN ('information_schema', 'pg_catalog')
    AND nspname NOT LIKE 'pg_toast%'
    AND pg_class.relkind = 'r'
), data AS (
  SELECT
    *,
    COALESCE(raw_data.c_analyze_factor, current_setting('autovacuum_analyze_scale_factor'))::float8 AS analyze_factor,
    COALESCE(raw_data.c_analyze_threshold, current_setting('autovacuum_analyze_threshold'))::float8 AS analyze_threshold,
    COALESCE(raw_data.c_vacuum_factor, current_setting('autovacuum_vacuum_scale_factor'))::float8 AS vacuum_factor,
    COALESCE(raw_data.c_vacuum_threshold, current_setting('autovacuum_vacuum_threshold'))::float8 AS vacuum_threshold
  FROM raw_data
)
SELECT
  relid,
  nspname,
  relname,
  reltuples,
  n_dead_tup,
  ROUND(reltuples * vacuum_factor + vacuum_threshold) AS v_threshold,
  n_mod_since_analyze,
  ROUND(reltuples * analyze_factor + analyze_threshold) AS a_threshold,
  c_analyze_factor as caf,
  c_analyze_threshold as cat,
  c_vacuum_factor as cvf,
  c_vacuum_threshold as cvt,
  analyze_factor as af,
  analyze_threshold as at,
  vacuum_factor as vf,
  vacuum_threshold as vt,
  last_vacuum,
  last_autovacuum
FROM
  data
ORDER BY n_dead_tup DESC;