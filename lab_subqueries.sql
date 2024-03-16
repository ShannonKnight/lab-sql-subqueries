-- Write SQL queries to perform the following tasks using the Sakila database:

USE sakila;

-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

-- SELECT film_id FROM film f
-- WHERE f.title = 'Hunchback Impossible';

SELECT COUNT(i.film_id) FROM inventory i
WHERE (
SELECT film_id FROM film f
WHERE f.title = 'Hunchback Impossible')
;

SELECT COUNT(i.film_id) FROM inventory i
WHERE film_id = '439'
;  

-- List all films whose length is longer than the average length of all the films in the Sakila database.

-- SELECT round(avg(f.length),0) AS avg_length FROM film f;

SELECT f.title FROM film f
WHERE f.length > (
SELECT round(avg(f.length),0) AS avg_length FROM film f
);
  
-- Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT f.film_id FROM film f
WHERE f.title = 'Alone Trip';

SELECT fa.actor_id FROM film_actor fa
WHERE fa.film_id = (
SELECT f.film_id FROM film f
WHERE f.title = 'Alone Trip'
);
    
SELECT CONCAT(a.first_name, ' ', a.last_name) AS actor_name
FROM actor a
WHERE a.actor_id IN 
(
    SELECT fa.actor_id
    FROM film_actor fa
    WHERE fa.film_id = 
    (
        SELECT f.film_id
        FROM film f
        WHERE f.title = 'Alone Trip'
    )
);

-- Bonus:

-- Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

select c.category_id from category c
where c.name = 'Family';

SELECT fc.film_id, f.title 
FROM film_category fc
LEFT JOIN film f ON fc.film_id = f.film_id
WHERE fc.category_id = (
    SELECT c.category_id 
    FROM category c 
    WHERE c.name = 'Family'
); 

-- Retrieve the name and email of customers from Canada using both subqueries and joins.
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.

SELECT c.country_id FROM country c
WHERE country = 'Canada'; 

 


-- Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. 
-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

-- Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, 
-- i.e., the customer who has made the largest sum of payments.

-- Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. 
-- You can use subqueries to accomplish this.