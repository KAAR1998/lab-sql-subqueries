USE sakila; 
SHOW FULL TABLES;

-- How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT * FROM inventory
WHERE film_id = 
(SELECT film_id FROM film WHERE title = 'Hunchback Impossible');

-- List all films whose length is longer than the average of all the films.
SELECT * FROM film
WHERE length > (SELECT avg(length)
FROM film)
ORDER BY length DESC;

-- Use subqueries to display all actors who appear in the film Alone Trip.
SELECT * FROM actor as a
WHERE a.actor_id IN(
SELECT fa.actor_id 
FROM film_actor as fa
WHERE film_id = 17);

-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT * from film; 
SELECT * from film_category;
SELECT * from category;

SELECT * FROM film as f 
WHERE f.film_id IN(
SELECT f_c.film_id 
FROM film_category as f_c 
WHERE f_c.category_id IN(
SELECT c.category_id 
FROM category as c 
WHERE c.category_id = 8));

-- Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
SELECT * FROM customer; 
SELECT * FROM address; 
SELECT * FROM city; 
SELECT * FROM country;

DROP VIEW sakila.customer_countries;

CREATE VIEW sakila.customer_countries AS ( 
SELECT c.first_name, c.last_name, c.email, a.address_id, ci.city_id, co.country_id, co.country 
FROM customer as c 
JOIN address as a 
ON c.address_id = a.address_id
JOIN city as ci
ON a.city_id = ci.city_id 
JOIN country as co 
ON ci.country_id = co.country_id
);

SELECT * FROM sakila.customer_countries
WHERE country_id = 20;

-- Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

SELECT actor_id, COUNT(actor_id) AS num_of_films 
FROM film_actor 
GROUP BY actor_id
ORDER BY num_of_films DESC;

CREATE VIEW sakila.films_by_actor AS (
SELECT fa.actor_id, a.first_name, a.last_name, f.film_id, f.title, f.release_year, f.rating
FROM film_actor as fa
JOIN film as f 
ON fa.film_id = f.film_id 
JOIN actor as a 
ON fa.actor_id = a.actor_id
); 

SELECT * FROM sakila.films_by_actor
WHERE actor_id = 107
ORDER BY film_id ASC;

-- Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments
SELECT * FROM customer;
SELECT * FROM payment;
SELECT * FROM rental;
SELECT * FROM inventory;

SELECT customer_id, COUNT(payment_id) AS num_of_payments, SUM(amount) as sum_of_payments, AVG(SUM(amount)) AS average_payment
FROM payment
GROUP BY customer_id
ORDER BY sum_of_payments DESC;

CREATE VIEW sakila.films_by_customer AS (
SELECT f.film_id, f.title, i.inventory_id, r.rental_id, p.customer_id
FROM film as f 
JOIN inventory AS i
ON f.film_id = i.film_id 
JOIN rental AS r 
ON i.inventory_id = r.inventory_id 
JOIN payment as p 
ON r.rental_id = p.rental_id 
); 

SELECT * FROM sakila.films_by_customer
WHERE customer_id = 526;

-- Customers who spent more than the average payments.
SELECT SUM(amount) as sum_of_payments, AVG(SUM(amount)) as avg_of_payments
FROM sakila.payment
GROUP BY customer_id
ORDER BY average_payment DESC;

SELECT customer_id, COUNT(payment_id) AS num_of_payments, SUM(amount) as sum_of_payments
FROM sakila.payment
 AVG(SUM(amount)) as average_payment
GROUP BY customer_id
ORDER BY sum_of_payments DESC;



