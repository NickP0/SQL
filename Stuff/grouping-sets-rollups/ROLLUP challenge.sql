/* ROLLUP challenge: 
Write a query that calculates a booking amount
rollup for the hierarchy of quarter, month, week
in month and day
*/

SELECT 
TO_CHAR (book_date, 'Q') AS quarter,
EXTRACT (month FROM book_date) AS month,
TO_CHAR (book_date, 'W') AS week_in_month,
DATE (book_date) AS day,
SUM (total_amount)
FROM bookings
GROUP BY
	ROLLUP
	(quarter, month, week_in_month, day)
ORDER BY 1,2,3,4;


SELECT * FROM bookings
