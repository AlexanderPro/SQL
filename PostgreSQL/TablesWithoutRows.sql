 -- https://dataedo.com/kb/query/postgresql/find-empty-tables-in-database

select n.nspname as table_schema,
       c.relname as table_name
from pg_class c
join pg_namespace n on n.oid = c.relnamespace
where c.relkind = 'r'
      and n.nspname not in ('information_schema','pg_catalog')
      and c.reltuples = 0
order by table_schema,
         table_name;