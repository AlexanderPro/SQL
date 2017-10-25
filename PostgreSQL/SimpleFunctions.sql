SELECT GREATEST(2, 1, 5, 7, 4, NULL),
       LEAST(2, 1, 5, 7, 4, NULL),
       NULLIF(1, 1),
       COALESCE(NULL, NULL, 1, 2, 3, NULL, 4, 5),
       CAST ('365' AS INT), 
       '365'::INT