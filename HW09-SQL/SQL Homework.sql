# Homework

# Select sakila db
USE sakila;

# 1a 
SELECT 
	first_name, 
    last_name
FROM actor;

# 1b    
SELECT concat(first_name, ' ', last_name) 
AS actor_name
FROM actor;
    
# 2a
SELECT
	actor_id,
    first_name,
    last_name
FROM actor
WHERE first_name = "Joe";

# 2b
SELECT
	actor_id,
	first_name,
    last_name
FROM actor
WHERE last_name LIKE "%GEN%";

# 2c
SELECT
	actor_id,
	first_name,
    last_name
FROM actor
WHERE last_name LIKE "%LI%"
ORDER BY
	last_name,
    first_name;

# 2d
SELECT
	country_id,
    country
FROM country
WHERE
	country IN ("Afghanistan", "Bangladesh", "China");
    
# 3a
ALTER TABLE actor
ADD description BLOB;

# 3b
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE actor
DROP description;
SET SQL_SAFE_UPDATES = 1;

# 4a
SELECT 
	last_name, 
    COUNT(last_name) AS last_name_count
FROM  actor
GROUP BY  last_name;

# 4b
SELECT
	last_name,
    COUNT(last_name) AS last_name_count
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) >= 2;

# 4c
SET SQL_SAFE_UPDATES = 0;
# Validating test
# SELECT * FROM actor where first_name = "GROUCHO" AND last_name = "WILLIAMS";
UPDATE actor
SET first_name = "HARPO"
WHERE first_name = "GROUCHO" AND last_name = "WILLIAMS";
SET SQL_SAFE_UPDATES = 1;

# 4d
#SELECT * FROM actor where first_name = "HARPO";
SET SQL_SAFE_UPDATES = 0;
UPDATE actor
SET first_name = "GROUCHO"
WHERE first_name = "HARPO";
SET SQL_SAFE_UPDATES = 1;

# 5a
SHOW CREATE TABLE address;
# Didn't run the below, too scared
CREATE TABLE `address` (
   `address_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
   `address` varchar(50) NOT NULL,
   `address2` varchar(50) DEFAULT NULL,
   `district` varchar(20) NOT NULL,
   `city_id` smallint(5) unsigned NOT NULL,
   `postal_code` varchar(10) DEFAULT NULL,
   `phone` varchar(20) NOT NULL,
   `location` geometry NOT NULL,
   `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`address_id`),
   KEY `idx_fk_city_id` (`city_id`),
   SPATIAL KEY `idx_location` (`location`),
   CONSTRAINT `fk_address_city` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON UPDATE CASCADE
 ) ENGINE=InnoDB AUTO_INCREMENT=606 DEFAULT CHARSET=utf8;
 
 # 6a
#SELECT * FROM staff;
SELECT
	staff.first_name,
	staff.last_name,
    address.address
FROM staff
INNER JOIN address ON 
	staff.address_id = address.address_id;
    
# 6b    
#SELECT * FROM payment;
SELECT
	staff.staff_id,
	staff.first_name,
    staff.last_name,
    SUM(payment.amount) AS total_amt
FROM staff
INNER JOIN payment ON 
	staff.staff_id = payment.staff_id
GROUP BY staff.staff_id;

# 6c
#SELECT * FROM film_actor;
#SELECT * FROM film;
SELECT
	film.film_id,
    film.title,
    COUNT(film_actor.actor_id) AS actor_count
FROM film
INNER JOIN film_actor ON 
		film_actor.film_id = film.film_id
GROUP BY film.film_id;

# 6d
#SELECT * FROM inventory;
#SELECT * FROM film;
SELECT
	film.film_id,
    film.title,
    COUNT(inventory.film_id) as copies
FROM film
INNER JOIN inventory ON
	film.film_id = inventory.film_id
WHERE film.title = "Hunchback Impossible";

# 6e
SELECT * FROM customer;
SELECT
	customer.customer_id,
    customer.first_name,
    customer.last_name,
    SUM(payment.amount) as total_paid
FROM customer
INNER JOIN payment ON
	customer.customer_id = payment.customer_id
GROUP BY customer.customer_id;

# 7a
#SELECT * FROM film;
SELECT sub.* 
FROM (
	SELECT title
    FROM film
    WHERE language_id = 1) sub
WHERE sub.title LIKE "K%" 
	OR sub.title LIKE "Q%";

# 7b
SELECT * FROM film WHERE title = "Alone Trip";
SELECT *
FROM actor
WHERE actor_id IN
(	SELECT actor_id
	FROM film_actor
    WHERE film_id = 17
    );     # Sad winky face 

# 7c
SELECT * FROM country; #Canada country_id = 20
SELECT 
	first_name,
    last_name,
    email
FROM customer cus
JOIN address a ON
	cus.address_id = a.address_id
JOIN city ON
	a.city_id = city.city_id
WHERE city.country_id = 20;
    
# 7d
SELECT * FROM category; #name Family = 8
SELECT
	f.film_id,
    f.title
FROM film f
JOIN film_category fc ON
	f.film_id = fc.film_id
WHERE fc.category_id = 8;

# 7e
SELECT * FROM film;
SELECT
	#r.inventory_id,
    i.film_id,
    f.title,
	count(r.inventory_id) as times_rented
FROM rental r
JOIN inventory i ON
	r.inventory_id = i.inventory_id
JOIN film f ON
	i.film_id = f.film_id
GROUP BY title
ORDER BY times_rented DESC;

# 7f 
SELECT * FROM customer;
SELECT 
	s.store_id,
    sum(p.amount) as total
FROM store s
JOIN customer c ON
	s.store_id = c.store_id
JOIN payment p ON
	c.customer_id = p.customer_id
GROUP BY s.store_id;

# 7g
SELECT * FROM city;
SELECT
	s.store_id,
    ci.city,
    co.country
FROM store s
JOIN address a ON
	s.address_id = a.address_id
JOIN city ci ON
	a.city_id = ci.city_id
JOIN country co ON
	ci.country_id = co.country_id;
    
# 7h
SELECT * FROM  payment;
SELECT
	c.name,
    sum(p.amount) AS total_gross
FROM category c
JOIN film_category f ON
	c.category_id = f.category_id
JOIN inventory i ON
	f.film_id = i.film_id
JOIN rental r ON
	i.inventory_id = r.inventory_id
JOIN payment p ON
	r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY total_gross DESC
LIMIT 5;

# 8a
CREATE VIEW top_five AS
SELECT
	c.name,
    sum(p.amount) AS total_gross
FROM category c
JOIN film_category f ON
	c.category_id = f.category_id
JOIN inventory i ON
	f.film_id = i.film_id
JOIN rental r ON
	i.inventory_id = r.inventory_id
JOIN payment p ON
	r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY total_gross DESC
LIMIT 5;

# 8b	
SELECT * FROM top_five;

# 8c
DROP VIEW top_five;