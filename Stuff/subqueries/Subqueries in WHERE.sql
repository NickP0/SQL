SELECT * FROM payment

/* Your manager is asking you to return all of the 
payments where the payment amount is greater than the 
average payment amount */
--1)
SELECT
AVG(amount)
FROM payment;

--2)
SELECT * FROM payment
WHERE amount > 4.2006673312979002

-- This way to query this question is unpractical - we can use a more flexible approach.

--3) 
SELECT
*
FROM payment
WHERE amount > (SELECT AVG(amount) FROM payment)

/* another subquery example.
We want to find all of the payments of customers called ADAM
*/

SELECT
*
FROM payment
WHERE customer_id = (SELECT customer_id FROM customer
					 WHERE first_name = 'ADAM')
					 
					 
-- Re-do of subquery (a subquery is a query within a query)
--1)
SELECT
amount AS avg_amount
FROM payment 
WHERE amount > (SELECT AVG(amount) FROM payment)

--2) Single value subquery
SELECT
--customer_id 
--amount
*
FROM payment
WHERE customer_id = (SELECT customer_id FROM customer	
					 WHERE first_name = 'ADAM')

--3) Multiple value subquery
SELECT
*
FROM payment
WHERE customer_id IN (SELECT customer_id FROM customer
					 WHERE first_name LIKE 'A%')

/* WHERE subquery challenge:
Select all of the films where the length is longer
than the average of all films
*/

SELECT 
film_id,
title
FROM film
WHERE length > (SELECT AVG(length) FROM film);

/* 2) 
Return all the films that are available in the inventory in
store 2 more than 3 times
*/
-- the right query:

SELECT * FROM film
WHERE film_id IN (SELECT film_id FROM inventory
				 WHERE store_id = 2
				 GROUP BY film_id
				 HAVING COUNT(*) >3)
				 
/* More challenges: 
1) Return all customers' first names and last names that 
have made a payment on '2020-01-25'
*/

SELECT * FROM customer
-- first_name, last_name, email, 

SELECT * FROM payment
ORDER BY amount DESC
-- payment_date

SELECT first_name, last_name
FROM customer
WHERE customer_id IN (SELECT customer_id
					  FROM payment
					  WHERE payment_date BETWEEN '2020-01-25 00:00' AND '2020-01-25 23:59')

/*2) Return all customers' first_names and emails that have
spent more than $30.
*/

SELECT first_name, email
FROM customer
WHERE customer_id IN (SELECT customer_id
					  FROM payment
					  WHERE amount < 30)
					  
-- above query is wrong	note: I only used the less than sign because there isn't an amount that has been spent that is >30				  

SELECT first_name, email
FROM customer
WHERE customer_id IN (SELECT customer_id
					  FROM payment
					  GROUP BY customer_id
					  HAVING SUM(amount)>30)
				
		
-- Return all the customers' first and last names that are from California and have spent more than 100 in total.
-- JOIN? 

SELECT * FROM customer
-- customer_id(2), store_id, first_name, last_name, email, adress_id(1) 

SELECT * FROM address
-- address_id(1), address, address2, district, city_id, postal_code, phone, last_update

SELECT * FROM payment x
-- payment_id, customer_id(2), staff_id, rental_id, amount, payment_date


SELECT first_name, last_name, email
FROM customer
WHERE customer_id IN (SELECT customer_id
					 FROM payment
					 GROUP BY customer_id
					 HAVING SUM(amount)>100)
AND customer_id IN (SELECT customer_id
				   FROM customer
				   INNER JOIN address
				   ON customer.address_id = address.address_id
				   WHERE address.district = 'California');
			  
					 
					 
					 
					 
					 
					 
					 
-- Solutions for subquerying WHERE challenges
/* More challenges: 
1) Return all customers' first names and last names that 
have made a payment on '2020-01-25'
*/

SELECT first_name, last_name
FROM customer
WHERE customer_id IN (SELECT customer_id
					 FROM payment
					 WHERE DATE(payment_date)='2020-01-25')
					 
					 
/*2) Return all customers' first_names and emails that have
spent more than $30.
*/

SELECT first_name, email
FROM customer
WHERE customer_id IN (SELECT customer_id
					 FROM payment
					 GROUP BY customer_id
					 HAVING SUM(amount)>30)

					 
-- Return all the customers' first and last names that are from California and have spent more than 100 in total.
					 
SELECT first_name, last_name, email
FROM customer
WHERE customer_id IN (SELECT customer_id
					  FROM payment
					  GROUP BY customer_id
					  HAVING SUM(amount)>100)
AND customer_id IN (SELECT customer_id
					FROM customer
				    INNER JOIN address
				    ON address.address_id = customer.address_id
				    WHERE district = 'California')					 
					 
					 
					 
					 
				
			 
					
				