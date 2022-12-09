use bank; 
-- Activity 1
-- 1. Get the number of clients by district, returning district name.
select * from client;

select A1, A2, count(client_id) as total_clients
from district l
left join client c on l.A1 = c.district_id
group by A1, A2;


-- 2. Are there districts with no clients? Move all clients from Strakonice to a new district with district_id = 100. Check again. Hint: 
-- 	  In case you have some doubts, you can check here how to use the update statement.
create temporary table if not exists new_table
select A1, A2, count(client_id) as total_clients
from district l
left join client c on l.A1 = c.district_id
group by A1, A2;

insert into new_table (A1, A2, total_clients)
values (100, 'Unknown', 43);

-- 3. How would you spot clients with wrong or missing district_id?
select * from client;
select * from district;
-- We can count the non-null entries from client_id and district_id columns; if they are the same number, there is going to be a missing district_id
select count(client_id) as client_count, count(district_id) as district_count
from client
where client_id is not null and district_id is not null;


-- 4. Return clients to Strakonice.
delete from new_table
where A1 = 100;

-- Activity 2
-- Identify relationship degrees in our database.

-- Activity 3
-- Look at the ER diagram and identify PK and FK.

-- Activity 4
-- 1. Make a list of all the clients together with region and district, ordered by region and district.
select * from account;
select * from district;

select A3, district_id, account_id
from account a
join district d on a.district_id = d.A1
order by A3, district_id;

-- 2. Count how many clients do we have per region and district.
select A3, district_id, count(account_id) as client_total
from (
	select A3, district_id, account_id
	from account a
	join district d on a.district_id = d.A1
	order by A3, district_id
) sub1
group by A3, district_id
order by A3, district_id;

-- 2.1 How many clients do we have per 10000 inhabitants?
select * from district;
select A2, A3, count(client_id)/10000 total from client c
left join district d on c.district_id = d.A1
group by A2, A3
order by total desc;



