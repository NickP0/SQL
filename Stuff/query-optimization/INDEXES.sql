-- Indexes

SELECT * FROM payment;

-- Below query will need an index
SELECT 
(SELECT AVG(amount)
 FROM payment p2
 WHERE p2.rental_id=p1.rental_id)
 FROM payment p1;
 
-- Create index for rental_id column in payment table
CREATE INDEX index_rental_id_payment
ON payment
(rental_id);

-- Drop the index then test out the query again
DROP INDEX index_rental_id_payment;

-- Use the explain tool on the initial query for a breakdown on why the query takes so long to run

-- Challenge (wrong db)
SELECT * FROM flights f2
WHERE flight_no < (SELECT MAX(flight_no)
				  FROM flights f1
				   WHERE f1.departure_airport=f2.departure_airport
				   )
				   
				   
-- Query explain example

SELECT rental_id FROM payment
WHERE rental_id BETWEEN 1 AND 22;

SELECT * FROM payment
LEFT JOIN customer
ON customer.customer_id=payment.customer_id;

SELECT * FROM payment
LEFT JOIN customer
ON customer.customer_id=payment.customer_id
WHERE payment.customer_id BETWEEN 4 AND 50
ORDER BY 1
LIMIT 100;