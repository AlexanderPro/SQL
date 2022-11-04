-- Before PG 9.6

--all info
select * from pg_stat_activity;

--connections count
select datname, count(*) as connections from pg_stat_activity group by datname;
select datname, count(*) as connections, state, waiting from pg_stat_activity group by datname, state, waiting order by datname;

--connections not idle (active)
select datname, count(*) as connections, state, waiting from pg_stat_activity where state <> 'idle' and query not like '%FROM pg_stat_activity%' group by datname, state, waiting order by datname;

--connections not idle (active) with time of longes query
select datname, count(*) as connections, state, waiting, max(age(clock_timestamp() as age, query_start)) from pg_stat_activity where state <> 'idle' and query not like '%FROM pg_stat_activity%' group by datname, state, waiting order by datname;

--connections not idle (active) with time of longes query and query type
select datname, count(*) as connections, state, waiting, max(age(clock_timestamp(), query_start)) as age, lower(left(query, position(' ' in query) - 1)) as query_type from pg_stat_activity where state <> 'idle' and query not like '%FROM pg_stat_activity%' group by datname, state, waiting, lower(left(query, position(' ' in query) - 1)) order by datname;

--active with query text
select pid, datname, state, waiting, age(clock_timestamp(), query_start), query from pg_stat_activity where state <> 'idle' and query not like '%FROM pg_stat_activity%';


-- After PG 9.6

--all info
select * from pg_stat_activity;
 
--connections count
select datname, count(*) as connections from pg_stat_activity group by datname;
select datname, count(*) as connections, state, wait_event, wait_event_type from pg_stat_activity group by datname, state, waiting order by datname;
 
--connections not idle (active)
select datname, count(*) as connections, state, wait_event, wait_event_type from pg_stat_activity where state 'idle' and query not like '%FROM pg_stat_activity%' group by datname, state, wait_event, wait_event_type order by datname;
 
--connections not idle (active) with time of longes query
select datname, count(*) as connections, state, wait_event, wait_event_type, max(age(clock_timestamp() as age, query_start)) from pg_stat_activity where state 'idle' and query not like '%FROM pg_stat_activity%' group by datname, state, wait_event, wait_event_type order by datname;
 
--connections not idle (active) with time of longes query and query type
select datname, count(*) as connections, state, wait_event, wait_event_type, max(age(clock_timestamp(), query_start)) as age, lower(left(query, position(' ' in query) - 1)) as query_type from pg_stat_activity where state 'idle' and query not like '%FROM pg_stat_activity%' group by datname, state, wait_event, wait_event_type , lower(left(query, position('' in query) - 1)) order by datname;
 
--active with query text
select pid, datname, state, wait_event, wait_event_type, ge(clock_timestamp(), query_start), query from pg_stat_activity where state 'idle' and query not like '%FROM pg_stat_activity%';