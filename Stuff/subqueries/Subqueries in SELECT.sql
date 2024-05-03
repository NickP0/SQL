SELECT
*, (SELECT ROUND(AVG(amount),2) FROM payment)
FROM payment;

/*Above query works because the information 
we get from it is a single value (round: 4.20)
*/

SELECT
*, (SELECT amount FROM payment)
FROM payment

--above query doesn't work as it returns multiple values - not possible to execute.
-- subquery below work as we use LIMIT 1 aka scalar subquery, 
SELECT
*, (SELECT amount FROM payment LIMIT 1) AS single_value
FROM payment


/*
Challenge: Subqueries in SELECT:
Show all the payments together with how much the 
payment amount is below the maximum payment amount
*/
SELECT
*, (SELECT MAX(amount) FROM payment) - amount AS difference
FROM payment

-- Challenge solution

SELECT 
*, (SELECT MAX(amount) FROM payment) - amount AS difference
FROM payment