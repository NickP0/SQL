-- CUBE
/* What are the totals per customer, per staff id,
per date?
Note here there is no natural hierarchy as 
one customer can buy from multiple staff ids.
*/

SELECT
customer_id,
staff_id,
DATE(payment_date),
SUM(amount)
FROM payment
GROUP BY 
	CUBE (customer_id, staff_id, DATE(payment_date))
	ORDER BY 1,2,3;
/*
The query uses the CUBE operation to generate subtotals and 
grand totals for combinations of customer_id, staff_id, and payment_date 
in the payment table. The result set will include rows representing:

Subtotals for individual dimensions: total amounts for each customer_id, staff_id, and payment_date.

Subtotals for pairs of dimensions: total amounts for each combination of 
customer_id and staff_id, customer_id and payment_date, and staff_id and payment_date.

An overall grand total: total amount for all three dimensions together ().

The ORDER BY clause sorts the result set 
based on customer_id, staff_id, and payment_date. 
The SUM(amount) column in each row represents 
the total amount for the corresponding combination of dimensions. 
Actual result will depend on the data in the payment table.
*/


/*
Challenge:
Write a query that returns all grouping sets 
in all combinations of customer_id, date and title 
with the aggregation of the payment amount.
*/

SELECT 
payment.customer_id,
DATE(payment_date),
film.title,
SUM(amount)
FROM payment
LEFT JOIN rental
ON rental.rental_id = payment.rental_id
LEFT JOIN inventory
ON inventory.inventory_id = rental.inventory_id
LEFT JOIN film
ON film.film_id = inventory.film_id
GROUP BY
	CUBE (payment.customer_id, DATE(payment_date),film.title)
ORDER BY 1,2,3

