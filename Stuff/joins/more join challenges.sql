/* More JOIN challenges
1)Which passenger (passenger_name) has spent most amount in their bookings (total_amount)?
*/ 

SELECT * FROM bookings;
-- total_amount (book_ref, book_date)

SELECT * FROM tickets;
-- passenger_name (book_ref)

SELECT 
tickets.passenger_name,
SUM(bookings.total_amount)
FROM bookings
INNER JOIN tickets
ON bookings.book_ref = tickets.book_ref
GROUP BY tickets.passenger_name
ORDER BY SUM(bookings.total_amount) DESC

-- 2) Which fare_condition has ALEKSANDR IVANOV used the most?

SELECT * FROM bookings;
-- book_ref(1), book_date, total_amount

SELECT * FROM tickets; 
-- ticket_no(2), book_ref(1), passenger_id, passenger_name, contact_date

SELECT * FROM ticket_flights;
-- ticket_no(2), flight_id, fare_conditions, amount

SELECT 
passenger_name,
fare_conditions,
COUNT(*) 
FROM tickets
INNER JOIN bookings
ON tickets.book_ref = bookings.book_ref
INNER JOIN ticket_flights
ON tickets.ticket_no = ticket_flights.ticket_no
WHERE passenger_name = 'ALEKSANDR IVANOV'
GROUP BY fare_conditions, passenger_name;

SELECT 
passenger_name, 
fare_conditions, 
COUNT(*) 
FROM tickets 
INNER JOIN bookings 
ON tickets.book_ref=bookings.book_ref
INNER JOIN ticket_flights 
ON tickets.ticket_no=ticket_flights.ticket_no
WHERE passenger_name = 'ALEKSANDR IVANOV'
GROUP BY fare_conditions, passenger_name


