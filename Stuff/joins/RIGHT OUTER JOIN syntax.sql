-- RIGHT OUTER JOIN examples

SELECT * FROM flights
RIGHT JOIN aircrafts_data
ON flights.aircraft_code = aircrafts_data.aircraft_code
WHERE flights.aircraft_code IS null