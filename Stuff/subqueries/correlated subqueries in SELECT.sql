--Correlated Subquery in SELECT
--Show the maximum amount for every customer


SELECT *,
(SELECT MAX(amount) FROM payment p2
WHERE p1.customer_id = p2.customer_id)
FROM payment p1
ORDER BY customer_id DESC;

/* Subquery challenges:
1) Show all the payments plus the total amount
for every customer as well as the number of each
customer.


Correlated subquery in SELECT
- Show all payments
- and the total amount for every customer
- as well as the numner of payments of each customer
*/ 
SELECT * FROM payment

SELECT payment_id, customer_id, staff_id, amount, 
(SELECT SUM(amount) AS sum_amount 
FROM payment AS p2
WHERE p1.customer_id = p2.customer_id),
(SELECT COUNT(amount) AS count_payments
FROM payment AS p2
WHERE p1.customer_id = p2.customer_id)
FROM payment AS p1 
ORDER BY customer_id, amount DESC;


/* 2nd challenge:
Show only those films with the highest replacement costs
in their rating category plus show the average replacement
cost in their rating category.
*/

SELECT * FROM film

/* 3rd challenge: 
Show only those payments with the highest payment 
for each customer's first name - including the payment_id of that payment
How would you solve it if you would not need to see the payment_id?
*/
  
-- Correlated subquery challenge resolution:
--1) Correlated subquery in SELECT:
-- Show all the payments
-- and the total amount for every customer
-- as well as the number of payments of each customer

SELECT 
payment_id,
customer_id,
staff_id,
amount,
(SELECT SUM(amount) AS sum_amount
FROM payment AS p2
WHERE p1.customer_id = p2.customer_id),
(SELECT COUNT(amount) AS count_payments
 FROM payment AS p2
 WHERE p1.customer_id = p2.customer_id)
 FROM payment AS p1 
 ORDER BY customer_id;
 
-- Resolution for 2)
-- Correlated Subquery in SELECT and WHERE
-- Show only the highest replacement costs
-- for each rating
-- and their average

SELECT title, replacement_cost, rating,
				(SELECT AVG(replacement_cost) FROM film AS f2
			 	 WHERE f1.rating = f2.rating)
FROM film AS f1
WHERE replacement_cost = (SELECT MAX(replacement_cost) FROM film AS f3
						  WHERE f1.rating = f3.rating)
						  

-- Resolution for 3: (JOIN)
-- (3.1) show top payments for each customer including the payment_id and first_name
-- (3.2) How would you solve it if you didn't need to see the payment_id 

-- 3.1
SELECT first_name, amount, payment_id 
FROM payment AS p1
INNER JOIN customer AS c1
ON p1.customer_id = c1.customer_id
WHERE amount = (SELECT MAX(amount) FROM payment AS p2
			   WHERE p1.customer_id = p2.customer_id);
			   
-- 3.2
SELECT first_name, MAX(amount)
FROM payment AS p1
INNER JOIN customer AS c1
ON p1.customer_id = c1.customer_id
GROUP BY first_name



