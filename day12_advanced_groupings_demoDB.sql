-- Challenge 3: GROUPING SETS - ROLLUP
SELECT 
	TO_CHAR (book_date, 'Q') AS quarter,
	EXTRACT (month from book_date) AS month,
	TO_CHAR (book_date, 'W') AS week_in_month,
	DATE (book_date) AS day,
	SUM(total_amount)
FROM bookings
GROUP BY
ROLLUP(
	quarter,
	month,
	week_in_month,
	day
)
ORDER BY
	quarter,
	month,
	week_in_month,
	day;