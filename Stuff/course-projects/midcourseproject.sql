-- Mid-course project 
/* 1) Level: Simple

Topic: DISTINCT

Task: Create a list of all the different (distinct) replacement costs of the films.

Question: What's the lowest replacement cost?
Answer: 9.99 */

SELECT DISTINCT
replacement_cost
FROM film
ORDER BY replacement_cost ASC

/* 2) Level: Moderate

Topic: CASE + GROUP BY

Task: Write a query that gives an overview of how many films have 
replacements costs in the following cost ranges

low: 9.99 - 19.99

medium: 20.00 - 24.99

high: 25.00 - 29.99

Question: How many films have a replacement cost in the "low" group?
Answer: 514 */

SELECT
replacement_cost,
COUNT(*),
CASE 
WHEN replacement_cost BETWEEN 9.99 AND 19.99 THEN 'low' 
WHEN replacement_cost BETWEEN 20.00 AND 24.99 THEN 'medium'
ELSE 'high'
END AS rep_cost_new
FROM film
GROUP BY replacement_cost;

/* 3) Level: Moderate

Topic: JOIN

Task: Create a list of the film titles including their 
title, length, and category name ordered descendingly by length. 
Filter the results to only the movies in the category 'Drama' or 'Sports'.

Question: In which category is the longest film and how long is it?
Answer: Sports and 184 */

SELECT * FROM film
-- film_id(1)
SELECT * FROM category
-- category_id(2), name, last_update
SELECT * FROM film_category
-- film_id(1), category_id(2) 

SELECT
title,
length,
category.name
FROM film
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON category.category_id = film_category.category_id
WHERE category.name IN ('Drama', 'Sports')
ORDER BY length DESC;

/* 4)
Level: Moderate

Topic: JOIN & GROUP BY

Task: Create an overview of how many movies (titles) 
there are in each category (name).

Question: Which category (name) is the most common among the films?
Answer: Sports with 74 titles */

SELECT
category.name,
COUNT(*)
FROM film
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON category.category_id = film_category.category_id
GROUP BY category.name
ORDER BY category.name;

/* 5)
Level: Moderate
Topic: JOIN & GROUP BY

Task: Create an overview of the actors' first and last names 
and in how many movies they appear in.

Question: Which actor is part of most movies??
Answer: Susan Davis with 54 movies */

SELECT * FROM actor
-- actor_id, first_name, last_name
SELECT * FROM film
-- film_id, 
SELECT * FROM film_actor
-- actor_id, film_id 

SELECT * FROM film_category
-- film_id, category_id
SELECT * FROM category
-- category_id, name

SELECT
actor.first_name,
actor.last_name, 
COUNT(*) AS movie_count
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
GROUP BY actor.first_name, actor.last_name
ORDER BY movie_count DESC

/* 6) Level: Moderate

Topic: LEFT JOIN & FILTERING

Task: Create an overview of the addresses 
that are not associated to any customer.
Question: How many addresses are that?

Answer: 4 */

SELECT * FROM address 
-- address_id, city_id 
SELECT * FROM customer
-- address_id, 
SELECT * FROM country
--country_id, country
SELECT * FROM city
--city_id, city, country_id 

SELECT 
COUNT(*) FROM address
LEFT JOIN customer
ON address.address_id = customer.address_id
LEFT JOIN city
ON address.city_id = city.city_id 
LEFT JOIN country 
ON city.country_id = country.country_id
WHERE customer.* IS null;

/* 7) Level: Moderate

Topic: JOIN & GROUP BY

Task: Create an overview of the cities and how much sales (sum of amount) have occurred there.

Question: Which city has the most sales?
Answer: Cape Coral with a total amount of 221.55 */


SELECT * FROM city
-- city_id, country_id 
SELECT * FROM payment  -
--customer_id(1), (amount) 
SELECT * FROM country 
-- country_id,
SELECT * FROM customer - 
-- customer_id(1), address_id(2)
SELECT * FROM address
-- city_id, address_id(2)

SELECT 
city,
SUM(amount) AS total_amount
FROM payment
INNER JOIN customer 
ON payment.customer_id = customer.customer_id
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id 
GROUP BY city
ORDER BY total_amount DESC
LIMIT 1

/* 8) Level: Moderate to difficult

Topic: JOIN & GROUP BY

Task: Create an overview of the revenue (sum of amount) grouped by a column in the format "country, city".

Question: Which country, city has the least sales?
Answer: United States, Tallahassee with a total amount of 50.85. */
SELECT 
country,
city,
SUM(amount) AS total_amount
FROM payment
INNER JOIN customer 
ON payment.customer_id = customer.customer_id
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id 
GROUP BY country, city
ORDER BY total_amount 
LIMIT 1


/* 9) Level: Difficult

Topic: Uncorrelated subquery

Task: Create a list with the average of the sales amount for each staff_id per customer.

Question: Which staff_id makes on average more revenue per customer?
Answer: staff_id 2 with an average revenue of 56.64 per customer. */ 

