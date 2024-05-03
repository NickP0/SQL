-- DELETE

INSERT INTO songs(song_name, genre, price, release_date)
VALUES 
	( 'Have a talk with Data', 'Chill out', 5.99, '01-06-2022'),
	( 'Tame the Data', 'Classical', 4.99, '01-06-2022');
	
SELECT * FROM songs;

DELETE FROM songs
WHERE genre='Not defined';

DELETE FROM songs
WHERE song_id IN (1,2)
RETURNING song_name, song_id;

/* DELETE challenge 
Delete rows in the payment table with ids:
17064 and 17067
*/

SELECT * FROM payment;

DELETE FROM payment
WHERE payment_id IN (17064,17067)
RETURNING payment_id;

SELECT * FROM payment
WHERE payment_id IN (17064,17067);