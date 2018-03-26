--1
SELECT t1.* 
FROM table1 t1
    LEFT JOIN table2 t2
        ON t1.field1 = t2.field1 
            AND t1.field2 = t2.field2
            AND t1.field3 = t2.field3
WHERE 
    t2.field1 IS NULL;


--2
SELECT table1.* 
    FROM table1 
        LEFT JOIN table2
            ON table1 = table2
WHERE 
    table2 Is NULL;


--3
SELECT * 
FROM table1 
WHERE NOT EXISTS (
    SELECT * 
    FROM table2 
    WHERE
        table2 = table1
);