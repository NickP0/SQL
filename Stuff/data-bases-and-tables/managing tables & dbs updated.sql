-- Create director table
CREATE TABLE director
(director_id SERIAL PRIMARY KEY,
director_account_name VARCHAR(20) UNIQUE, 
first_name VARCHAR(50),
last_name VARCHAR(50) DEFAULT 'Not specified',
date_of_birth DATE,
address_id INT REFERENCES address(address_id));

-- Create online_sales table
CREATE TABLE online_sales
(transaction_id SERIAL PRIMARY KEY,
customer_id INT REFERENCES customer(customer_id),
film_id INT REFERENCES film(film_id),
amount NUMERIC(5,2) NOT NULL,  
promotion_code VARCHAR(10) DEFAULT 'None'); 

-- Insert values into online_sales table
INSERT INTO online_sales
VALUES (1, 269, 13, 10.99, 'BUNDLE2022');

SELECT * FROM online_sales

-- Insert Into challenge: 
INSERT INTO online_sales 
VALUES (1, 124, 65, 14.99, 'PROMO2022'),
(2, 225, 231, 12.99, 'JULYPROMO'),
(3, 119, 54, 15.99, 'SUMMERDEAL')

-- Correct answer (mine isn't wrong)
INSERT INTO online_sales (customer_id, film_id,amount,promotion_code)
VALUES 
(124,65,14.99,'PROMO2022'),
(225,231,12.99,'JULYPROMO'),
(119,53,15.99,'SUMMERDEAL')
-- remember that transaction_id is a primary key 

--ALTER TABLE challenge
SELECT * FROM director

CREATE TABLE director
(director_id SERIAL PRIMARY KEY,
director_account_name VARCHAR(20) UNIQUE, 
first_name VARCHAR(50),
last_name VARCHAR(50) DEFAULT 'Not specified',
date_of_birth DATE,
address_id INT REFERENCES address(address_id));


ALTER TABLE director
ALTER COLUMN director_account_name TYPE VARCHAR(30),
ALTER COLUMN last_name DROP DEFAULT,
ALTER COLUMN last_name SET NOT NULL,
ADD COLUMN IF NOT EXISTS email VARCHAR(40);

ALTER TABLE director
RENAME COLUMN director_account_name TO account_name;

ALTER TABLE director
RENAME TO directors;

SELECT * FROM directors;



