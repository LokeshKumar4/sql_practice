-- ======================= *** Sakila Database Query *** ================================================

use sakila;

-- How many actors have the same first names and last names? List all these actors.

select  concat(first_name," ",last_name) as full_name from actor group by full_name  order by full_name;

-- How many actors have unique names? What is the count of these actors in the database table?
select distinct concat(first_name," ",last_name) as full_name from actor order by full_name;

-- Provide the list of the actors whose names are repeated and the list of those whose names are not repeated.
select concat(first_name," ",last_name) as full_name from actor group by full_name having count(full_name)>1 order by full_name;

-- Find the actors playing identity roles, such as action, Romance, Horror, mystery. Provide the detailed overview of films based 
-- on actors preferences, (output should be like:actor name Action |15)

select a.actor_id,a.first_name,a.last_name,fc.category_id,c.name
from actor a
join film_actor fa on a.actor_id=fa.actor_id
join film f on fa.film_id=f.film_id 
join film_category fc on f.film_id=fc.film_id
join category c on fc.category_id=c.category_id
group by a.actor_id,c.category_id
having count(c.name)>=1
order by a.actor_id;

with cte as(
select concat(first_name,' ',last_name) as actor_name,
name,count(name) as cnt,rank() over(partition by actor.actor_id order by count(name) desc) as r
from actor 
inner join film_actor using(actor_id)
inner join film using(film_id)
inner join film_category using(film_id)
inner join category using(category_id)
group by actor.actor_id,1,2)
select actor_name,name,cnt from cte where r=2;

-- Analyze the trend for movies based on their categories and determine which movie category has a majority count.
select f.film_id,f.title,f.release_year,f.rating  
from film f
group by ;


-- Determine which movies are suitable for kids, which movies are restricted for all under 16 unless accompanied by a parent and 
-- which movies are restricted for all audiences under 18.


-- Figure out the movie titles where the replacement cost is up to $9.
select f.film_id,f.title,f.replacement_cost
from film f
where f.replacement_cost<9;  

-- Get the movie titles where the replacement cost is between $15 and $20.
select f.film_id,f.title,f.replacement_cost
from film f
where f.replacement_cost between 15 and 20
order by f.replacement_cost;  

-- Find the movies with the highest replacement cost but the lowest rental cost.
select film_id ,replacement_cost,rental_rate from film
where replacement_cost=(select max(replacement_cost) from film) and rental_rate=(select min(rental_rate) from film)
order by replacement_cost desc, rental_rate ;

-- Provide the list all the films along with the number of actors listed for each film.
select f.film_id,f.title,count(fa.actor_id) from film f
join film_actor fa on f.film_id=fa.film_id
group by f.film_id;


-- Display the titles of the movies starting with the letters 'K' and 'Q'.
select * from film where title like 'K%' or title like 'Q%';

-- The film ' AGENT TRUMAN' has been a great success, Display all the actos who appeared in this film.
select f.film_id, f.title ,fa.actor_id ,concat(a.first_name," ",a.last_name)as full_name from film f
join film_actor fa on f.film_id=fa.film_id
join actor a on fa.actor_id=a.actor_id
 where title = 'AGENT TRUMAN';


-- Identify all the movies categorized as family films .
select f.film_id,f.title ,c.name
from film f 
join film_category fc on f.film_id=fc.film_id
join category c on fc.category_id=c.category_id
where c.name ='Family';

-- Display the most frequently rented movies in descending order to maintain more copies of those movies
select f.film_id,f.title ,i.inventory_id,max(i.last_update) from film f 
join inventory i on f.film_id=i.film_id;



-- In how many film categories, the average difference between the film replacement cost and the rental rate is greater than $15.

select a.category_id, avg(b.replacement_cost - b.rental_rate) average_difference
from film_category a
inner join film b
on a.film_id=b.film_id
group by a.category_id 
having dif> 15;


-- Identify the genres having 60-70 films. List the names of these categories and the number of films per category, Sorted by number of films

select f.title,count(fa.actor_id) from film f 
join film_actor fa on f.film_id=fa.film_id 
group by f.title ;

-- create a stored procedure to provide the number of actors based on film
create procedure film_actor_count(t varchar(30))
select f.title,count(fa.actor_id) from film f 
join film_actor fa on f.film_id=fa.film_id 
where f.title=t
group by f.title ;

call film_actor_count('ACADEMY DINOSAUR');


use hr;

delimiter //
create procedure sal5000()
begin
select first_name,salary+500 from employees;
end;
delimiter ;

call sal5000();