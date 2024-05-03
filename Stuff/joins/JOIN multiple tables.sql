-- JOINING multiple tables theory

SELECT * FROM tickets;

SELECT * FROM flights;
 
SELECT * FROM ticket_flights;

-- JOINING multiple tables challenge. 

SELECT 
tickets.ticket_no,
passenger_name,
flights.scheduled_departure
FROM tickets
INNER JOIN ticket_flights
ON tickets.ticket_no = ticket_flights.ticket_no
INNER JOIN flights
ON ticket_flights.flight_id = flights.flight_id;

SELECT
tickets.ticket_no,
passenger_name,
flights.scheduled_departure
FROM ticket_flights
INNER JOIN tickets
ON tickets.ticket_no = ticket_flights.ticket_no
INNER JOIN flights
ON flights.flight_id = ticket_flights.flight_id;
