CREATE OR REPLACE FUNCTION Eval(expression text) RETURNS INTEGER AS $body$
DECLARE
  RESULT INTEGER;
BEGIN
  EXECUTE EXPRESSION INTO RESULT;
  RETURN RESULT;
END;
$body$ LANGUAGE PLPGSQL;


SELECT v.table,
       v.sequence, 
       setval('"' || v.sequence || '"', v.max_for_table + 10) AS last_value
FROM
  (SELECT a.attname AS column,
          t.relname AS table,
          s.relname AS sequence,
          Eval('SELECT MAX("' || a.attname || '") FROM ' || n.nspname || '."' || t.relname || '"') AS max_for_table,
          Eval('SELECT last_value FROM "' || s.relname || '"') AS value_for_sequence
   FROM pg_class s
   JOIN pg_depend d ON d.objid = s.oid
   JOIN pg_class t ON d.objid = s.oid AND d.refobjid = t.oid
   JOIN pg_attribute a ON (d.refobjid, d.refobjsubid) = (a.attrelid, a.attnum)
   JOIN pg_namespace n ON n.oid = s.relnamespace
   WHERE s.relkind = 'S'
     AND n.nspname = 'public' ) AS v
WHERE v.max_for_table IS NOT NULL
  AND v.max_for_table > v.value_for_sequence;

DROP FUNCTION IF EXISTS Eval(expression text);