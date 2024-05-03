/* Create a UDF that is calculating/counting the no. films 
that is in a specific range for the rental rate.

We want to insert two parameters :
minimal rental rate
maximum rental rate

The number of movies within this range should be returned
*/

CREATE FUNCTION count_rr (min_r DECIMAL(4,2), max_r DECIMAL(4,2))
RETURNS INT
LANGUAGE plpgsql 
AS
$$
DECLARE movie_count INT;
BEGIN 
SELECT COUNT(*)
INTO movie_count
FROM film
WHERE rental_rate BETWEEN min_r AND max_r;
RETURN movie_count;
END
$$

-- test UDF

SELECT count_rr(3,6);

-- query used to make UDF
SELECT 
COUNT(*)
FROM film
WHERE rental_rate BETWEEN 3 AND 6;

/* Create a function that expects the customer first and last name as parameters
and returns the total amount of payments this customer has made
*/ 

SELECT * FROM customer; -- customer_id;

SELECT * FROM payment; -- customer_id;

--my query (bare in mind, I used TEXT data type initially)
CREATE FUNCTION name_search (f_name VARCHAR(20), l_name VARCHAR(20))
RETURNS DECIMAL(6,2)
LANGUAGE plpgsql
AS
$$
DECLARE total_amount DECIMAL(6,2);
BEGIN
SELECT SUM(amount)
INTO total_amount
FROM payment
LEFT JOIN customer
ON payment.customer_id = customer.customer_id
WHERE customer.first_name = name_search.f_name
AND customer.last_name = name_search.l_name;
RETURN total_amount;
END
$$


SELECT name_search ('AMY','LOPEZ')

--lecturer query 

CREATE OR REPLACE FUNCTION name_search1 (f_name VARCHAR(20), l_name VARCHAR(20))
RETURNS DECIMAL(6,2)
LANGUAGE plpgsql
AS
$$
DECLARE total_amount DECIMAL(6,2);
BEGIN
SELECT SUM(amount)
INTO total_amount
FROM payment
NATURAL LEFT JOIN customer
WHERE first_name = f_name
AND last_name = l_name;
RETURN total_amount;
END;
$$

SELECT name_search1 ('AMY','LOPEZ');

SELECT
first_name,
last_name,
name_search(first_name,last_name) -- we should insert arguments into this
FROM customer
WHERE first_name = 'AMY'

/* Quick note re: UDF

My function worked absolutely fine.
*/ 