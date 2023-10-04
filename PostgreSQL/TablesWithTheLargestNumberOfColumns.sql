 -- https://dataedo.com/kb/query/postgresql/list-of-tables-with-the-most-columns

select tab.table_schema,
       tab.table_name,
       count(*) as columns
from information_schema.tables tab
inner join information_schema.columns col
           on tab.table_schema = col.table_schema
           and tab.table_name = col.table_name
where tab.table_schema not in ('information_schema', 'pg_catalog')
      and tab.table_type = 'BASE TABLE'
group by tab.table_schema, tab.table_name
order by count(*) desc;