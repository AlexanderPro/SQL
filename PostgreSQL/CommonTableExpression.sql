WITH table_1 (id, a, b) AS 
(
	WITH
		table_2 (id, a) AS (SELECT 1, 1),
		table_3 (id, b) AS (SELECT 2, 2)  
	SELECT * FROM table_2 FULL JOIN table_3 USING (id)
)
SELECT id, a * 10, b * 20 FROM table_1;