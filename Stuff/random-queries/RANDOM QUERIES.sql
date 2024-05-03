SELECT
staff_id,
SUM(amount) AS sum_amount_employee,
COUNT(*)
FROM payment
GROUP BY staff_id
ORDER BY staff_id;

SELECT
staff_id,
SUM(amount) AS sum_amount_employee,
COUNT(*)
FROM payment
WHERE amount <> 0
GROUP BY staff_id
ORDER BY staff_id;

SELECT
staff_id,
customer_id,
SUM(amount) AS sum_amount_employee,
COUNT(*)
FROM payment
GROUP BY staff_id,customer_id
ORDER BY COUNT(*) DESC;

SELECT
staff_id,
rental_id,
SUM(amount),
COUNT(*)
FROM payment
GROUP BY staff_id,rental_id
ORDER BY COUNT(*) DESC;

-- below query is for the GROUP BY multiple columns challenge

SELECT
*
FROM payment;

-- Question 1)
SELECT
DATE(payment_date),
staff_id,
SUM(amount),
COUNT(*)
FROM payment
GROUP BY DATE(payment_date),staff_id
ORDER BY COUNT(*) DESC;
-- Question 2
SELECT 
DATE(payment_date),
staff_id,
SUM(amount),
COUNT(*)
FROM payment
WHERE amount != 0
GROUP BY DATE(payment_date),staff_id--,amount
ORDER BY COUNT(*) DESC;
-- TEST CHALLENGE
SELECT 
*
FROM payment;

SELECT
DATE(payment_date),
staff_id,
SUM(amount),
COUNT(*)
FROM payment
GROUP BY DATE(payment_date),staff_id
ORDER BY COUNT(*) DESC;
--2
SELECT
DATE(payment_date),
staff_id,
SUM(amount) AS amount_total,
COUNT(*) AS highest_sales
FROM payment
WHERE amount <> 0
GROUP BY DATE(payment_date),staff_id 
HAVING SUM(amount) > 400
ORDER BY COUNT(*) DESC; 

/* Example of using HAVING clause in a GROUP BY clause
will be shown below */

SELECT
customer_id,
SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount)>200;

SELECT
DATE(payment_date),
staff_id,
SUM(amount),
COUNT(*)
FROM payment
WHERE amount <> 0
GROUP BY DATE(payment_date),staff_id
HAVING COUNT(*) > 400;

SELECT
DATE(payment_date),
staff_id,
SUM(amount),
COUNT(*)
FROM payment
WHERE amount <> 0
GROUP BY DATE(payment_date),staff_id
HAVING COUNT(*) = 28 OR COUNT(*) 29
ORDER BY COUNT(*) DESC;

/*Challenge:

In 2020, April 28, 29 and 30 were days with very high revenue. 
We want to focus on these days only and filter accordingly. 

Find out what is the average payment amount grouped by customer and day 
- consider only the days/customers with more than 1 payment 
(per customer and day)
Order the average amount in a descending order. 
*/

--1 
SELECT 
customer_id,
DATE(payment_date),
ROUND(AVG (amount),2) AS average_payment,
COUNT(*)
FROM payment 
WHERE DATE(payment_date) BETWEEN '2020-04-28' AND '2020-04-30 23:59'
GROUP BY customer_id,DATE(payment_date)
HAVING COUNT(*) > 1
ORDER BY ROUND(AVG (amount),2) DESC
/*Issue with this challenge is that I was being an idiot. 
I forgot to include the HAVING clause in the HAVING challenge... */
-- Below is another way to get the same answer as above. 
SELECT
customer_id,
DATE(payment_date),
ROUND(AVG (amount),2) AS average_payment,
COUNT(*)
FROM payment
WHERE DATE(payment_date) IN ('2020-04-28','2020-04-29','2020-04-30')
GROUP BY customer_id,DATE(payment_date)
HAVING COUNT(*) > 1
--ORDER BY ROUND(AVG (amount),2) DESC
ORDER BY 3 DESC

-- Using UPPER, LOWER and LENGTH example below. 
SELECT
UPPER(email) AS email_upper,
LOWER(email) AS email_lower,
LENGTH(email) AS email_length,
email
FROM customer
WHERE LENGTH(email) >30 

/* CHALLENGE for UPPER, LOWER and LENGTH
In the email system there was a problem with names where either 
the first name or the last name is more than 10 characters long. 
Find these customers and output the list of these first and last names in all lower case. */

