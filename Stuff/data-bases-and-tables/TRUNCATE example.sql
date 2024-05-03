-- TRUNCATE example
-- Create table
CREATE TABLE emp_table
(emp_id SERIAL PRIMARY KEY,
 emp_name TEXT );
 
-- Select table
SELECT * FROM emp_table

-- Drop table
DROP TABLE emp_table

-- Insert rows
INSERT INTO emp_table
VALUES 
(1, 'Frank'),
(2, 'Maria')

-- Select table
SELECT * FROM emp_table

-- Truncate table
TRUNCATE emp_table

