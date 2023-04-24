-- DAY 7 SUBQUERIES:

-- Challenge 1: SUBQUERIES in WHERE
SELECT 
	film_id,
	title
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY title ASC;

-- Challenge 2: SUBQUERIES in WHERE
SELECT 
	first_name,
	last_name
FROM customer c
WHERE customer_id IN (	SELECT customer_id 
					  	FROM payment
					  	WHERE DATE(payment_date) = '2020-01-25'
					 )
ORDER BY c.customer_id;

--MY ALTERNATIVE:
SELECT DISTINCT ON (c.customer_id)
	first_name,
	last_name
FROM customer c 
LEFT JOIN payment p 
ON c.customer_id = p.customer_id
WHERE DATE(payment_date) = '2020-01-25'
ORDER BY c.customer_id;

-- Challenge 3: SUBQUERIES in WHERE
SELECT 
	first_name,
	email
FROM customer
WHERE customer_id IN (SELECT customer_id
					 FROM payment 
					 GROUP BY customer_id
					 HAVING SUM(amount) > 30)
ORDER BY customer_id;
					 
-- Challenge 4: SUBQUERIES in WHERE
SELECT 
	first_name,
	last_name
FROM customer
WHERE 	customer_id IN (SELECT customer_id
						FROM payment
						GROUP BY customer_id
					 	HAVING SUM(amount) > 100)
		AND customer_id IN (SELECT customer_id
						FROM customer c
						LEFT JOIN address a
						ON c.address_id = a.address_id
						WHERE district = 'California')
ORDER BY customer_id;

-- Challenge 5: SUBQUERIES in FROM
SELECT 
	ROUND(AVG(amount_per_day),2) daily_avg
FROM (
SELECT
	DATE(payment_date),
	SUM(amount) AS amount_per_day
FROM payment
GROUP BY DATE(payment_date)
) AS helper;

-- Challenge 6: SUBQUERIES in SELECT
SELECT 
	payment_id,
	amount,
	(SELECT MAX(amount) FROM payment) - amount AS difference
FROM payment;

-- Challenge 7: CORRELATED SUBQUERIES in WHERE
SELECT 
	film_id,
	title,
	replacement_cost,
	rating
FROM film f1
WHERE 	replacement_cost = 	(SELECT MIN(replacement_cost) 
	   						FROM film f2
	 						WHERE f1.rating = f2.rating);
	
SELECT
	MIN(replacement_cost),
	rating
FROM film
GROUP BY rating;

-- Challenge 8: CORRELATED SUBQUERIES - ADDITIONAL
SELECT 
	payment_id,
	customer_id,
	staff_id,
	amount,
	(SELECT SUM(amount) AS sum_amount
	FROM payment p2
	WHERE p1.customer_id = p2.customer_id),
	(SELECT COUNT(*) AS count_payments
	FROM payment p2
	WHERE p1.customer_id = p2.customer_id)
FROM payment p1
ORDER BY customer_id, amount DESC;

-- Challenge 9: CORRELATED SUBQUERIES - ADDITIONAL
SELECT 
	first_name,
	MAX(amount)	 
FROM payment p
LEFT JOIN customer c
ON p.customer_id = c.customer_id
GROUP BY first_name;

SELECT 
	first_name,
	amount,
	payment_id
FROM payment p1
LEFT JOIN customer c
ON p1.customer_id = c.customer_id
WHERE amount = (SELECT MAX(amount) FROM payment p2
			   WHERE p1.customer_id = p2.customer_id)
ORDER BY c.customer_id;
							
