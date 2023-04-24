-- DAY 11 WINDOW FUNCTIONS:

-- Challenge 1: OVER() with PARTITION BY
SELECT 
	f.film_id,
	title, 
	length,
	name AS category,
	ROUND(AVG(length) OVER (PARTITION BY name),2) AS avg_for_category
FROM film f
LEFT JOIN film_category fc
ON f.film_id = fc.film_id
LEFT JOIN category c
ON fc.category_id = c.category_id
ORDER BY film_id;

-- Challenge 2: OVER() with PARTITION BY
SELECT 
	*,
	COUNT(*) OVER (PARTITION BY customer_id, amount)
FROM payment
ORDER BY customer_id ASC;

-- Challenge 4: RANK()
-- no "where" filtering with window functions - filtering with subquery
SELECT * FROM 
	(SELECT 
		name,
		country,
		COUNT(*) AS payments_number,
		RANK() OVER(PARTITION BY country ORDER BY COUNT(*) DESC) AS rank
	FROM customer_list cl
	LEFT JOIN payment p
	ON cl.id = p.customer_id
	GROUP BY name, country) AS helper_subquery
WHERE rank < 4;

-- Challenge 5: LEAD & LAG
SELECT 
	SUM(amount) AS current,
	DATE(payment_date),
	LAG(SUM(amount)) OVER(ORDER BY DATE(payment_date) ASC) AS  prev_day,
	SUM(amount) - LAG(SUM(amount)) OVER(ORDER BY DATE(payment_date) ASC) AS difference_from_prev,
	ROUND(100*(SUM(amount) - LAG(SUM(amount)) OVER(ORDER BY DATE(payment_date) ASC))/LAG(SUM(amount)) OVER(ORDER BY DATE(payment_date) ASC),2)
FROM payment 
GROUP BY DATE(payment_date);
