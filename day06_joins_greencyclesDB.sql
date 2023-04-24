-- Challenge 5: JOINTS
SELECT 
	first_name,
	last_name,
	phone,
	district
FROM address a
LEFT JOIN customer c
ON a.address_id = c.address_id
WHERE district = 'Texas';

-- Challenge 6: JOINTS
SELECT * FROM address a
LEFT JOIN customer c
ON a.address_id = c.address_id
WHERE first_name IS NULL
ORDER BY a.address_id ASC;

-- Challenge 8: JOINTS - JOINING MULTIPLE COLUMNS
SELECT 
	first_name,
	last_name, 
	email,
	country
FROM customer c
LEFT JOIN address a
ON c.address_id = a.address_id
LEFT JOIN city ci
ON a.city_id = ci.city_id
LEFT JOIN country co
ON ci.country_id = co.country_id
WHERE country = 'Brazil';

-- Challenge 11: JOINTS - ADDITIONAL
SELECT 
	title,
	COUNT(*)
FROM customer c
LEFT JOIN rental r 
ON c.customer_id = r.customer_id 		
LEFT JOIN inventory i 
ON r.inventory_id = i.inventory_id
LEFT JOIN film f
ON i.film_id = f.film_id
WHERE 	first_name = 'GEORGE' 
		AND last_name = 'LINTON' 
GROUP BY title
ORDER BY COUNT(*) DESC;



