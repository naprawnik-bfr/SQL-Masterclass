-- DAY 3 GROUPING:

-- Challenge 1: GROUP BY
SELECT
	MIN(replacement_cost),
	MAX(replacement_cost),
	ROUND(AVG(replacement_cost),2) AS avg,
	SUM(replacement_cost)
FROM film;

-- Challenge 2: GROUP BY
SELECT 
	staff_id,
	SUM(amount),
	COUNT(*)
FROM payment
GROUP BY staff_id;

SELECT 
	staff_id,
	SUM(amount),
	COUNT(*)
FROM payment
WHERE amount != 0
GROUP BY staff_id;

-- Challenge 3: GROUP BY - multiple columns
SELECT 
	staff_id,
	DATE(payment_date),
	SUM(amount) sum_in_one_day,
	COUNT(*) sales_in_one_day
FROM payment
WHERE amount != 0
GROUP BY staff_id, DATE(payment_date)
ORDER BY sales_in_one_day DESC;

-- Challenge 4: HAVING
SELECT 
	customer_id,
	DATE(payment_date),
	ROUND(AVG(amount),2) AS avg_amount,
	COUNT(*)
FROM payment
WHERE DATE(payment_date) BETWEEN '2020-04-28' AND '2020-05-01'
GROUP BY customer_id, DATE(payment_date)
HAVING COUNT(*) > 1
ORDER BY ROUND(AVG(amount),2) DESC;

