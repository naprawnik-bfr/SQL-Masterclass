-- Challenge 3: OVER() with ORDER BY - running total
SELECT
	flight_id,
	departure_airport,
	SUM(actual_arrival - scheduled_arrival) OVER (ORDER BY flight_id)
FROM flights;

SELECT
	flight_id,
	departure_airport,
	SUM(actual_arrival - scheduled_arrival) OVER (PARTITION BY departure_airport  ORDER BY flight_id)
FROM flights;