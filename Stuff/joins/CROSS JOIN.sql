-- CROSS JOIN

SELECT 
staff_id,
store.store_id,
last_name,
store.store_id*staff_id
FROM staff
CROSS JOIN store




