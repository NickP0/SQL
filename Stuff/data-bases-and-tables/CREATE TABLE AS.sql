-- CREATE TABLE AS
CREATE TABLE customer_address
AS
SELECT first_name, last_name, email, address, city
FROM customer
LEFT JOIN address 
ON customer.address_id = address.address_id
LEFT JOIN city
ON city.city_id = address.city_id;


SELECT * FROM customer_address;

/* CREATE TABLE AS challenge:

Create a table called customer_spendings that has 
the first name and last name of a customer 
as well as their total spending from the payments table
*/ 

SELECT * FROM customer
-- first_name, last_name (customer_id)

SELECT * FROM payment
-- amount (customer_id)

CREATE TABLE customer_spendings
AS 
SELECT first_name ||' '|| last_name AS name, 
SUM(amount) AS total_amount
FROM customer 
LEFT JOIN payment 
ON customer.customer_id = payment.customer_id
GROUP BY first_name ||' '|| last_name;

SELECT * FROM customer_spendings;