SELECT * FROM customer;

SELECT
LOWER(first_name) AS first_name_l,
LOWER(last_name) AS last_name_l,
LOWER(email) AS email_l
FROM customer
WHERE LENGTH (first_name) > 10
OR LENGTH (last_name) > 10;

SELECT
RIGHT(LEFT(first_name,2),1),
first_name
FROM customer;

/* Challenge for using LEFT, RIGHT, UPPER functions
Q: Extract the last 5 characters of the email address first. 
The email address always ends with .org
How can you extract just with dot '.' from the email address?
*/

SELECT
email
FROM customer;
--1)
SELECT
email,
RIGHT(email,5)
FROM customer;
--2)
SELECT
email,
LEFT(RIGHT(email,4),1)
FROM customer

/* Concatenate: ||
example below */
SELECT
LEFT (first_name,1) ||'.'|| LEFT (last_name,1) || '.' AS initials,
first_name,
last_name
FROM customer;

/* Concatenate challenge:
Anonymize email address - It should be the first character followed by '***'
and then the last part starting with '@'. All email addresses always end
with '@sakilacustomer.org'. */

SELECT
LEFT (email,1) ||'***'|| RIGHT(email,19) AS anon_email
FROM customer;

-- POSITION


SELECT
LEFT(email,POSITION(last_name IN email)-2),
email
FROM customer;

SELECT
LEFT(email,POSITION(last_name IN email)-2) AS first_name,
email
FROM customer;

/* POSITION & concatenation (||) challenge:
You only have the email address and the last name of the customers
(email,last_name).
You need to extract the first name from the email address and concatenate 
it with the last name. It should be in the form: "Last name, First name". */

SELECT 
email,
last_name
FROM customer;

SELECT
LEFT(last_name,POSITION('.' IN email)) || '.' || LEFT(email,POSITION('.' IN email)-1) 
AS last_first_name,
email
FROM customer; -- easier way to do this is below

-- the easier way:
SELECT
last_name ||', '|| LEFT(email,POSITION('.' IN email)-1)AS last_first_name,
email
FROM customer -- go over this challenge again. 

-- SUBSTRING function

SELECT
email,
SUBSTRING (email FROM POSITION ('.' IN email))
FROM customer;

SELECT
email,
SUBSTRING (email FROM POSITION ('.' IN email) FOR 3)
FROM customer;

SELECT
email,
SUBSTRING (email FROM POSITION ('.' IN email)+1 FOR LENGTH(last_name))
FROM customer;

SELECT
email,
SUBSTRING(email FROM 3 FOR 2)
FROM customer;

SELECT
email,
SUBSTRING (email FROM POSITION ('.' IN EMAIL)+1 FOR POSITION('@' IN email)-POSITION('.' IN email)-1)
FROM customer
-- above code is long and pointless. 
-- Below is the SUBSTRING challenge. 
-- 1)
SELECT
LEFT(email,1) 
|| '***' 
|| SUBSTRING(email FROM POSITION ('.' IN email)FOR 2)
|| '***' 
|| SUBSTRING(email FROM POSITION ('@' IN email))
FROM customer;

-- 2)
SELECT
'***' 
|| SUBSTRING(email FROM POSITION ('.' IN email)-1 FOR 3)
|| '***' 
|| SUBSTRING(email FROM POSITION ('@' IN email))
FROM customer;
-- EXTRACT
SELECT 
rental_date,
EXTRACT (EPOCH FROM rental_date)
FROM rental;

SELECT
EXTRACT(MONTH FROM rental_date),
COUNT(*)
FROM rental
GROUP BY EXTRACT(MONTH FROM rental_date)
ORDER BY COUNT(*) DESC;

-- EXTRACT Challenge
SELECT * FROM payment;

