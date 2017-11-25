DROP TABLE IF EXISTS foo;
CREATE TEMP TABLE foo (date date, sale_amount numeric);
INSERT INTO foo VALUES ('2014-08-01', 11), ('2014-08-01', 120), ('2014-08-01', 80), ('2014-08-02', 14), ('2014-08-04', 180), ('2014-08-04', 70), ('2014-08-01', 18);
SELECT date, sale_amount, SUM(sale_amount) OVER(PARTITION BY date) as sales_total_day, AVG(sale_amount) OVER(PARTITION BY date) as sales_avg_day FROM foo ORDER BY date;
--SELECT date, sale_amount, SUM(sale_amount) OVER() as sales_total, AVG(sale_amount) OVER() as sales_avg FROM foo ORDER BY date;