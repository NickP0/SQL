SELECT payment_id, 
payment.customer_id, 
amount,
first_name, 
last_name
FROM payment
INNER JOIN customer 
ON payment.customer_id = customer.customer_id;


SELECT payment.*, 
first_name, 
last_name, 
email 
FROM payment
INNER JOIN staff
ON staff.staff_id = payment.staff_id
WHERE staff.staff_id=1;

SELECT payment_id,
payment.customer_id,
amount,
first_name,
last_name
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id;

SELECT * FROM payment
SELECT * FROM customer


SELECT payment.*,
first_name,
last_name,
amount
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id;

SELECT 
payment_id,
pa.customer_id,
first_name,
last_name,
amount
FROM payment AS pa
INNER JOIN customer AS cu
ON pa.customer_id = cu.customer_id; 


SELECT
payment_id,
payment.customer_id,
first_name,
last_name,
amount
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id;


SELECT 
staff.staff_id,
first_name,
last_name,
email,
amount
FROM payment
INNER JOIN staff
ON payment.staff_id = staff.staff_id
WHERE staff.staff_id=1
ORDER BY amount DESC;


