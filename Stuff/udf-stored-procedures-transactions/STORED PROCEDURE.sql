-- Stored Procedure


CREATE OR REPLACE PROCEDURE sp_tranfer -- lol I spelled transfer wrong >.>
(tr_amount INT, sender INT, recipient INT)
LANGUAGE plpgsql
AS
$$
BEGIN
-- add balance
UPDATE acc_balance
SET amount = amount + tr_amount
WHERE ID = recipient;
-- subtract balance from sender
UPDATE acc_balance
SET amount = amount - tr_amount
WHERE ID = sender;
COMMIT;
END;
$$


CALL sp_tranfer (500, 1, 2); -- check if stored procedure works

SELECT * FROM acc_balance; -- check updated balance

-- STORED PROCEDURE challenge
/* create a stored procedure called emp_swap that accepts two
parameter emp1 and emp2 as input and swaps the two employees' position &
salary
*/

SELECT * FROM employees
ORDER BY emp_id;

CREATE OR REPLACE PROCEDURE emp_swap
(emp1 INT, emp2 INT)
LANGUAGE plpgsql
AS
$$
DECLARE
position1 TEXT;
salary1 DECIMAL(8,2); -- I used INT initially
position2 TEXT;
salary2 DECIMAL(8,2);
BEGIN
-- info from emp1
SELECT position_title, salary INTO position1, salary1
FROM employees
WHERE emp_id = emp1;
-- info from emp2
SELECT position_title, salary INTO position2, salary2
FROM employees
WHERE emp_id = emp2;
-- Update emp1 values with emp2
UPDATE employees
SET position_title = position2, 
	salary = salary2
WHERE emp_id = emp1;
-- Update emp2 values with emp1
UPDATE employees
SET position_title = position1, 
	salary = salary1
WHERE emp_id = emp2;
-- Commit
COMMIT;
END;
$$

-- this query was wrong.

-- the right query.

CREATE OR REPLACE PROCEDURE emp_swap (emp1 INT, emp2 INT)
LANGUAGE plpgsql
AS
$$
DECLARE 
salary1 DECIMAL (8,2);
salary2 DECIMAL (8,2);
position1 TEXT;
position2 TEXT;
BEGIN 
-- Store values in variable
SELECT salary
INTO salary1 
FROM employees
WHERE emp_id = 1;
-- Store values in variable
SELECT salary
INTO salary2
FROM employees
WHERE emp_id =2;
-- Store values in variable
SELECT position_title
INTO position1
FROM employees
WHERE emp_id = 1;
-- Store values in variable
SELECT position_title
INTO position2
FROM employees
WHERE emp_id = 2;
-- Update salary
UPDATE employees
SET salary = salary2
WHERE emp_id = 1;
-- Update salary
UPDATE employees
SET salary = salary1
WHERE emp_id = 2;
-- Update position title
UPDATE employees
SET position_title = position2
WHERE emp_id = 1;
-- Update position title
UPDATE employees
SET position_title = position1
WHERE emp_id = 2;
COMMIT;
END;
$$

CALL emp_swap (1,2);

SELECT * FROM employees
ORDER BY emp_id;