--1) What is the month with the highest total payment amount?
SELECT
EXTRACT (MONTH FROM payment_date) AS month_,
SUM(amount) AS total_payment_amount
FROM payment
GROUP BY EXTRACT (MONTH FROM payment_date)
ORDER BY SUM(amount) DESC LIMIT 2;
--2) What is the day of the week with the highest total payment amount?
SELECT
EXTRACT (DOW FROM payment_date) AS day_of_week,
SUM(amount) AS total_payment_amount
FROM payment
GROUP BY EXTRACT (DOW FROM payment_date)
ORDER BY SUM(amount) DESC LIMIT 2;
--3) What is the highest amount a customer has spend in a week?
SELECT
EXTRACT(WEEK FROM payment_date) AS week,
customer_id,
SUM(amount) AS total_payment_amount
FROM payment
GROUP BY EXTRACT(WEEK FROM payment_date),customer_id
ORDER BY SUM(amount) DESC LIMIT 3;
--TO_CHAR function:
SELECT
*,
EXTRACT(MONTH FROM payment_date) AS MONTH,
TO_CHAR(payment_date, 'YYYY-MM') as yr_mm
FROM payment;

/* TO_CHAR syntax
TO_CHAR(date/time/interval/number, format e.g. 'MM-YYYY') */

SELECT
SUM(amount),
EXTRACT(MONTH FROM payment_date) AS MONTH,
TO_CHAR(payment_date,'MM/DD/YYYY')
FROM payment
GROUP BY TO_CHAR(payment_date,'MM/DD/YYYY'),EXTRACT(MONTH FROM payment_date)

/* TO_CHAR challenge: You need to sum payments and group in the following formats:
Day format, Month and Year, Week day and time (hrs and minutes) */
--1)
SELECT 
SUM(amount) AS total_amount,
TO_CHAR(payment_date, 'Dy, DD/MM/YYYY') AS Day
FROM payment
GROUP BY TO_CHAR(payment_date, 'Dy, DD/MM/YYYY')
ORDER BY SUM(amount) DESC LIMIT 2
--2)
SELECT
SUM(amount) AS total_amount,
TO_CHAR(payment_date, 'Mon, YYYY') AS month_year
FROM payment
GROUP BY TO_char (payment_date, 'Mon, YYYY') 
ORDER BY SUM(amount) LIMIT 2
--3)
SELECT
SUM(amount) AS total_amount,
TO_CHAR(payment_date, 'Dy, HH:MI')
FROM payment
GROUP BY TO_CHAR(payment_date, 'Dy, HH:MI')
ORDER BY SUM(amount) DESC

-- Timestamps and intervals

SELECT 
CURRENT_TIMESTAMP,
EXTRACT(DAY FROM return_date-rental_date)*24
+ EXTRACT(HOUR FROM return_date-rental_date) || ' hours'
FROM rental;

/* Challenge: 
You need to create a list for the support team of 
all rental durations of customers with customer_id 35.
Also you need to find out which customer has the longest
average rental duration?
*/

SELECT 
customer_id,
EXTRACT(DAY FROM return_date-rental_date)
|| ' days '
|| EXTRACT(HOUR FROM return_date-rental_date)
FROM rental
WHERE customer_id = 35;


--test

SELECT 
customer_id,
EXTRACT(DAY FROM return_date-rental_date) AS 
|| ' days '
|| EXTRACT(HOUR FROM return_date-rental_date)
|| ':'
|| EXTRACT(MINUTE FROM return_date-rental_date)
|| ':'
|| EXTRACT(MILLISECOND FROM return_date-rental_date)
FROM rental
WHERE customer_id = 35;

SELECT
customer_id,
return_date-rental_date AS rental_duration
FROM rental
WHERE customer_id=35;

SELECT
customer_id,
AVG(return_date-rental_date) AS rental_duration
FROM rental
GROUP BY customer_id 
ORDER BY rental_duration DESC


--Day 4 Challenge recap
--1)

SELECT
LOWER(first_name),
LOWER(last_name),
LOWER(email)
FROM customer
WHERE LENGTH (first_name) > 10
OR LENGTH(last_name) > 10

--2) 

SELECT
email,
last_name || ', ' || first_name AS last_first_name
FROM customer

--3) 

SELECT
LEFT(RIGHT(email,4),1),
RIGHT(email,+5)
FROM customer

--4) SUBSTRINGS: examples and challenge answers 

SELECT
SUBSTRING(email FROM 1 FOR 2)
FROM customer;

SELECT
LEFT(email,1)
|| '***'
|| SUBSTRING (email FROM POSITION ('.' IN email)FOR 2)
|| '***'
|| SUBSTRING (email FROM POSITION ('@' IN email))
FROM customer;

SELECT
'***'
|| SUBSTRING (email FROM POSITION ('.' IN email)-1 FOR 3)
|| '***'
|| SUBSTRING (email FROM POSITION ('@' IN email))
FROM customer;

