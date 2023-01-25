USE sakila; 
SHOW FULL TABLES;

-- Drop column picture from staff.
ALTER TABLE staff
DROP COLUMN picture;

SELECT * FROM staff;
SELECT * FROM address;

SELECT * FROM address;

-- A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
SELECT * FROM customer
WHERE first_name = "TAMMY" AND last_name = "SANDERS";

INSERT INTO staff(staff_id, first_name, last_name, address_id, email,  store_id, active, username, password, last_update)
VALUES(3, 'Tammy', 'Sanders', 79, "tammy@mama.com", 2, 1, 'Tammy', "1234", "2015-12-13 22:22:22");

-- Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. H
SELECT * FROM rental;
SELECT * FROM customer
WHERE first_name = "CHARLOTTE" AND last_name = "HUNTER";
SELECT * FROM film
WHERE title = "ACADEMY DINOSAUR";
SELECT * FROM inventory
WHERE film_id = 1;

INSERT INTO rental(rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES ("1000100", "2023-01-25 12:02:00", 1, 130, "2023-02-02 12:02:00", 1, "2023-01-25 12:00:00");