SELECT * FROM payment
--staff_id, amount, customer 

SELECT
staff_id,
ROUND(AVG(avg_amount),2)
FROM
(SELECT
staff_id, customer_id, SUM(amount) AS avg_amount FROM payment
GROUP BY customer_id, staff_id)
GROUP BY staff_id

/* 10) Level: Difficult to very difficult

Topic: EXTRACT + Uncorrelated subquery

Task: Create a query that shows average daily revenue of all Sundays.

Question: What is the daily average revenue of all Sundays?
Answer: 1410.65 */


-- my answer was wrong... 

SELECT 
AVG(avg_revenue)
FROM
(SELECT
payment_date,
SUM(amount) AS avg_revenue,
EXTRACT(DOW FROM payment_date) AS DOW
FROM payment
WHERE EXTRACT(DOW FROM payment_date) = 0
GROUP BY DOW, payment_date);


-- correct answer - I was very close. 
SELECT
ROUND(AVG(avg_rev),2)
FROM
(SELECT
DATE(payment_date),
EXTRACT(DOW FROM payment_date) AS DOW,
SUM(amount) AS avg_rev
FROM payment
WHERE EXTRACT(DOW FROM payment_date) = 0
GROUP BY DATE(payment_date), EXTRACT(DOW FROM payment_date));


/* 11) Level: Difficult to very difficult

Topic: Correlated subquery

Task: Create a list of movies - 
with their length and their replacement cost - 
that are longer than the average length in each replacement cost group.

Question: Which two movies are the shortest on that list 
and how long are they?
Answer: CELEBRITY HORN and SEATTLE EXPECTATIONS with 110 minutes.*/ 

SELECT * FROM film
-- title, length, replacement_cost, AVG(length)

SELECT title, length, replacement_cost FROM film AS f1
WHERE length > (SELECT
			   AVG(length) 
			   FROM film AS f2
			   WHERE f1.replacement_cost = f2.replacement_cost)
ORDER BY length;

/* 12) Level: Very difficult

Topic: Uncorrelated subquery

Task: Create a list that shows the "average customer lifetime value" grouped by the different districts.

Example:
If there are two customers in 
"District 1" where one customer has a total (lifetime) spent of $1000 and 
the second customer has a total spent of $2000 then
the "average customer lifetime spent" in this district is $1500.

So, first, you need to calculate the total per customer and
then the average of these totals per district.

Question: Which district has the highest average customer lifetime value?

Answer: Saint-Denis with an average customer lifetime value of 216.54.*/

SELECT
district,
ROUND(AVG(district_avg),2) AS avg_value
FROM
(SELECT
address.district,
payment.customer_id,
SUM(amount) AS district_avg
FROM payment
INNER JOIN customer 
ON payment.customer_id = customer.customer_id
INNER JOIN address
ON customer.address_id = address.address_id
GROUP BY address.district, payment.customer_id)
GROUP BY district
ORDER BY AVG(district_avg) DESC


/* 13) Level: Very difficult

Topic: Correlated query

Task: Create a list that shows all payments 
including the payment_id, amount, and the film category (name) 
plus the total amount that was made in this category. 
Order the results ascendingly by the category (name) and 
as second order criterion by the payment_id ascendingly.

Question: What is the total revenue of the category 'Action' and 
what is the lowest payment_id in that category 'Action'?

Answer: Total revenue in the category 'Action' is 4375.85 and 
the lowest payment_id in that category is 16055.*/ 

-- payment_id, amount, name (film category)
SELECT * FROM payment
-- rental_id(1)
SELECT * FROM rental
-- rental_id(1), inventory_id(2) 

SELECT * FROM inventory
-- inventory_id(2), film_id(3)

SELECT * FROM film_category
-- film_id(3), inventory_id, category_id(4)

SELECT * FROM category
-- category_id(4), (name)

  
SELECT payment_id, p1.amount, c2.name, 
(
	SELECT 
	SUM(amount) 
	FROM payment AS p2

	INNER JOIN rental AS r
	ON p2.rental_id = r.rental_id
	INNER JOIN inventory AS i
	ON r.inventory_id = i.inventory_id
	INNER JOIN film_category AS fc1
	ON i.film_id = fc1.film_id
	INNER JOIN category AS c1
	ON fc1.category_id = c1.category_id
	WHERE p1.payment_id = p2.payment_id
	GROUP BY p2.amount, c2.name)
	FROM payment AS p1
	
	INNER JOIN rental AS r
	ON p1.rental_id = r.rental_id
	INNER JOIN inventory AS i
	ON r.inventory_id = i.inventory_id
	INNER JOIN film_category AS fc
	ON i.film_id = fc.film_id
	INNER JOIN category AS c2
	ON fc.category_id = c2.category_id
	
WHERE c2.name = 'Action'
GROUP BY p1.amount, p1.payment_id, c2.name
ORDER BY c2.name ASC, p1.payment_id ASC;



SELECT COUNT(*) FROM film
WHERE 'Behind the Scenes' = ANY(special_features)