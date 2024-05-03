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


-- CREATE VIEW

DROP TABLE customer_spendings

CREATE VIEW customer_spendings
AS 
SELECT first_name ||' '|| last_name AS name, 
SUM(amount) AS total_amount
FROM customer 
LEFT JOIN payment 
ON customer.customer_id = payment.customer_id
GROUP BY first_name ||' '|| last_name;

SELECT * FROM customer_spendings;


/* CREATE VIEW CHALLENGE
Create a view called films_category that shows 
a list of the film titles including their title, 
length and category name ordered descendingly by the length.

Filter the results to only the movies in the category 'Action' and 'Comedy'.
*/

CREATE VIEW films_category
AS
SELECT
title, length, name
FROM film
LEFT JOIN film_category
ON film.film_id = film_category.film_id
LEFT JOIN category
ON film_category.category_id = category.category_id
WHERE name IN ('Action', 'Comedy')
ORDER BY length DESC

-- MATERIALIZED VIEWS

CREATE MATERIALIZED VIEW mv_film_category
AS
SELECT
title, length, name
FROM film
LEFT JOIN film_category
ON film.film_id = film_category.film_id
LEFT JOIN category
ON film_category.category_id = category.category_id
WHERE name IN ('Action', 'Comedy')
ORDER BY length DESC;

SELECT * FROM mv_film_category;

-- Note that this update will not be reflected in our MV
UPDATE film
SET LENGTH = 192
WHERE title = 'SATURN NAME';

-- Below query will update the data
REFRESH MATERIALIZED VIEW mv_film_category;

SELECT * FROM mv_film_category;

-- MANAGING VIEWS challenge: 

CREATE VIEW v_customer_info
AS 
SELECT cu.customer_id,
    cu.first_name || ' ' || cu.last_name AS name,
    a.address,
    a.postal_code,
    a.phone,
    city.city,
    country.country
     FROM customer cu
     JOIN address a ON cu.address_id = a.address_id
     JOIN city ON a.city_id = city.city_id
     JOIN country ON city.country_id = country.country_id
ORDER BY customer_id;

--Rename the view to v_customer_information.

ALTER VIEW v_customer_info
RENAME TO v_customer_information;

--Rename the customer_id column to c_id.

SELECT * FROM v_customer_information;

ALTER VIEW v_customer_information
RENAME COLUMN customer_id TO c_id;

--Add also the initial column as the last column to the view by replacing the view.

CREATE OR REPLACE VIEW v_customer_information
AS 
SELECT cu.customer_id AS c_id,
    cu.first_name || ' ' || cu.last_name AS name,
    a.address,
    a.postal_code,
    a.phone,
    city.city,
    country.country,
	LEFT(cu.first_name,1)||'.'|| LEFT(cu.last_name,1)||'.' AS initials
     FROM customer cu
     JOIN address a ON cu.address_id = a.address_id
     JOIN city ON a.city_id = city.city_id
     JOIN country ON city.country_id = country.country_id
ORDER BY c_id;

SELECT * FROM v_customer_information;

/* My original query had the initials column come after the AS name column, 
for some reason this gave back a syntax error: 
The issue with the original query seems to be related to the positioning of the 
initials column in the SELECT clause. 
In PostgreSQL, when you create a view, 
the column positions in the SELECT clause are significant, 
and any subsequent changes to the view that affect the positions of existing columns may result in errors.
*/