SELECT
*,
EXTRACT(DOY FROM rental_date)
FROM rental;


SELECT
SUM(amount) AS total_amount,
EXTRACT(MONTH FROM payment_date) AS month
FROM payment
GROUP BY EXTRACT(MONTH FROM payment_date)
ORDER BY SUM(amount) DESC LIMIT 2;

SELECT
SUM(amount) AS total_amount,
EXTRACT(DOW FROM payment_date) AS day_of_week
FROM payment
GROUP BY EXTRACT(DOW FROM payment_date)
ORDER BY SUM(amount) DESC LIMIT 2;

SELECT
EXTRACT(WEEK FROM payment_date),
customer_id,
SUM(amount)
FROM payment
GROUP BY EXTRACT(WEEK FROM payment_date),customer_id
ORDER BY SUM(amount) DESC LIMIT 3;

SELECT
SUM(amount) AS total_amount,
TO_CHAR(payment_date,'Dy, DD/MM/YYYY') AS day
FROM payment
GROUP BY TO_CHAR(payment_date,'Dy, DD/MM/YYYY')
ORDER BY SUM(amount) LIMIT 2;

SELECT
SUM(amount),
TO_CHAR(payment_date,'Mon, YYYY')
FROM payment
GROUP BY TO_CHAR(payment_date,'Mon, YYYY')
ORDER BY SUM(amount) LIMIT 2

SELECT
SUM(amount), 
TO_CHAR(payment_date,'Dy, HH:MI')
FROM payment
GROUP BY TO_CHAR(payment_date,'Dy, HH:MI')
ORDER BY SUM(amount) DESC LIMIT 2;

SELECT * FROM rental;

SELECT
customer_id,
return_date-rental_date
FROM rental
WHERE customer_id = 35;

SELECT
customer_id,
AVG(return_date-rental_date)
FROM rental
GROUP BY customer_id
ORDER BY AVG(return_date-rental_date) DESC;

-- End of day 4 challenges

-- Math functions and operators

SELECT
film_id,
rental_rate AS old_rental_rate,
ROUND(rental_rate*1.4,2) AS new_rental_rate
FROM film


SELECT
film_id,
rental_rate AS old_rental_rate,
CEILING(rental_rate*1.4)-0.01 AS new_rental_rate
FROM film 


SELECT
ROUND(9.0/4,2)

SELECT 9%4

SELECT
SUM(replacement_cost)/SUM(rental_rate)*100
FROM film

SELECT
film_id,
rental_rate AS old_rental_rate,
rental_rate+1 AS new_rental_rate
FROM film

SELECT
film_id,
rental_rate AS old_rental_rate,
CEILING(rental_rate*1.4)-0.01 AS new_rental_rate
FROM film
-- Mathematical functions and operators challenge
SELECT
film_id,
rental_rate,
replacement_cost,
ROUND(rental_rate/replacement_cost*100,2) AS percentage
FROM film
WHERE ROUND(rental_rate/replacement_cost*100,2) < 4
ORDER BY ROUND(rental_rate/replacement_cost*100,2) ASC
-- this answer is correct, but will provide the course solution below:

-- solution:
SELECT
film_id,
ROUND(rental_rate/replacement_cost*100,2) AS percentage
FROM film
WHERE ROUND(rental_rate/replacement_cost*100,2) < 4
ORDER BY ROUND(rental_rate/replacement_cost*100,2)

-- end of solution 

-- Syntax example of using CASE below:
SELECT
amount,
CASE
WHEN amount < 2 THEN 'low amount'
WHEN amount < 5 THEN 'medium amount'
ELSE 'high amount'
END
FROM payment
ORDER BY amount DESC;
-- another syntax example of using CASE below not related to any tables: 
SELECT
TO_CHAR(book_date,'Dy'),
TO_CHAR(book_date,'Mon'),
CASE
WHEN TO_CHAR(book_date,'Dy')='Mon'THEN'Monday special'
WHEN TO_CHAR(book_date,'Dy')-'Jul'THEN'July special'
END
FROM bookings;


SELECT * FROM film

