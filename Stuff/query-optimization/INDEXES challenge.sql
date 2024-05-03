-- Challenge
SELECT * FROM flights f2
WHERE flight_no < (SELECT MAX(flight_no)
				  FROM flights f1
				   WHERE f1.departure_airport=f2.departure_airport
				   )
				   
-- Create index

CREATE INDEX flight_index
ON flights
(flight_no, departure_airport);

-- 