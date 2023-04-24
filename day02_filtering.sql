-- DAY 2 FILTERING:

-- Challenge 1: WHERE
SELECT 
	COUNT(*)
FROM payment
WHERE customer_id = 100;

-- Challenge 2: WHERE
SELECT 
	last_name
FROM customer
WHERE first_name = 'ERICA';
		 
-- Challenge 3: WHERE operators
SELECT 
	COUNT(*)
FROM rental
WHERE return_date IS NULL;

-- Challenge 4: WHERE operators
SELECT 
	payment_id,
	amount
FROM payment
WHERE amount <= 2;

-- Challenge 5: WHERE with AND/OR
SELECT 
*
FROM payment
WHERE 	(customer_id IN(322,346,354))
		AND (amount < 2 OR amount >10)
ORDER BY 	customer_id ASC,
			amount DESC;
			
-- Challenge 6: BETWEEN
SELECT 
	COUNT(*)
FROM payment
WHERE 	(payment_date BETWEEN '2020-01-26' AND '2020-01-28')
		AND (amount BETWEEN 1.99 AND 3.99);
		
-- Challenge 7: IN
SELECT 
*
FROM payment
WHERE 	(customer_id IN(12,25,67,93,124,234))
		AND (amount IN(4.99, 7.99, 9.99))
		AND (payment_date BETWEEN '2020-01-01' AND '2020-02-01');
		
-- Challenge 7: LIKE
SELECT
	COUNT(*)
FROM film
WHERE description LIKE '%Documentary%';

-- Challenge 8: LIKE
SELECT
	COUNT(*)
FROM customer
WHERE 	(first_name LIKE '___')
		AND (last_name LIKE '%X'
			 OR last_name LIKE '%Y');
			 
-- Challenge 9: ADDITIONAL
SELECT
	COUNT(*) AS no_of_movies
FROM film
WHERE 	(description LIKE '%Saga%')
		AND (title LIKE 'A%' OR
			title LIKE '%R');

-- Challenge 10: ADDITIONAL
SELECT
	first_name,
	last_name
FROM customer
WHERE 	(first_name LIKE '%ER%')
		AND (first_name LIKE '_A%')	
ORDER BY last_name DESC;
		
-- Challenge 11: ADDITIONAL
SELECT
	COUNT(*)
FROM payment
WHERE 	(payment_date BETWEEN '2020-05-01' AND '2020-05-02') 
		AND (amount = 0 OR
		amount BETWEEN 3.99 AND 7.99);	


		
		

	
