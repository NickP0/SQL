SELECT 
*,
SUM(amount) OVER(ORDER BY payment_date)
FROM payment;

SELECT
*,
SUM(amount) OVER(PARTITION BY customer_id ORDER BY payment_id)
FROM payment;


SELECT
*,
SUM(amount)
	OVER(PARTITION BY customer_id 
		 ORDER BY payment_date, payment_id)
FROM payment;

/* ORDER BY challenge:
Write a query that returns the running total of how late the 
flights are (difference between actual_arrival and scheduled arrival)
ordered by flight_id including the departure airport
*/

SELECT * FROM flights;


SELECT
flight_id,
departure_airport,
SUM(actual_arrival-scheduled_arrival) OVER (ORDER BY flight_id) 
FROM flights;

SELECT
flight_id,
departure_airport,
SUM(actual_arrival-scheduled_arrival) OVER (PARTITION BY departure_airport ORDER BY flight_id) 
FROM flights;
