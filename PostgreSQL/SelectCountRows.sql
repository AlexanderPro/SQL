'SELECT count(*) FROM "Table";

SELECT reltuples::bigint AS estimate FROM pg_class WHERE relname='Table';