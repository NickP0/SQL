--LEAD and LAG
SELECT
name,
country,
COUNT(*),
LEAD(name) OVER(PARTITION BY country ORDER BY COUNT(*))
FROM customer_list
LEFT JOIN payment
ON customer_list.id=payment.customer_id
GROUP BY name, country;


--LAG
SELECT
name,
country,
COUNT(*),
LAG(name) OVER(PARTITION BY country ORDER BY COUNT(*))
FROM customer_list
LEFT JOIN payment
ON customer_list.id=payment.customer_id
GROUP BY name, country;

-- LEAD and LAG challenge:
/* Write a query that returns the revenue of the day and
the revenue of the previous day
Afterwards calculate the percentage growth comapred to the previous day
*/
SELECT * FROM payment

SELECT
SUM(amount),
DATE(payment_date) AS day,
LAG(SUM(amount)) OVER(ORDER BY DATE(payment_date)) AS previous_day,
SUM(amount) - LAG(SUM(amount)) OVER(ORDER BY DATE(payment_date)) AS difference,
ROUND((SUM(amount) - LAG(SUM(amount)) OVER(ORDER BY DATE(payment_date)))
/ 
LAG(SUM(amount)) OVER(ORDER BY DATE(payment_date)) * 100,2) AS percentage_growth
FROM payment
GROUP BY DATE(payment_date)
