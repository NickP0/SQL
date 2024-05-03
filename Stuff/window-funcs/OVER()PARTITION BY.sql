--Find the sum of the amount for each customer.
SELECT
*,
SUM(amount) OVER(PARTITION BY customer_id) 
FROM payment 
ORDER BY payment_id;

-- How many transactions did we have per customer?
SELECT
*,
COUNT(*) OVER(PARTITION BY customer_id) 
FROM payment 
ORDER BY payment_id;


-- How many transactions did each customer have for each staff id?
SELECT
*,
COUNT(*) OVER(PARTITION BY customer_id, staff_id) 
FROM payment 
ORDER BY payment_id;

SELECT
*,
COUNT(*) OVER() 
FROM payment 
ORDER BY payment_id;

/* OVER() PARTITION BY challenge: 
1)Find the average length of movies per their respective category
2) Write a query that returns all payment details including:
the number of payments that were made by this customer and that amount
*/
--1) 
SELECT
film.film_id,
title,
length,
name AS category,
ROUND(AVG(length) OVER(PARTITION BY category),2) AS average_length_per_category
FROM film
LEFT JOIN film_category
ON film.film_id = film_category.film_id
LEFT JOIN category
ON film_category.category_id = category.category_id
ORDER BY film.film_id;


--2) 

SELECT * FROM payment
--customer_id

SELECT * FROM customer
--customer_id

SELECT 
payment_id,
payment.customer_id,
staff_id,
rental_id,
amount,
payment_date,
COUNT(*) OVER(PARTITION BY amount, payment.customer_id)
FROM payment
LEFT JOIN customer 
ON payment.customer_id = customer.customer_id
ORDER BY payment_id;
-- Above is wrong, below is the right one.
SELECT 
*,
COUNT(*) OVER(PARTITION BY amount, customer_id)
FROM payment
ORDER BY payment_id;
