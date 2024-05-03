--ROLLUP
SELECT 
TO_CHAR (payment_date, 'Q') AS quarter,
EXTRACT(month FROM payment_date) AS month,
DATE(payment_date) AS date,
SUM(amount)
FROM payment
GROUP BY
	ROLLUP (quarter,month,date)
ORDER BY 1,2,3;
	
SELECT 
TO_CHAR (payment_date, 'Q') AS quarter,
EXTRACT(month FROM payment_date) AS month,
DATE(payment_date) AS date,
SUM(amount)
FROM payment
GROUP BY
	ROLLUP (TO_CHAR (payment_date, 'Q'),
			EXTRACT(month FROM payment_date),
			DATE(payment_date))
ORDER BY 1,2,3;

/* ROLLUP challenge: 
Write a query that calculates a booking amount
rollup for the hierarchy of quarter, month, week
in month and day
*/
-- WRONG DB
SELECT 
TO_CHAR (payment_date, 'Q') AS quarter,
EXTRACT (month FROM payment_date) AS month,
TO_CHAR (payment_date, 'W') AS week_in_month,
DATE (payment_date) AS day,
SUM (amount)
FROM payment
GROUP BY
	ROLLUP
	(quarter, month, week_in_month, day)
ORDER BY 1,2,3,4
