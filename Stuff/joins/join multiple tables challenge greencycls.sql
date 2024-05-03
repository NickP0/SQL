/* Second challenge:
The company wants to customise their campaigns to customers
depending on what country they're from. 
Which customers are from Brazil?

Write a query to get:
first_name, last_name, email, country (Brazil)
*/


SELECT * FROM customer;

-- first_name, last_name, email, - address_id

SELECT * FROM country;

-- country, (country_id)? -last_update? 

SELECT * FROM address

-- city_id

SELECT * FROM city

-- city_id, country_id

SELECT * FROM country

-- country_id

-- Going to use INNER JOIN to compile information

SELECT
first_name,
last_name,
email,
country.country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON city.city_id = address.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country.country = 'Brazil' -- we don't need to specify which table this column comes from as it isn't ambiguous 