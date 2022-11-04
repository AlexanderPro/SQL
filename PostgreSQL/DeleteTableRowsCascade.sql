CREATE OR REPLACE PROCEDURE DeleteTableRows(schema_name TEXT, table_name TEXT, primary_key_name TEXT, primary_key_values BIGINT[])
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    foreign_key_record record;
    foreign_key_cursor refcursor;
    foreign_key_values BIGINT[];
    foreign_key_value BIGINT;
    query TEXT;
    count BIGINT;    
BEGIN
    query := 'SELECT r.table_schema, r.table_name, r.column_name
        FROM information_schema.constraint_column_usage u
        INNER JOIN information_schema.referential_constraints fk ON u.constraint_catalog = fk.unique_constraint_catalog
        AND u.constraint_schema = fk.unique_constraint_schema
        AND u.constraint_name = fk.unique_constraint_name
        INNER JOIN information_schema.key_column_usage r ON r.constraint_catalog = fk.constraint_catalog
        AND r.constraint_schema = fk.constraint_schema
        AND r.constraint_name = fk.constraint_name
        WHERE u.table_schema = $1 AND u.table_name = $2 AND u.column_name = $3
        ORDER BY r.table_name';

    OPEN foreign_key_cursor FOR EXECUTE query USING schema_name, table_name, primary_key_name;
    
    LOOP
        FETCH foreign_key_cursor INTO foreign_key_record;
        EXIT WHEN NOT FOUND;

        query := 'SELECT COUNT(*) FROM ' || foreign_key_record.table_schema || '."' || foreign_key_record.table_name || '" WHERE "' || foreign_key_record.column_name || '" = ANY($1);';
        EXECUTE query INTO count USING primary_key_values;

        IF count > 0 THEN
            query := 'SELECT ARRAY(SELECT DISTINCT "' || primary_key_name || '" FROM ' || foreign_key_record.table_schema || '."' || foreign_key_record.table_name || '" WHERE "' || foreign_key_record.column_name || '" = ANY($1));';
            EXECUTE query INTO foreign_key_values USING primary_key_values;
        
            IF ARRAY_LENGTH(foreign_key_values, 1) > 0 THEN
                CALL DeleteTableRows(foreign_key_record.table_schema, foreign_key_record.table_name, primary_key_name, foreign_key_values);
            END IF;
        END IF;
    END LOOP;
    query := 'DELETE FROM ' || schema_name || '."' || table_name || '" WHERE "' || primary_key_name || '" = ANY($1);';
    RAISE NOTICE '%', query;
    EXECUTE query USING primary_key_values;
END;
$BODY$;