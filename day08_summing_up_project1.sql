-- DAY 8 COURSE PROJECT:

/*
Question 1:
Task: Create a list of all the different (distinct) replacement costs of the films.
Question: What's the lowest replacement cost? 
*/

SELECT MIN(replacement_cost) FROM film;

/*
Question 2:
Task: Write a query that gives an overview of how many films have replacements costs in the following cost ranges
low: 9.99 - 19.99, medium: 20.00 - 24.99, high: 25.00 - 29.99
Question: How many films have a replacement cost in the "low" group?
*/

SELECT 
	COUNT(*),
	CASE 
	WHEN replacement_cost <= 19.99 THEN 'low'
	WHEN replacement_cost <= 24.99 THEN 'medium'
	ELSE 'high'
	END AS cost_range
FROM film
GROUP BY cost_range;

/*
Question 3:
Task: Create a list of the film titles including their title, length, and category name ordered descendingly by length. 
Filter the results to only the movies in the category 'Drama' or 'Sports'.
Question: In which category is the longest film and how long is it?
*/

SELECT 
	title, 
	length, 
	name 
FROM film f     								
INNER JOIN film_category fc
ON f.film_id = fc.film_id
INNER JOIN category c
ON fc.category_id = c.category_id
WHERE name IN ('Drama', 'Sports')
ORDER BY length DESC;

/*
Question 4:
Task: Create an overview of how many movies (titles) there are in each category (name).
Question: Which category (name) is the most common among the films?
*/

SELECT 
	name, 
	COUNT(*) 
FROM film f 								
LEFT JOIN film_category fc
ON f.film_id =fc.film_id
LEFT JOIN category c
ON fc.category_id = c.category_id
GROUP BY name
ORDER BY COUNT(*) DESC;
	
/*
Question 5:
Task: Create an overview of the actor's first and last names and in how many movies they appear in.
Question: Which actor is part of most movies??
movies
*/
	
SELECT 
	first_name, 
	last_name, 
	COUNT(*) 
FROM film f 					
LEFT JOIN film_actor fa
ON f.film_id =fa.film_id
LEFT JOIN actor a
ON fa.actor_id = a.actor_id
GROUP BY first_name, last_name
ORDER BY COUNT(*) DESC;

/*
Question 6:
Task: Create an overview of the addresses that are not associated to any customer.
Question: How many addresses are that?
*/

SELECT 
	COUNT(*)
FROM address a
LEFT JOIN customer c
ON a.address_id = c.address_id
WHERE customer_id IS NULL;

/*
Question 7:
Task: Create an overview of the cities and how much sales (sum of amount) have occurred there.
Question: Which city has the most sales?
*/

SELECT 
	city, 
	SUM(amount) 
FROM payment p     								
LEFT JOIN customer c
ON p.customer_id = c.customer_id
LEFT JOIN address a
ON c.address_id = a.address_id
LEFT JOIN city ci
ON a.city_id = ci.city_id
GROUP BY city
ORDER BY SUM(amount) DESC;

/*
Question 8:
Task: Create an overview of the revenue (sum of amount) grouped by a column in the format "country, city".
Question: Which country, city has the least sales?
*/

SELECT 
	country || ', ' || city as country_city, 
	SUM(amount) 
FROM payment p     								
LEFT JOIN customer c
ON p.customer_id = c.customer_id
LEFT JOIN address a
ON c.address_id = a.address_id
LEFT JOIN city ci
ON a.city_id = ci.city_id
LEFT JOIN country co
ON ci.country_id = co.country_id
GROUP BY country, city
ORDER BY SUM(amount) ASC;

/*
Question 9:
Task: Create a list with the average of the sales amount each staff_id has per customer.
Question: Which staff_id makes on average more revenue per customer?
*/

SELECT 
	staff_id, 
	ROUND(AVG(total),2) AS avg_per_customer
FROM (SELECT 
		staff_id,
		customer_id,
		SUM(amount) AS total
	 FROM payment 
	 GROUP BY staff_id, customer_id
	 ORDER BY customer_id) as help
GROUP BY staff_id;
	
/*
Question 10:
Task: Create a query that shows average daily revenue of all Sundays.
Question: What is the daily average revenue of all Sundays?
*/	

SELECT 
	ROUND(AVG(daily_total),2) AS daily_revenue_of_0
FROM (SELECT 
		SUM(amount) daily_total,
		DATE(payment_date) p_d
	 FROM payment 
	 WHERE EXTRACT(DOW from payment_date) = 0
	 GROUP BY p_d) AS helper;

/*
Question 11:
Task: Create a list of movies - with their length and their replacement cost - that are longer than the average 
length in each replacement cost group.
Question: Which two movies are the shortest on that list and how long are they?
*/		

SELECT 
	title,
	length,
	replacement_cost
FROM film f1
WHERE length > (SELECT AVG(length) FROM film f2
			   WHERE f1.replacement_cost = f2.replacement_cost)
ORDER BY length ASC;
	
/*
Question 12:
Task: Create a list that shows the "average customer lifetime value" grouped by the different districts.
Question: Which district has the highest average customer lifetime value?
*/		

SELECT 
	district,
	ROUND(AVG(total_for_customer),2) avg_for_district
FROM (SELECT 
		c.customer_id,
	  	address_id,
		SUM(amount) total_for_customer
	 FROM customer c
	 LEFT JOIN payment p
	 ON c.customer_id = p.customer_id
	 GROUP BY c.customer_id) as helper
LEFT JOIN address a
ON helper.address_id = a.address_id
GROUP BY district
ORDER BY avg_for_district DESC;

/*
Question 13:
Task: Create a list that shows all payments including the payment_id, amount, and the film category (name) plus 
the total amount that was made in this category. Order the results ascendingly by the category (name) and as second 
order criterion by the payment_id ascendingly.
Question: What is the total revenue of the category 'Action' and what is the lowest payment_id in that category 'Action'?
*/	

SELECT 	
	payment_id, 													
	amount,
	name, 
	(SELECT SUM(amount) FROM payment p
						LEFT JOIN rental r
						ON p.rental_id = r.rental_id 
						LEFT JOIN inventory i
						ON r.inventory_id = i.inventory_id
						LEFT JOIN film_category fc
						ON i.film_id = fc.film_id
						LEFT JOIN category c1
						ON fc.category_id = c1.category_id
	 					WHERE c1.name = c2.name)
FROM payment p
LEFT JOIN rental r
ON p.rental_id = r.rental_id 
LEFT JOIN inventory i
ON r.inventory_id = i.inventory_id
LEFT JOIN film_category fc
ON i.film_id = fc.film_id
LEFT JOIN category c2
ON fc.category_id = c2.category_id
ORDER BY
	name ASC,
	payment_id ASC;
