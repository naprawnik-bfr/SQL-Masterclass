-- DAY 1 BASICS:

-- Challenge 1: SELECT
SELECT 
	first_name,
	last_name,
	email
FROM customer;

-- Challenge 2: ORDER BY
SELECT 
*
FROM customer
ORDER BY last_name DESC, first_name DESC;

-- Challenge 3: SELECT DISTINCT
SELECT DISTINCT
	amount
FROM payment
ORDER BY amount DESC;

-- Challenge 4: ADDITIONAL: DISTINCT
SELECT DISTINCT
	district
FROM address;

-- Challenge 5: ADDITIONAL: ORDER AND LIMIT
SELECT DISTINCT
	rental_date
FROM rental
ORDER BY rental_date DESC
LIMIT 1;

-- Challenge 6: ADDITIONAL: FILM
SELECT 
	COUNT(*)
FROM film;

-- Challenge 7: ADDITIONAL COUNT(DISTINCT)
SELECT 
	COUNT(DISTINCT(last_name))
FROM customer;

