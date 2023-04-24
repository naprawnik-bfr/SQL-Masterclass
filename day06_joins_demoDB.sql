-- DAY 6 JOINS:

-- Challenge 1: INNER JOIN
SELECT * FROM boarding_passes bp
INNER JOIN seats s
ON bp.seat_no = s.seat_no;

SELECT 
	fare_conditions,
	COUNT(*) amount_of_flights 
FROM boarding_passes bp
INNER JOIN seats s
ON bp.seat_no = s.seat_no
GROUP BY fare_conditions;

-- Challenge 2: FULL OUTER JOIN
SELECT * FROM boarding_passes bp
FULL OUTER JOIN tickets t 
ON bp.ticket_no = t.ticket_no
WHERE bp.ticket_no IS NULL;

-- Challenge 3: LEFT JOIN
SELECT * FROM aircrafts_data ad
LEFT JOIN flights f
ON ad.aircraft_code = f.aircraft_code
WHERE flight_no IS NULL;

-- Challenge 4: LEFT JOIN
SELECT 
	s.seat_no,
	COUNT(*)
FROM seats s
LEFT JOIN boarding_passes bp
ON s.seat_no = bp.seat_no
GROUP BY 1
ORDER BY 2 DESC;

-- Challenge 7: JOINTS - MULTIPLE CONDITIONS
SELECT 	
	seat_no,
	ROUND(AVG(amount),2) AS avg_amount 
FROM boarding_passes b
LEFT JOIN ticket_flights t 
ON b.ticket_no = t.ticket_no
AND b.flight_id = t.flight_id
GROUP BY seat_no
ORDER BY 2 DESC;

-- Challenge 9: JOINTS - ADDITIONAL
SELECT 
	passenger_name,
	SUM(total_amount) AS total_amount
FROM tickets t
INNER JOIN bookings b
ON t.book_ref = b.book_ref
GROUP BY passenger_name
ORDER BY total_amount DESC;

-- Challenge 10: JOINTS - ADDITIONAL
SELECT 
	passenger_name,
	fare_conditions,
	COUNT(*)
FROM bookings b
INNER JOIN tickets t
ON b.book_ref = t.book_ref
INNER JOIN ticket_flights tf 
ON t.ticket_no = tf.ticket_no
WHERE passenger_name = 'ALEKSANDR IVANOV'
GROUP BY 	fare_conditions, 
			passenger_name
ORDER BY COUNT(*) DESC;




