SELECT idx.relname as table,
       idx.indexrelname as index,
       pg_size_pretty( pg_relation_size( cls.oid ) ) AS table_size,
       pg_size_pretty( pg_relation_size( idx.indexrelid ) ) as index_size,
       pg_size_pretty( pg_total_relation_size( cls.oid ) ) AS total_size,
       cls.relpages as pages,
       cls.reltuples as tuples,
       idx.idx_scan as scanned,
       idx.idx_tup_read as read,
       idx.idx_tup_fetch as fetched
  FROM pg_stat_user_indexes idx,
       pg_class cls,
       pg_index pgi
 WHERE cls.relname = idx.relname
   AND idx.indexrelid = pgi.indexrelid
   AND pgi.indisunique is not true
   AND pgi.indisprimary is not true
   AND idx.indexrelname not ilike '%slony%'
   AND idx.indexrelname not like 'sl\_%'
ORDER BY idx.relname,
         idx.indexrelname;