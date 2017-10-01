SELECT name, age, salary 
FROM (VALUES ('Alex', 25, 1500), ('Anna', 28, 2000), ('Helena', 40, 3800.55)) AS employee(name, age, salary)
WHERE (age, salary) > (27, 1600)