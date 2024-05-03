CREATE TABLE employee (
	employee_id INT,
	name VARCHAR (50),
	manager_id INT
);

INSERT INTO employee 
VALUES
	(1, 'Liam Smith', NULL),
	(2, 'Oliver Brown', 1),
	(3, 'Elijah Jones', 1),
	(4, 'William Miller', 1),
	(5, 'James Davis', 2),
	(6, 'Olivia Hernandez', 2),
	(7, 'Emma Lopez', 2),
	(8, 'Sophia Andersen', 2),
	(9, 'Mia Lee', 3),
	(10, 'Ava Robinson', 3);
	
-- Creating an employee table
SELECT * FROM employee;

-- Show every employees respective manager
SELECT
emp.employee_id,
emp.name AS employee,
mng.name AS manager
FROM employee AS emp
LEFT JOIN employee AS mng
ON emp.manager_id = mng.employee_id;

-- Another self-join; who is the managers' manager?
SELECT * FROM employee
SELECT
emp.employee_id,
emp.name AS employee,
mng.name AS manager,
mng2.name AS manager_of_mng
FROM employee AS emp
LEFT JOIN employee AS mng
ON emp.manager_id = mng.employee_id
LEFT JOIN employee AS mng2
ON mng.manager_id = mng2.employee_id;

/* Self join challenge:
Find all the pairs of films with the same length
Make sure that the same title isn't in the title
columns by adding a condition 
*/

SELECT
f1.title,
f2.title,
f2.length
FROM film AS f1
LEFT JOIN film AS f2
ON f1.length=f2.length
WHERE f1.title <> f2.title
ORDER BY length DESC
