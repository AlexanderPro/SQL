COPY 
( 
  SELECT * FROM pg_stat_activity 
) TO 'C:/TEMP/my_proc_tst.csv' --TO STDOUT
WITH CSV HEADER