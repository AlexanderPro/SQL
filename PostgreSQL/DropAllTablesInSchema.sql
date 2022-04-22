DO $$
DECLARE
  r RECORD;
BEGIN
  FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'schema_name')
  LOOP
    EXECUTE 'DROP TABLE IF EXISTS ' || quote_ident(r.tablename) || 'CASCADE';
  END LOOP;
END $$;