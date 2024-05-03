SELECT COUNT(*) FROM aircrafts_data
LEFT JOIN flights	
ON aircrafts_data.aircraft_code = flights.aircraft_code
WHERE flights.actual_departure IS null;


SELECT * FROM flights


/* Challenge: Find out which flight seats are most popular.
i.e., which seats have been chosen most frequently. 
Are there seats that have never been booked?
*/ 

SELECT * FROM seats
-- seat_no

SELECT * FROM boarding_passes
-- seat_no

SELECT
boarding_passes.seat_no,
COUNT(*)
FROM boarding_passes
LEFT JOIN seats
ON seats.seat_no = boarding_passes.seat_no
GROUP BY boarding_passes.seat_no
ORDER BY COUNT(*) DESC;

/* Challenge 2: Find out which seat line (A, B, etc.)
has been chosen most frequently */

SELECT
    SUBSTRING(seats.seat_no FROM '[A-Z]+'),
    COUNT(*)
FROM seats
LEFT JOIN boarding_passes
ON seats.seat_no = boarding_passes.seat_no
GROUP BY SUBSTRING(seats.seat_no FROM '[A-Z]+')
ORDER BY COUNT(*) DESC;

/*I got the above query from ChatGPT - we haven't 
learned about '[A-Z]+'
*/ 


/* Challenge 2: Find out which seat line (A, B, etc.)
has been chosen most frequently */

SELECT
RIGHT(boarding_passes.seat_no,1),
COUNT(*)
FROM boarding_passes
LEFT JOIN seats
ON seats.seat_no = boarding_passes.seat_no
GROUP BY RIGHT(boarding_passes.seat_no,1)
ORDER BY COUNT(*) DESC;