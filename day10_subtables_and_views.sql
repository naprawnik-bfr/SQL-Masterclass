-- DAY 10 SUBTABLES AND VIEWS:

-- Challenge 1: SUBTABLE
-- data storage/ no auto refresh
CREATE TABLE customer_spendings
AS
SELECT 
	(first_name || ' ' || last_name) AS first_last_name, 
	SUM(amount)
FROM customer c 
LEFT JOIN payment p 
ON c.customer_id = p.customer_id
GROUP BY first_last_name;

SELECT * FROM customer_spendings;

/* Challenge 2: VIEW
-- no data storage (query runs internally on every usage of view)/ auto refresh
Create a view called films_category that shows a list of the film titles including 
their title, length and category name ordered descendingly by the length.
Filter the results to only the movies in the category 'Action' and 'Comedy'.*/
CREATE VIEW films_category
AS
SELECT 
	title, 
	length, 
	name 
FROM film f
LEFT JOIN film_category fc
ON f.film_id = fc.film_id
LEFT JOIN category c
ON fc.category_id = c.category_id
WHERE name IN ('Film' , 'Action')
ORDER BY length DESC;

SELECT * FROM films_category;

-- Challenge 3: MATERIALIZED VIEW
-- data storage/ refresh on demand

CREATE MATERIALIZED VIEW mv_film_category
AS
SELECT 
	title, 
	length, 
	name 
FROM film f
LEFT JOIN film_category fc
ON f.film_id = fc.film_id
LEFT JOIN category c
ON fc.category_id = c.category_id
WHERE name IN ('Comedy' , 'Action')
ORDER BY length DESC;

UPDATE film 
SET length = 192
WHERE title = 'SATURN NAME';

REFRESH MATERIALIZED VIEW mv_film_category;

SELECT * FROM mv_film_category;

/* Challenge 4: MANAGING VIEWS
In this challenge we use again the view v_customer_info.
You need to perform the following tasks:
1) Rename the view to v_customer_information.
2) Rename the customer_id column to c_id.
3) Add also the initial column as the third column to the view by replacing the view.
*/
CREATE VIEW v_customer_info
AS
SELECT cu.customer_id,
    cu.first_name || ' ' || cu.last_name AS name,
    a.address,
    a.postal_code,
    a.phone,
    c.city,
    co.country
FROM customer cu
JOIN address a 
ON cu.address_id = a.address_id
JOIN city c
ON a.city_id = c.city_id
JOIN country co
ON c.country_id = co.country_id
ORDER BY customer_id;

ALTER VIEW v_customer_info
RENAME TO v_customer_information;

ALTER VIEW v_customer_infomation
RENAME customer_id TO c_id;

CREATE OR REPLACE VIEW v_customer_information
AS
SELECT cu.customer_id,
    cu.first_name || ' ' || cu.last_name AS name,
	cu.initials,
    a.address,
    a.postal_code,
    a.phone,
    c.city,
    co.country
FROM customer cu
JOIN address a 
ON cu.address_id = a.address_id
JOIN city c
ON a.city_id = c.city_id
JOIN country co
ON c.country_id = co.country_id
ORDER BY customer_id;

SELECT * FROM v_customer_information;
