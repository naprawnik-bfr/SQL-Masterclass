-- DAY 4 FUNCTIONS:

-- Challenge 1: LENGTH, LOWER & UPPER
SELECT 
	LOWER(first_name) f_name,
	LOWER(last_name) l_name
FROM customer
WHERE LENGTH(first_name) > 10 OR LENGTH(last_name) > 10
ORDER BY customer_id;

-- Challenge 2: LEFT & RIGHT
SELECT 
	RIGHT(email,4)
FROM customer;

SELECT 
	LEFT(RIGHT(email,4),1)
FROM customer;

-- Challenge 3: CONCATENATE
SELECT 
	LEFT(first_name, 1) || '***' || RIGHT(email, LENGTH(email) - POSITION('@' IN email) +1)
FROM customer;

-- Challenge 4: POSITION
SELECT 
	LEFT(email, POSITION('.' IN email) -1) || ', ' || last_name
FROM customer
ORDER BY customer_id;

-- Challenge 5: SUBSTRING
SELECT
	LEFT(first_name, 1) 
	|| '***' 
	|| SUBSTRING (email from POSITION('.' IN email) for 2) 
	||'***' 
	|| SUBSTRING (email from POSITION('@' IN email))
FROM customer
ORDER BY customer_id;

SELECT
	'***' 
	|| SUBSTRING (email from POSITION('.' IN email) -1 for 3) 
	||'***' 
	|| SUBSTRING (email from POSITION('@' IN email))
FROM customer
ORDER BY customer_id;

-- Challenge 6: EXTRACT
SELECT 
	SUM(amount) total_amount,
	EXTRACT(MONTH from payment_date) AS month
FROM payment
GROUP BY month
ORDER BY total_amount DESC;

SELECT 
	SUM(amount) total_amount,
	EXTRACT(DOW from payment_date) AS day_of_a_week
FROM payment
GROUP BY day_of_a_week
ORDER BY total_amount DESC;

SELECT 
	SUM(amount) total_amount,
	customer_id,
	EXTRACT(WEEK from payment_date) AS week
FROM payment
GROUP BY week , customer_id
ORDER BY total_amount DESC;
	
-- Challenge 7: TO_CHAR
SELECT 
	SUM(amount) AS total_amount,
	TO_CHAR(payment_date, 'Dy, DD/MM/YYYY') AS date_to_char
FROM payment
GROUP BY date_to_char
ORDER BY total_amount DESC;
		
SELECT 
	SUM(amount) AS total_amount,
	TO_CHAR(payment_date, 'Mon, YYYY') AS date_to_char
FROM payment
GROUP BY date_to_char
ORDER BY total_amount DESC;	

SELECT 
	SUM(amount) AS total_amount,
	TO_CHAR(payment_date, 'Dy, HH24:MI') AS date_to_char
FROM payment
GROUP BY date_to_char
ORDER BY total_amount DESC;	
	
-- Challenge 8: INTERVALS
SELECT 
	return_date - rental_date AS rental_duration
FROM rental
WHERE customer_id = 35;

SELECT 
	AVG(return_date - rental_date) AS avg_rental_duration,
	customer_id
FROM rental
GROUP BY customer_id
ORDER BY avg_rental_duration DESC;
	
	
	
	
	
	
	
	
	
	
	
	
	

