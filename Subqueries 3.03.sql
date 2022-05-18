-- In this lab, you will be using the Sakila database of movie rentals. 
-- Create appropriate joins wherever necessary.

use sinventoryakila;
-- FROM
-- ON
-- JOIN
-- WHERE
-- GROUP BY
-- HAVING
-- SELECT
-- DISTINCT
-- ORDER BY
-- LIMIT

-- Instructions
-- 1How many copies of the film Hunchback Impossible exist in the inventory system?
select film_id from sakila.film where title = 'Hunchback Impossible';

select count(*) as copies from inventory where film_id = (
	select film_id from sakila.film where title = 'Hunchback Impossible'
);

-- 2List all films whose length is longer than the average of all the films.
-- select avg(length) from sakila.film; 
-- select* from sakila.film where length> AVERAGE
select title, length 
from sakila.film 
where length > (select avg(length) from sakila.film)
order by length desc;

-- 3Use subqueries to display all actors who appear in the film Alone Trip.
select * from actor;
select first_name, last_name from actor 
where actor_id in (
	Select actor_id from sakila.film_actor where film_id = (select film_id from sakila.film where title = 'Alone Trip')
	);
 


-- 4Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
-- Identify all movies categorized as family films.
select title from sakila.film where rating = 'G';


select title from film 
where film_id in 
	(select film_id from film_category
    where category_id =
		(select category_id from category
        where name = 'family'));

-- 5Get name and email from customers from Canada using subqueries.

select last_name, email from sakila.customer 
where address_id IN ( 
select address_id from sakila.address
where city_id IN (
select city_id from sakila.city 
where country_id = (select country_id from (
                           select country_id from sakila.country where country = 'Canada') as sub1
                    where country_id IS NOT NULL)));


-- 5Do the same with joins. Note that to create a join, 
-- you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
SELECT 
	cu.last_name,
    cu.email as 'customers from Canada'
FROM 
	country as co
JOIN 
	city as ci
  ON 
	co.country_id = ci.country_id  
JOIN 
	address AS ad
ON 
		ci.city_id = ad.city_id
JOIN 
	customer AS cu
ON 
	ad.address_id = cu.address_id
GROUP BY co.country = 'Canada'; 

-- 6Which are films starred by the most prolific actor? 
-- Most prolific actor is defined as the actor that has acted in the most number of films. 
-- First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
(SELECT 
	fa.actor_id,
    concat(a.first_name,a.last_name) AS 'actor name',
    Count(film_id) as "number of appearances"
FROM
	film_actor as fa
JOIN 
	actor as a
ON 
	fa.actor_id = a.actor_id    
GROUP BY
	 fa.actor_id
ORDER BY
	"number of appearances" DESC
    LIMIT 1)

-- 7Films rented by most profitable customer. 
-- You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments



-- 8Customers who spent more than the average payments.



