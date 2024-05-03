/* INNER JOIN challenge
An airline company wants to understand in which category they sell the most tickets
1) How many people chose seats in the following categories (seats and boarding_passes table): 
- Business
- Economy
- Comfort
*/

SELECT * FROM seats

-- seat_no, fare_conditions

SELECT * FROM boarding_passes

-- seat_no, boarding_no

SELECT
fare_conditions,
COUNT(*)
FROM seats
INNER JOIN boarding_passes
ON seats.seat_no = boarding_passes.seat_no
--WHERE fare_conditions IN ('Business','Comfort','Economy')
GROUP BY fare_conditions;





