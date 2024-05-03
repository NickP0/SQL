-- FIRST_VALUE

SELECT 
name,
country,
COUNT(*),
FIRST_VALUE(name) OVER(PARTITION BY country ORDER BY count(*)) 
FROM customer_list 
LEFT JOIN payment
ON customer_list.id = payment.customer_id
GROUP BY name, country;

SELECT
name,
country,
COUNT(*),
FIRST_VALUE(COUNT(*)) OVER(PARTITION BY country ORDER BY COUNT(*) DESC)
FROM customer_list
LEFT JOIN payment
ON customer_list.id = payment.customer_id
GROUP BY name, country;

--Using FIRST_VALUE() for calculations

SELECT
name,
country,
COUNT(*),
FIRST_VALUE(COUNT(*)) OVER(PARTITION BY country ORDER BY COUNT(*)), 
COUNT(*)-FIRST_VALUE(COUNT(*)) OVER(PARTITION BY country ORDER BY COUNT(*)) 
FROM customer_list
LEFT JOIN payment
ON customer_list.id=payment.customer_id
GROUP BY name, country;