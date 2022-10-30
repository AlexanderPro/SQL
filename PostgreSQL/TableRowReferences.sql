DO $$
DECLARE
    foreign_key_record record;
    foreign_key_cursor refcursor;
    count BIGINT;
    query TEXT;
    title TEXT;
    schema_name TEXT := 'public';
    table_name TEXT  := 'table_name';
    primary_key_name TEXT := 'Id';
    primary_key_value BIGINT := 1000000;
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

    OPEN foreign_key_cursor FOR EXECUTE query using schema_name, table_name, primary_key_name;
    
    LOOP
        FETCH foreign_key_cursor INTO foreign_key_record;
        EXIT WHEN NOT FOUND;

        query := 'SELECT COUNT(*) FROM ' || foreign_key_record.table_schema || '."' || foreign_key_record.table_name || '" WHERE "' || foreign_key_record.column_name || '"=' || primary_key_value;
        EXECUTE query INTO count;
        IF count > 0 THEN
            title := foreign_key_record.table_schema || '."' || foreign_key_record.table_name || '"."' || foreign_key_record.column_name || '"';
            RAISE NOTICE '%', title;
        END IF;
    END LOOP;
END $$ LANGUAGE plpgsql;
