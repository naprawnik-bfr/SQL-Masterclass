-- Challenge 2: CASE WHEN
SELECT 
	COUNT(*) AS amount_of_tickets,
	CASE
	WHEN amount < 20000 THEN 'low price ticket'
	WHEN amount < 150000 THEN 'mid price ticket'
	ELSE 'high price ticket'
	END AS ticket_price
FROM ticket_flights
GROUP BY ticket_price;

-- Challenge 3: CASE WHEN
SELECT 
	COUNT(*) AS number_of_flights,	
	CASE
	WHEN EXTRACT(MONTH from scheduled_departure) IN (1,2,12) THEN 'Winter'
	WHEN EXTRACT(MONTH from scheduled_departure) < 6 THEN 'Spring'
	WHEN EXTRACT(MONTH from scheduled_departure) < 9 THEN 'Summer'
	ELSE 'Fall'
	END AS seasons	
FROM flights
GROUP BY seasons;




