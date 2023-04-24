-- DAY 5 CONDITIONAL EXPRESSIONS:

-- Challenge 1: Math
SELECT
	film_id,
	ROUND(rental_rate/replacement_cost*100,2) as rental_ratio
FROM film
WHERE ROUND(rental_rate/replacement_cost*100,2) < 4
ORDER BY rental_ratio ASC; 

-- Challenge 4: CASE WHEN
SELECT 
	title,
	CASE
	WHEN rating IN('PG', 'PG-13') OR LENGTH > 210 THEN 'Great rating or long (tier 1)'
	WHEN description LIKE '%Drama%' AND LENGTH > 90 THEN 'Long drama (tier 2)'
	WHEN description LIKE '%Drama%' THEN 'Short drama (tier 3)'
	WHEN rental_rate < 1 THEN 'Very cheap (tier 4)'
	END AS tier
FROM film
WHERE	CASE
		WHEN rating IN('PG', 'PG-13') OR LENGTH > 210 THEN 'Great rating or long (tier 1)'
		WHEN description LIKE '%Drama%' AND LENGTH > 90 THEN 'Long drama (tier 2)'
		WHEN description LIKE '%Drama%' THEN 'Short drama (tier 3)'
		WHEN rental_rate < 1 THEN 'Very cheap (tier 4)'
		END IS NOT NULL
ORDER BY title ASC;

-- Challenge 5: CASE WHEN with SUM + PIVOT
SELECT 
	rating, 
	COUNT(*)
FROM film
GROUP BY rating;

SELECT 
	SUM (CASE WHEN rating = 'R' THEN 1 ELSE 0 END) AS "R",
	SUM (CASE WHEN rating = 'G' THEN 1 ELSE 0 END) AS "G",
	SUM (CASE WHEN rating = 'NC-17' THEN 1 ELSE 0 END) AS "NC-17",
	SUM (CASE WHEN rating = 'PG' THEN 1 ELSE 0 END) AS "PG",
	SUM (CASE WHEN rating = 'PG-13' THEN 1 ELSE 0 END) AS "PG-13"
FROM film;


-- Challenge 6: COALESCE with CAST
SELECT 
	rental_date,
	COALESCE(CAST(return_date AS VARCHAR),'not returned')
FROM rental
ORDER BY rental_date DESC;
