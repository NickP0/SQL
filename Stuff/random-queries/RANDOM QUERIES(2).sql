SELECT
TO_CHAR(book_date,'Dy'),
TO_CHAR(book_date,'Mon'),
CASE
	WHEN TO_CHAR(book_date,'Dy')='Mon'THEN'Monday special'
	WHEN TO_CHAR(book_date,'Dy')='Jul'THEN'July special'
	ELSE 'no special'
END
FROM bookings;

SELECT
total_amount,
TO_CHAR(book_date,'Dy'),
CASE
	WHEN TO_CHAR(book_date,'Dy')='Mon'THEN'Monday Special'
	WHEN total_amount < 30000 THEN 'Special deal'
	ELSE 'no special at all'
END
FROM bookings;

SELECT
total_amount,
TO_CHAR(book_date,'Dy'),
CASE
	WHEN TO_CHAR(book_date,'Dy')='Mon'THEN'Monday Special'
	WHEN total_amount*1.4 < 30000 THEN'Special Deal'
	ELSE 'no special at all'
END
FROM bookings;
/*
below query is same as above but using TAB to separate to make it 
more legible.
*/
SELECT
total_amount,
TO_CHAR(book_date,'Dy'),
CASE
	WHEN TO_CHAR(book_date,'Dy')='Mon'THEN'Monday Special'
	WHEN total_amount*1.4 < 30000 THEN'Special Deal'
	ELSE 'no special at all'
END
FROM bookings

SELECT
COUNT(*) AS flights,
CASE
	WHEN actual_departure IS null THEN 'no departure time'
	WHEN actual_departure-scheduled_departure < '00:05:00'THEN 'On time'
	WHEN actual_departure-scheduled_departure < '01:00:00'THEN 'Moderately late'
	ELSE 'Extremely Late'
END AS is_late
FROM flights
GROUP BY is_late

/* 
CASE WHEN challenge below:
1) You need to find out how many tickets you have sold in the following categories:
- low price: total_amount < 20,000
- medium price: total_amount BETWEEN 20,000 150,000
- high price: total_amount >= 150,000

How many high price tickets has the company sold?
*/
SELECT * FROM bookings

SELECT
COUNT(*),
CASE
	WHEN total_amount < 20000 THEN 'low price'
	WHEN total_amount < 150000 THEN 'mid price'
	ELSE 'high price'
END
FROM bookings
GROUP BY total_amount;

SELECT ticket_price, count(*)
FROM(SELECT
book_ref,
CASE
	WHEN total_amount < 20000 THEN 'low price ticket'
	WHEN total_amount < 150000 THEN 'mid price ticket'
	ELSE 'high price ticket'
	END as ticket_price
FROM bookings) 
GROUP BY ticket_price; -- this is the correct answer but need to figure it out.



SELECT
COUNT(*),
CASE
	WHEN total_amount < 20000 THEN 'low price'
	WHEN total_amount < 150000 THEN 'mid price'
	ELSE 'high price'
END AS ticket_price
FROM bookings
GROUP BY ticket_price


-- REDO CASE WHEN lecture and challenges

SELECT
COUNT(*) AS flights,
CASE
	WHEN actual_departure-scheduled_departure IS null THEN 'no depart time'
	WHEN actual_departure-scheduled_departure < '00:05:00'THEN'on time'
	WHEN actual_departure-scheduled_departure < '01:00:00'THEN'very late'
	ELSE 'late'
END AS is_late
FROM
flights
GROUP BY is_late;

-- challenge

SELECT * FROM bookings

SELECT
COUNT(*),
CASE
	WHEN total_amount < 20000 THEN 'low_price_ticket'
	WHEN total_amount < 150000 THEN 'mid_price_ticket'
	ELSE 'high_price_ticket'
END AS ticket_price
FROM 
bookings
GROUP BY ticket_price
ORDER BY ticket_price DESC;


--2)

SELECT * FROM flights

SELECT
COUNT(scheduled_departure) AS flights,
CASE
	WHEN EXTRACT(MONTH FROM scheduled_departure) IN (12,1,2) THEN 'Winter'
	WHEN EXTRACT(MONTH FROM scheduled_departure)  <= 5 THEN 'Spring'
	WHEN EXTRACT(MONTH FROM scheduled_departure)  <= 8 THEN 'Summer'
	ELSE 'Fall'
END AS season
FROM flights
GROUP BY season;

--3) 
-- redo question 1

SELECT * FROM bookings

SELECT
COUNT(*),
CASE
	WHEN total_amount < 20000 THEN 'low_price_ticket'
	WHEN total_amount < 150000 THEN 'mid_price_ticket'
	ELSE 'high_price_ticket'
