SELECT schemaname,
    relname,
    seq_scan-idx_scan AS too_much_seq,
    case when seq_scan-idx_scan>0 THEN 'Missing Index?' ELSE 'OK' END, 
    pg_relation_size(format('%I.%I', schemaname, relname)::regclass) AS rel_size,
    seq_scan,
    idx_scan
FROM pg_stat_user_tables
WHERE pg_relation_size(format('%I.%I', schemaname, relname)::regclass)>100000 ORDER BY too_much_seq DESC;