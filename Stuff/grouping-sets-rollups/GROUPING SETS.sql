-- GROUPING SETS
SELECT
TO_CHAR(payment_date, 'Month') AS month,
staff_id,
SUM(amount)
FROM payment
GROUP BY
	GROUPING SETS(
		(staff_id),
		(month),
		(staff_id,month))
		
		
		
/* GROUP SETS challenge:
Write a query that returns the sum amount for each
customer (first name and last name) and each staff id.
Add the overall revenue per customer.
*/
SELECT * FROM payment (customer_id);
SELECT * FROM customer (customer_id);

SELECT 
c1.first_name,
c1.last_name,
p1.staff_id,
SUM(p1.amount)
FROM customer AS c1
LEFT JOIN payment AS p1
ON c1.customer_id=p1.customer_id
GROUP BY
	GROUPING SETS (
	(c1.first_name),
	(c1.last_name),
	(p1.staff_id),
	(c1.first_name, c1.last_name, p1.staff_id))
ORDER BY first_name, last_name
-- above query is wrong

-- the right query:

SELECT 
first_name,
last_name,
staff_id,
SUM(amount)
FROM customer 
LEFT JOIN payment 
ON customer.customer_id=payment.customer_id
GROUP BY
	GROUPING SETS (
	(first_name, last_name),
	(first_name, last_name, staff_id))
ORDER BY first_name, last_name

-- Both queries give the same results

-- thats false: when ordering by as above different results

/* 2nd challenge
Write a query that calculates now the share of revenue
each staff_id makes per customer
*/

SELECT 
first_name,
last_name,
staff_id,
SUM(amount) AS total,
ROUND(100*SUM(amount)/FIRST_VALUE(SUM(amount)) OVER(
	PARTITION BY first_name, last_name ORDER BY SUM(amount) DESC),2) AS percentage
FROM customer 
LEFT JOIN payment 
ON customer.customer_id=payment.customer_id
GROUP BY
	GROUPING SETS (
	(first_name, last_name),
	(first_name, last_name, staff_id))
ORDER BY first_name, last_name

