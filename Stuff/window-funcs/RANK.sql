-- RANK
SELECT
film.title,
category.name,
film.length,
DENSE_RANK() OVER(PARTITION BY name ORDER BY length DESC) 
FROM film
LEFT JOIN film_category
ON film.film_id = film_category.film_id
LEFT JOIN category
ON category.category_id = film_category.category_id

-- RANK and WHERE (subquery)
SELECT 
*
FROM
(SELECT
film.title,
category.name,
film.length,
DENSE_RANK() OVER(PARTITION BY name ORDER BY length DESC) AS RANK
FROM film
LEFT JOIN film_category
ON film.film_id = film_category.film_id
LEFT JOIN category
ON category.category_id = film_category.category_id) AS subquery
WHERE RANK = 1

-- RANK challenge: 

SELECT * FROM customer_list;

SELECT * FROM payment;

SELECT
*
FROM
(SELECT 
name,
country,
COUNT(*),
RANK() OVER(PARTITION BY country ORDER BY name) AS RANK
FROM customer_list 
LEFT JOIN payment
ON customer_list.id = payment.customer_id
GROUP BY name, country) AS subq
WHERE RANK IN (1,2,3)