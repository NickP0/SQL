/*UNION theory
UNION Syntax:*/

SELECT first_name, sales FROM vancouver
UNION
SELECT first_name, sales FROM delhi

/* UNION  removes all duplicates
if we want to use duplicates we can use UNION ALL 
*/ 

-- UNION ALL syntax:

SELECT first_name, sales FROM vancouver
UNION ALL
SELECT first_name, sales FROM delhi;

--Example end. 

