use sakila;
-- 1. 
-- Drop column picture from staff.
-- drop column
alter table sakila.staff
drop column picture;

-- 2. 
-- A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
 select * from sakila.staff;
 insert into sakila.staff values
(3,'Tammy','Sanders',4,'Tammy.Sanders@sakila.staff.com',2,1,'Tammy', " ", now());
 
-- 3. 
-- Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
-- You can use current date for the rental_date column in the rental table. 
-- Hint: Check the columns in the table rental and see what information you would need to add there. 
-- You can query those pieces of information. For eg., you would notice that you need customer_id information as well. 
-- To get that you can use the following query:
select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
-- Use similar method to get inventory_id, film_id, and staff_id.

-- finding film_id from the movie "Academy Dinosaur"
select title, film_id from sakila.film
where title = 'Academy Dinosaur';

-- finding staff_id from the employee 'Mike Hillyer'
select * from sakila.staff; -- or
select staff_id from sakila.staff
where first_name = 'Mike' and last_name = 'Hillyer';

-- get inventory_id
select * from sakila.inventory
where film_id=1 and store_id=1; 

select * from sakila.rental;
select count(rental_id) from sakila.rental;
-- Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
insert into sakila.rental values
(16045,now(),'', 130 ,' ',1,now());
 

-- 4.
/*Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. 
Follow these steps:
Check if there are any non-active users
Create a table backup table as suggested
Insert the non active users in the table backup table
Delete the non active users from the table customer*/

-- Check if there are any non-active users
select distinct(active) from sakila.customer; -- I suppose that active users are the people with 1 and not with 0 
select * from sakila.customer
where active=0;  -- finding the non active users

-- Create a table backup table as suggested
CREATE TABLE suggested (
customer_id int DEFAULT NULL,
store_id int DEFAULT NULL,
first_name text,
last_name text,
email text, 
address_id int DEFAULT NULL, 
active int DEFAULT NULL,
create_date text,
last_update text);

-- Insert the non active users in the table backup table

insert into suggested -- (customer_id,store_id,first_name,last_name,email,address_id,active,create_date,last_update)
select customer_id,store_id,first_name,last_name,email,address_id,active,create_date,last_update from sakila.customer
where active=0;

select * from sakila.suggested;

-- Delete the non active users from the table customer
delete from sakila.customer 
where active=0;

