DROP TABLE IF EXISTS foo;
CREATE TEMP TABLE foo (date date, sale_amount numeric);
INSERT INTO foo VALUES ('2014-08-01', 11), ('2014-08-01', 120), ('2014-08-01', 80), ('2014-08-02', 14), ('2014-08-04', 180), ('2014-08-04', 70), ('2014-08-01', 18);
SELECT ROW_NUMBER() OVER(PARTITION BY date ORDER BY date), date, sale_amount FROM foo ORDER BY date;
--SELECT ROW_NUMBER() OVER(ORDER BY date), date, sale_amount FROM foo ORDER BY date;