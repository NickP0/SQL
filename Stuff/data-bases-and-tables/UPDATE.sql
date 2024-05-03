SELECT * FROM customer;

-- Change the last name of customer_id 1
UPDATE customer
SET last_name='BROWN'
WHERE customer_id=1;

-- See the UPDATED last name of customer_id 1
SELECT * FROM customer
ORDER BY customer_id;

-- Update all emails to be in lower case
UPDATE customer
SET email=LOWER(email);

/* UPDATE CHALLENGE:
Update all rental prices that are 0.99 to 1.99
Update the customer table:
1) Add the column 'initials' with the data type varchar 10
2) Update the values to the actual initials 
*/
SELECT * FROM payment
ORDER BY amount;

UPDATE payment
SET amount = 1.99
WHERE amount = 0.99;

SELECT * FROM customer;

ALTER TABLE customer
ADD COLUMN IF NOT EXISTS initials VARCHAR(10);

UPDATE customer
SET initials = LEFT(first_name,1)||
	initials = LEFT(last_name,1);
	
	
-- Course solution

UPDATE film
SET rental_rate = 1.99
WHERE rental_rate = 0.99;

SELECT * FROM film
ORDER BY film_id;

ALTER TABLE customer
ADD COLUMN IF NOT EXISTS initials VARCHAR(10);

UPDATE customer
SET initials = LEFT(first_name,1)
	||'.'||
	LEFT(last_name,1)
	||'.';
	
SELECT * FROM customer; 
	