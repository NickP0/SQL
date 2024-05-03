-- CONSTRAINT challenge:

/* create a table called 'songs' with the following columns
- song_id (primary key)
- song_name (VARCHAR (30)) 
- genre (VARCHAR (30))
- price (numeric 4,2)
- release_date (DATE)

1) During creation, add the DEFAULT 'Not defined' to the genre.
2) Add the not null constraint to the song_name column.
3) Add the constraint with default name to ensure the price
is at least 1.99.
4) Add the constraint date_check to ensure the release date is 
between today and 01-01-1950.
5) Try to insert a row:
[REFER TO VIDEO] 
6) Modify the constraint to be able to have 0.99 allowed as the
lowest possible price.
7) Try again to insert the row.
*/
-- Create a songs table
CREATE TABLE songs
(song_id SERIAL PRIMARY KEY,
song_name VARCHAR(30) NOT NULL,
genre VARCHAR (30) DEFAULT 'Not defined', 
price NUMERIC(4,2) CHECK (price >= 1.99) ,
release_date DATE CONSTRAINT date_check CHECK(release_date BETWEEN '01-01-1950' AND CURRENT_DATE));

-- Insert values into Songs table
INSERT INTO songs
(song_id, song_name, price, release_date)
VALUES 
(4, 'SQL song', 0.99, '07-01-2022');

-- Drop Constraint of price >= 1.99
ALTER TABLE songs
DROP CONSTRAINT songs_price_check;

-- Alter songs table, price as the above INSERT doesn't work
ALTER TABLE songs
ADD CONSTRAINT price CHECK (price >= 0.99);

-- SELECT songs
SELECT * FROM songs;




-- Course solution

CREATE TABLE songs
(song_id SERIAL PRIMARY KEY,
song_name VARCHAR(30) NOT NULL,
genre VARCHAR(30) DEFAULT 'Not defined',
price NUMERIC (4,2) CHECK(price>=1.99),
release_date DATE CONSTRAINT date_check CHECK(release_date BETWEEN '01-01-1950' AND CURRENT_DATE));

INSERT INTO songs (song_name, price, release_date)
VALUES ( 'SQL song', 0.99, '01-07-2022');

ALTER TABLE songs
DROP CONSTRAINT songs_price_check;

ALTER TABLE songs
ADD CONSTRAINT songs_price_check CHECK(price>=0.99);

