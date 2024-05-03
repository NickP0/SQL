-- Example of a subquery in FROM
SELECT ROUND(AVG(total_amount),2)
FROM
(SELECT customer_id, SUM(amount) AS total_amount FROM payment
GROUP BY customer_id) AS subquery

/*Challenge: Subqueries in FROM
What is the average total amount spent per day (average daily revenue)?
*/

 SELECT ROUND(AVG(daily_spend),2) AS average_daily_spend FROM
(SELECT 
 payment_date, SUM(amount)*365 AS daily_spend 
 FROM payment
 GROUP BY payment_date)

/* this query is wrong: this rather provides us with the annual spend 
as we multiplied by 365
*/

/* The correct query isn't far off but needed clarifying the 
payment_date column with the DATE function*/

SELECT ROUND(AVG(avg_daily_spend),2) AS avg_daily_revenue FROM
(SELECT
DATE(payment_date),
SUM(amount) AS avg_daily_spend
FROM payment
GROUP BY DATE(payment_date)) AS subquery