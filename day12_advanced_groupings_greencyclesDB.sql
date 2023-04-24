-- DAY 12 ADVANCED GROUPINGS:

-- Challenge 1: GROUPING SETS
SELECT 
	first_name,
	last_name,
	staff_id,
	SUM(amount)
FROM customer c
LEFT JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY 
	GROUPING SETS (
		(first_name, last_name),
		(first_name, last_name, staff_id)
	)
ORDER BY 
	first_name, 
	last_name;

	
-- Challenge 2: GROUPING SETS
SELECT 
	first_name,
	last_name,
	staff_id,
	SUM(amount) AS total,
	ROUND((SUM(amount)/FIRST_VALUE (SUM(amount)) OVER 
	(PARTITION BY first_name, last_name ORDER BY SUM(amount) DESC))*100,2) as percentage
FROM customer c
LEFT JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY 
	GROUPING SETS (
		(first_name, last_name),
		(first_name, last_name, staff_id)
	)
ORDER BY 
	first_name, 
	last_name;

/* 
Challenge 4: GROUPING SETS - CUBE
Write a query that returns all grouping sets in all combinations of customer_id,
date and title with the aggregation of the payment amount.
*/

SELECT 
	p.customer_id,
	DATE(payment_date),
	title,
	SUM(amount)
FROM payment p
LEFT JOIN rental r
ON p.rental_id = r.rental_id
LEFT JOIN inventory i
ON r.inventory_id = i.inventory_id
LEFT JOIN film f
ON i.film_id = f.film_id
GROUP BY
	CUBE(1,2,3)
ORDER BY 1,2,3;

-- Challenge 5: SELF JOINS
SELECT 
	f1.title,
	f2.title,
	f2.length
FROM film f1
LEFT JOIN film f2
ON f1.length = f2.length
WHERE f1.title != f2.title
ORDER BY length DESC;