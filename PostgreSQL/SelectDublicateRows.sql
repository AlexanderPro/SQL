CREATE TEMP TABLE employees
(
    id bigint NOT NULL,
    name character varying(127) NOT NULL,
    age integer NOT NULL,
    salary numeric(16,2) NOT NULL
    --CONSTRAINT pk_employees PRIMARY KEY (id)
);

INSERT INTO employees (id, name, age, salary) VALUES (1, 'Alex', 25, 1500);
INSERT INTO employees (id, name, age, salary) VALUES (2, 'Anna', 28, 2000);
INSERT INTO employees (id, name, age, salary) VALUES (3, 'Helena', 40, 3800.55);
INSERT INTO employees (id, name, age, salary) VALUES (4, 'Max', 25, 3000);
INSERT INTO employees (id, name, age, salary) VALUES (1, 'Alex', 25, 1500);

SELECT * FROM employees WHERE ctid NOT IN (SELECT max(ctid) FROM employees GROUP BY id);

DROP TABLE employees;