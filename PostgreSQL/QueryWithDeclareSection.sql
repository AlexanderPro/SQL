DO LANGUAGE plpgsql $$
DECLARE
    some_variable INT;
BEGIN
    some_variable = 100;
    raise notice 'some_variable = %', some_variable;
END
$$;