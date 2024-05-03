-- NATURAL JOIN

SELECT
first_name,
last_name,
SUM(amount)
FROM payment
NATURAL INNER JOIN customer
GROUP BY first_name, last_name