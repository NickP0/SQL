SELECT * FROM tickets
-- ticket_no

SELECT * FROM boarding_passes
-- ticket_no

SELECT
COUNT(*)
FROM boarding_passes
FULL OUTER JOIN tickets
ON boarding_passes.ticket_no = tickets.ticket_no
WHERE boarding_passes.ticket_no IS null