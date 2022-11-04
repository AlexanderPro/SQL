SELECT n.nspname AS schema_name, 
       p.proname AS function_name, 
       pg_get_function_arguments(p.oid) AS args, 
       pg_get_functiondef(p.oid) AS func_def
FROM   pg_proc p
JOIN   pg_namespace n ON n.oid = p.pronamespace
AND    n.nspname IN ('public')