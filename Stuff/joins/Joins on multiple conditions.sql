-- Multiple join conditions theory

SELECT * FROM ticket_flights;

SELECT * FROM boarding_passes;

SELECT * FROM boarding_passes
ORDER BY ticket_no
/* Joins on Multiple Conditions Challenge: 
Figure out the average amount that a ticket costs per seat number. 
What is the most expensive ticket?
*/
SELECT 
ROUND(AVG(amount),2) AS avg_amount,
B.seat_no
FROM ticket_flights AS A
INNER JOIN boarding_passes as B
ON A.ticket_no = B.ticket_no
AND A.flight_id = B.flight_id
GROUP BY B.seat_no
ORDER BY avg_amount DESC
