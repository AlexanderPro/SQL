select prosrc from pg_catalog.pg_proc pp, pg_catalog.pg_namespace pn 
where pn.oid = pp.pronamespace and pn.nspname = 'public' and pp.proname = 'func_name';