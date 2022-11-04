CREATE TEMP TABLE random_numbers
AS 
SELECT generate_series(1, 100) AS id, ((random()*1000)::INTEGER)::text as value;

--DELETE FROM random_numbers WHERE id > 90 RETURNING *;
--UPDATE random_numbers SET value = 'constant' WHERE id > 80 RETURNING *;
INSERT INTO random_numbers(id, value) VALUES(101, 123) RETURNING *;

DROP TABLE random_numbers;