END as ticket_price
FROM bookings
GROUP BY ticket_price

-- redo question 2

SELECT * FROM flights

SELECT
COUNT(*) AS flights,
CASE
	WHEN EXTRACT(MONTH FROM scheduled_departure) IN (12,1,2) THEN 'Winter'
	WHEN EXTRACT(MONTH FROM scheduled_departure) <= 5 THEN 'Spring'
	WHEN EXTRACT(MONTH FROM scheduled_departure) <= 8 THEN 'Summer'
	ELSE 'Fall'
END as season
FROM flights
GROUP BY season;



-- Challenge walkthrough
-- 1)
SELECT 
COUNT(*) AS flights,
CASE
	WHEN total_amount < 20000 THEN 'low price ticket'
	WHEN total_amount < 150000 THEN 'mid price ticket'
	ELSE 'high price ticket'
END AS ticket_price
FROM bookings
GROUP BY ticket_price

--2)
SELECT
COUNT(*) AS flights,
CASE	
	WHEN EXTRACT(MONTH FROM scheduled_departure) IN (12,1,2) THEN 'Winter'
	WHEN EXTRACT (MONTH FROM scheduled_departure) <= 5 THEN 'Spring'
	WHEN EXTRACT (MONTH FROM scheduled_departure) <= 8 THEN 'Summer'
	ELSE 'Fall'
END AS season
FROM flights
GROUP BY season 
	
	
	
	
SELECT
COUNT(*),
CASE
	WHEN total_amount < 20000 THEN 'low price ticket'
	WHEN total_amount < 150000 THEN 'mid price ticket'
	ELSE 'high price ticket'
END AS ticket_price
FROM bookings
GROUP BY ticket_price;


SELECT
COUNT (*) AS flights,
CASE
	WHEN EXTRACT(MONTH FROM scheduled_departure) IN (12,1,2) THEN 'Winter'
	WHEN EXTRACT(MONTH FROM scheduled_departure) <= 5 THEN ' spring'
	WHEN EXTRACT(MONTH FROM scheduled_departure) <= 8 THEN 'summer'
	ELSE 'Fall'
END AS seasons
FROM flights
GROUP BY seasons;
/*
below query isn't part of this database
*/
SELECT
title,
CASE
	WHEN rating IN ('PG','PG-13') OR (LENGTH IS NOT NULL AND LENGTH > 210) THEN 'Great rating or very long (t1)'
	WHEN description LIKE '%Drama%' OR (LENGTH IS NOT NULL AND LENGTH > 90) THEN 'long drama (t2)'
	WHEN description LIKE '%Drama%' THEN 'short drama'
	WHEN rental_rate < 1 THEN 'very cheap'
END
FROM film






--COALESCE function lecture/examples

SELECT
actual_arrival,
scheduled_arrival,
COALESCE(actual_arrival,scheduled_arrival) 
FROM flights;

SELECT
actual_arrival,
scheduled_arrival,
COALESCE(actual_arrival, '1970-01-01 0:00')
FROM flights;

SELECT
scheduled_arrival,
COALESCE(actual_arrival-scheduled_arrival, '0:00') AS different_arrival_time,
CASE
	WHEN COALESCE(actual_arrival-scheduled_arrival, '0:00')  = '0:00' THEN 'on time'
	WHEN COALESCE(actual_arrival-scheduled_arrival, '0:00')  <= '0:10' THEN 'a little late'
	ELSE 'very late'
END AS arrivals
FROM flights;

SELECT
actual_arrival,
scheduled_arrival,
COALESCE(actual_arrival, '1970-01-01 0:00')
FROM flights;

SELECT
COALESCE(actual_arrival-scheduled_arrival,'0:00')
FROM flights;

SELECT
COALESCE(CAST(actual_arrival-scheduled_arrival AS VARCHAR),'not arrived')
FROM flights;


SELECT
COALESCE(CAST(actual_arrival-scheduled_arrival AS VARCHAR),'not arrived')
FROM flights


SELECT
LENGTH(CAST(actual_arrival AS VARCHAR))
FROM flights

SELECT 
*,
CAST(ticket_no AS bigint)
FROM tickets

--REPLACE

SELECT
REPLACE (flight_no, 'PG', '')
FROM flights

-- use replace below on passenger id from tickets db
SELECT
passenger_id,
REPLACE (passenger_id, ' ','') AS passenger_id
FROM tickets

SELECT
passenger_id,
CAST(REPLACE(passenger_id, ' ','') AS BIGINT)
FROM tickets;

SELECT
flight_no,
CAST(REPLACE(flight_no, 'PG', '') AS INT)
FROM
flights;




