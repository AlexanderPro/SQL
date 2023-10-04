-- 1
-- https://dataedo.com/kb/query/postgresql/find-tables-without-relationships-loner-tables
-- Query below lists tables that are not referencing and are not referenced by other tables. We can call this type of tables a Loner Tables.

select distinct 
       'No FKs >-' as refs,
       tab.table_schema || '.' || tab.table_name as table,
       '>- no FKs' as foreign_keys
from information_schema.tables tab
left join(
          select distinct tco.table_schema,
                          tco.table_name
          from information_schema.referential_constraints rco
          join information_schema.table_constraints tco
               on rco.unique_constraint_name = tco.constraint_name
               and rco.unique_constraint_schema = tco.table_schema
          union all
          select distinct tco.table_schema,
                          tco.table_name
          from information_schema.referential_constraints rco
          join information_schema.table_constraints tco 
               on rco.constraint_name = tco.constraint_name
               and rco.constraint_schema = tco.table_schema
) rel on rel.table_name = tab.table_name
      and rel.table_schema = tab.table_schema
where tab.table_schema not in ('information_schema', 'pg_catalog') 
      and tab.table_type ='BASE TABLE'
      and rel.table_name is null
order by "table";


-- 2
-- https://dataedo.com/kb/query/postgresql/find-tables-that-are-not-referenced-by-the-foreign-keys
-- Query below lists tables which are not referenced by any foreign key.

select '>- no FKs' as foreign_keys,
       tab.table_schema,
       tab.table_name
       from information_schema.tables tab
where tab.table_schema not in ('information_schema', 'pg_catalog') 
      and tab.table_type ='BASE TABLE'
      and tab.table_schema || '.' || tab.table_name not in
          (select distinct tco.table_schema || '.' ||tco.table_name
           from information_schema.referential_constraints rco
           join information_schema.table_constraints tco 
                on rco.unique_constraint_name = tco.constraint_name
                and rco.unique_constraint_schema = tco.table_schema)
order by tab.table_schema,
         tab.table_name;


-- 3
-- https://dataedo.com/kb/query/postgresql/tables-without-foreign-keys
-- Query below returns all tables without foreign keys.

select tab.table_schema,
       tab.table_name,
       '>- no FKs' as foreign_keys
       from information_schema.tables tab
where tab.table_schema not in ('information_schema', 'pg_catalog') 
      and tab.table_type ='BASE TABLE'
      and tab.table_schema || '.' || tab.table_name not in
          (select distinct table_schema || '.' || table_name
           from information_schema.table_constraints
           where constraint_type = 'FOREIGN KEY')
order by tab.table_schema,
         tab.table_name;