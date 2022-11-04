CREATE TEMP TABLE Geo 
(
    id INT NOT NULL PRIMARY KEY, 
    parent_id INT REFERENCES geo(id), 
    name VARCHAR(1000)
);

INSERT INTO Geo (id, parent_id, name) VALUES (1, NULL, 'Earth');
INSERT INTO Geo (id, parent_id, name) VALUES (2, 1, 'North America');
INSERT INTO Geo (id, parent_id, name) VALUES (3, 1, 'Eurasia');
INSERT INTO Geo (id, parent_id, name) VALUES (4, 3, 'Europa');
INSERT INTO Geo (id, parent_id, name) VALUES (5, 4, 'Russia');
INSERT INTO Geo (id, parent_id, name) VALUES (6, 4, 'Germany');
INSERT INTO Geo (id, parent_id, name) VALUES (7, 5, 'Moscow');
INSERT INTO Geo (id, parent_id, name) VALUES (8, 5, 'St. Petersburg');
INSERT INTO Geo (id, parent_id, name) VALUES (9, 6, 'Berlin');
INSERT INTO Geo (id, parent_id, name) VALUES (10, 6, 'Bavaria');

WITH RECURSIVE r AS
(
    SELECT id, parent_id, name
    FROM geo
    WHERE id = 5

    UNION

    SELECT Geo.id, Geo.parent_id, Geo.name
    FROM Geo JOIN r ON Geo.parent_id = r.id
)

SELECT * FROM r;

DROP TABLE Geo;