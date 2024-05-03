/* 
Correlated Subquery in WHERE:

Show only those payments that have the 
highest amount per customer. 
*/

SELECT customer_id, amount FROM payment AS p1
WHERE amount =
(SELECT MAX(amount) FROM payment AS p2
WHERE p1.customer_id=p2.customer_id)
ORDER BY customer_id;


/* Correlated suquery in WHERE:
CHALLENGE: 
1) Show only movie titles, their associated film_id and 
replacement_cost with the lowest replacement_costs for in each
rating category - also show the rating.
*/ 

SELECT * FROM film

SELECT title, film_id, replacement_cost, rating FROM film AS f1
WHERE replacement_cost =
(SELECT MIN(replacement_cost) FROM film AS f2
WHERE f1.rating = f2.rating)
ORDER BY replacement_cost ASC

/*
2) Show only movie titles, their accociated film_id
and the length that has the highest length in each rating
category - also show the rating
*/
SELECT * FROM film

SELECT title, film_id, length, rating FROM film AS f1
WHERE length = 
(SELECT MAX(length) FROM film AS f2
WHERE f1.rating = f2.rating)
ORDER BY title 


