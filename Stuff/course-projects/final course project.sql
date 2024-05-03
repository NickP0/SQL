CREATE DATABASE employee_db
WITH ENCODING = 'UTF-8';

COMMENT ON DATABASE employee_db IS 'course project';

-- Create employees table
CREATE TABLE employees (
	emp_id SERIAL PRIMARY KEY,
	first_name TEXT NOT NULL,
	last_name TEXT NOT NULL,
	job_position TEXT NOT NULL,
	salary NUMERIC (8,2),
	start_date DATE NOT NULL,
	birth_date DATE NOT NULL,
	store_id INT,
	department_id INT,
	manager_id INT
);

-- Testing employees table
SELECT * FROM employees;



-- Create departments table
CREATE TABLE departments (
	department_id SERIAL PRIMARY KEY,
	department TEXT,
	division TEXT
); 