SELECT
title,
CASE 
	WHEN rating IN ('PG', 'PG-13') OR LENGTH > 210 THEN 'Great rating or long (tier1)'
	WHEN description LIKE '%Drama%' OR LENGTH > 90 THEN 'Long drama (tier2)'
	WHEN description LIKE '%Drama%' OR LENGTH < 90 THEN 'Short drama (tier3)'
	WHEN rental_rate < 1 THEN 'Very cheap (tier4)'
END AS tiers
FROM film
GROUP BY title, tiers
ORDER BY tiers

SELECT * FROM film
-- answer (correct) below
SELECT
title,
CASE
	WHEN rating IN ('PG','PG-13') OR length > 210 THEN 'Great rating or long (tier 1)'
	WHEN description LIKE '%Drama%' AND length>90 THEN 'Long drama (tier 2)'
	WHEN description LIKE '%Drama%' THEN 'Short drama (tier 3)'
	WHEN rental_rate<1 THEN 'Very cheap (tier 4)'
END as tier_list
FROM film
WHERE 
CASE
	WHEN rating IN ('PG','PG-13') OR length > 210 THEN 'Great rating or long (tier 1)'
	WHEN description LIKE '%Drama%' AND length>90 THEN 'Long drama (tier 2)'
	WHEN description LIKE '%Drama%' THEN 'Short drama (tier 3)'
	WHEN rental_rate<1 THEN 'Very cheap (tier 4)'
END is not null

/*
- title 
- IN
-LENGTH 
-LIKE '%x%'
-AS
-IN
-LENGTH
-LIKE '%x%'
-
*/


SELECT
title,
CASE
	WHEN rating IN ('PG', 'PG-13') OR LENGTH > 210 THEN 'Great rating'
	WHEN description LIKE '%Drama%' OR LENGTH > 90 THEN 'Med rating'
	WHEN desription LIKE '%Drama%' THEN ''
	

SELECT
title,
CASE
	WHEN rating IN ('PG','PG-13') OR LENGTH > 210 THEN 'Great rating'
	WHEN description LIKE '%Drama%' AND LENGTH > 90 THEN 'Med rating'
	WHEN description LIKE '%Drama%' THEN 'Short movie'
	WHEN rental_rate < 1 THEN 'very cheap'
END AS tier_list
FROM film
WHERE 	
CASE
	WHEN rating IN ('PG','PG-13') OR LENGTH > 210 THEN 'Great rating'
	WHEN description LIKE '%Drama%' AND LENGTH > 90 THEN 'Med rating'
	WHEN description LIKE '%Drama%' THEN 'Short movie'
	WHEN rental_rate < 1 THEN 'very cheap'
END IS NOT null;


SELECT
rating,
SUM(CASE
	WHEN rating IN ('PG', 'G', 'R', 'NC-17', 'PG-13') THEN 1 
	ELSE 0
END) AS no_of_rating
FROM film
GROUP BY rating;
-- table pivot below.
SELECT
SUM(CASE WHEN rating = 'G' THEN 1 ELSE 0 END) AS "G",
SUM(CASE WHEN rating = 'R' THEN 1 ELSE 0 END) AS "R",
SUM(CASE WHEN rating = 'NC-17' THEN 1 ELSE 0 END) AS "NC-17",
SUM(CASE WHEN rating = 'PG-13' THEN 1 ELSE 0 END) AS "PG-13",
SUM(CASE WHEN rating = 'PG' THEN 1 ELSE 0 END) AS "PG"
FROM film;


--CASE WHEN with SUM scenario redo

SELECT 
rating,
SUM(CASE
	WHEN rating IN ('PG','G', 'R', 'NC-17', 'PG-13') THEN 1
	ELSE 0
END) no_of_ratings
FROM film
GROUP by rating


-- Pivot table redo
SELECT 
SUM(CASE WHEN rating = 'PG' THEN 1 ELSE 0 END) AS "PG",
SUM(CASE WHEN rating = 'R' THEN 1 ELSE 0 END) AS "R",
SUM(CASE WHEN rating = 'PG-13' THEN 1 ELSE 0 END) AS "PG-13",
SUM(CASE WHEN rating = 'NC-17' THEN 1 ELSE 0 END) AS "NC-17",
SUM(CASE WHEN rating = 'G' THEN 1 ELSE 0 END) AS "G"
FROM film;

-- Challenge: COALESCE and CAST 
SELECT
rental_date,
return_date,
COALESCE(CAST(return_date AS VARCHAR), 'not returned')
FROM rental
ORDER BY rental_date DESC

