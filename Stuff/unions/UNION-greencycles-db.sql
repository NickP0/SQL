--UNION 
SELECT first_name FROM actor
UNION
SELECT first_name FROM customer
ORDER BY first_name;

--UNION ALL
SELECT first_name FROM actor
UNION ALL
SELECT first_name FROM customer
ORDER BY first_name;

/* Using UNION ALL to compile first names from different 
tables - also giving an alias to this new table 
*/
SELECT first_name, 'actor' AS original_table FROM actor 
UNION ALL
SELECT first_name, 'customer' FROM customer
ORDER BY first_name;

-- UNION can be used to join rows from multiple tables

SELECT first_name, 'actor' AS original_table FROM actor
UNION ALL 
SELECT first_name, 'customer' FROM customer
UNION ALL 
SELECT UPPER(first_name) AS first_name, 'staff' FROM staff
ORDER BY original_table DESC