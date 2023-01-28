
use sakila;

-- 1. Write a query to display for each store its store ID, city, and country.
use sakila;
select * from sakila.address;
select * from sakila.customer;
select * from store;

select s.store_id, (ci.city), country
from store s join customer c on 
s.store_id = c.store_id
join address a on 
s.address_id = a.address_id
join city ci on
a.city_id = ci.city_id
join country coun on 
ci.country_id = coun.country_id;


-- 2. Write a query to display how much business, in dollars, each store brought in.
select s.store_id, sum(p.amount) as 'Total_business_Amount' from store s
join staff st on 
s.store_id = st.store_id
join payment p on 
st.staff_id = p.staff_id
group by s.store_id
order by sum(amount);


-- 3. Which film categories are longest?

SELECT c.name, COUNT(fc.category_id) AS `Films_per_Category`
FROM film_category fc JOIN category c
ON fc.category_id = c .category_id
GROUP BY fc.category_id
HAVING `Films_per_Category` 
ORDER BY `Films_per_Category` DESC limit 1;



-- 4. Display the most frequently rented movies in descending order.

select i.film_id, f.title, count(r.inventory_id) as 'no._times_rented'
from inventory i
join rental r
on i.inventory_id = r.inventory_id
join film_text f 
on i.film_id = f.film_id
group by r.inventory_id
order by count(r.inventory_id) desc;


-- 5. List the top five genres in gross revenue in descending order.
select c.name, sum(p.amount) as 'gross_revenue'
from category c
left join film_category fc
on c.category_id = fc.category_id
join inventory i
on fc.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
join payment p
on r.rental_id = p.rental_id
group by c.name 
order by sum(p.amount) limit 5;



-- 6. Is "Academy Dinosaur" available for rent from Store 1?
select * from sakila.store;
select * from sakila.film;
select * from sakila.inventory;

select  f.title as 'film title', count(s.store_id) as 'available in store' from sakila.film f
left join sakila.inventory i on
f.film_id = i.film_id
left join sakila.store s on
i.store_id = s.store_id
left join rental r on 
i.inventory_id = r.inventory_id
group by f.title
having title = "Academy Dinosaur";

-- 7. Get all pairs of actors that worked together.
-- film_actor, actor, film

select f.film_id, fa1.actor_id, fa2.actor_id, concat(a1.first_name," ", a1.last_name) as 'actor', concat(a2.first_name," ", a2.last_name) as'worked with'
from film f
    inner join film_actor fa1
    on f.film_id=fa1.film_id
    
    inner join actor a1
    on fa1.actor_id=a1.actor_id
    
    inner join film_actor fa2
    on f.film_id=fa2.film_id
    
    inner join actor a2
    on fa2.actor_id=a2.actor_id  ; 
-- where f.film_id in (234, 85, 54);

-- 8. Get all pairs of customers that have rented the same film more than 3 times.
select c.customer_id, c.customer_id, r.rental_id -- fa2.actor_id, concat(a1.first_name," ", a1.last_name) as 'actor', concat(a2.first_name," ", a2.last_name) as'worked with'
from customer c
    inner join rental r
    on c.customer_id = r.customer_id   
    
    inner join rental r2
    on f.film_id=r2.film_id;
    
    


-- 9. For each film, list actor that has acted in more films.
select 
f.title as 'Film Title', count(fa.actor_id) as 'Number of actors'
from sakila.film_actor fa 
join sakila.film f on 
fa.film_id = f.film_id
group by  f.title;
