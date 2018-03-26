--select unnest(array[1,2,3]) as "id";
select unnest(array[100, 110, 153, 100500]) as "id", '2015-01-01' as "date", 3 as "value";