CREATE TEMP TABLE country (id, name) 
AS 
(VALUES 
  (1::INT, NULL::VARCHAR(50)),
  (2, 'Armenia'),
  (3, 'Australia'),
  (4, 'Austria'),
  (5, 'Brazil'),
  (6, 'Bulgaria'),
  (7, 'Iran'),
  (8, 'Iraq'),
  (9, 'Russian Federation')
);

--SELECT * FROM country WHERE name LIKE '%str%' OR name LIKE 'Ir%';
SELECT * FROM country WHERE name LIKE ANY (ARRAY['%str%', 'Ir%']);

DROP TABLE country;