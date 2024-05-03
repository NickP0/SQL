/* JOIN CHALLENGE 
1)The company wants to run a phone call campaign on all cuatomers in Texas.
Which customers (including all their information) are from Texas?
2)Are there any old addresses that are not related to any customer?
*/

--1)
SELECT * FROM customer;
--address_id

SELECT * FROM address;
--address_id

SELECT
first_name,
last_name,
phone,
district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE address.district = 'Texas'


--2)
SELECT * FROM address
LEFT JOIN customer
ON customer.address_id = address.address_id
WHERE customer.* IS null
ORDER BY address.address_id