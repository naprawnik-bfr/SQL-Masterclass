-- DAY 9 TABLES AND DATABESE MANAGEMENT:

/* Challenge 1: DATA DEFINITION  -> CREATING TABLE
Create a table called online_sales with the following columns:
transaction_id 				/Transaction_id shoul be the primary key.
customer_id					/The columns customer_id and film_id should be foreign keys to the relevant tables.
film_id
amount						/The amount column can contain values from 0.00 to 999.99 - nulls should not be allowed.
promotion_code				/The column promotion_code contains a promotion code of at maximum 10 characters. If there is no value you should set the default value 'None'.*/

CREATE TABLE online_sales (
transaction_id SERIAL PRIMARY KEY,
customer_id INT REFERENCES customer(customer_id),
film_id INT REFERENCES film(film_id),
amount NUMERIC(5,2) NOT NULL,
promotion_code VARCHAR(10) DEFAULT 'NONE'
);

-- Challenge 2: DATA DEFINITION -> CREATING TABLE
CREATE TABLE director (
	director_id SERIAL PRIMARY KEY,
	director_account_name VARCHAR(20) UNIQUE,
	first_name VARCHAR(50),
	last_name VARCHAR(50) DEFAULT 'Not specified', 
	date_of_birth DATE,
	address_id INT REFERENCES address(address_id)
);

-- Challenge 3: DATA MANIPULATION -> INSERTING VALUES
INSERT INTO online_sales (customer_id, film_id,amount,promotion_code)
VALUES 
(124,65,14.99,'PROMO2022'),
(225,231,12.99,'JULYPROMO'),
(119,53,15.99,'SUMMERDEAL');

-- Challenge 4: DATA DEFINITION -> ALTERING TABLE
ALTER TABLE director
ALTER COLUMN director_account_name TYPE VARCHAR(30),
ALTER COLUMN last_name DROP DEFAULT,
ALTER COLUMN last_name SET NOT NULL,
ADD COLUMN email VARCHAR(40);

ALTER TABLE director
RENAME COLUMN director_account_name TO account_name;

ALTER TABLE director
RENAME TO directors;

-- Challenge 5: DATA DEFINITION -> CHECK CONSTRAINT
CREATE TABLE songs (
	song_id SERIAL CONSTRAINT my_p_k PRIMARY KEY,
	song_name VARCHAR(30)  NOT NULL,
	genre VARCHAR(30)  DEFAULT 'Not defined',
	price NUMERIC(4,2) CHECK(price >= 1.99),
	release_date DATE  CONSTRAINT date_check CHECK(release_date BETWEEN '01-01-1950' AND CURRENT_DATE)
);

--CHECK:
INSERT INTO songs
(song_name, price, release_date)
VALUES ('SQL SONG', 2.99, '2022-01-07');

-- Challenge 6: DATA MANIPULATION -> UPDATING VALUES
SELECT * FROM film
ORDER BY film_id;

UPDATE film
SET rental_rate = 1.99
WHERE rental_rate = 0.99;

ALTER TABLE customer
ADD COLUMN initials VARCHAR(10);

UPDATE customer
SET initials = LEFT(first_name,1) || '.' || LEFT(last_name,1) || '.';

SELECT * FROM customer
ORDER BY customer_id;

-- Challenge 6: DATA MANIPULATION -> DELETING VALUES
-- !!! ALWAYS USE "SELECT * FROM"  BEFORE "DELETE FROM"
SELECT * FROM payment 
WHERE payment_id IN (17064, 17067);

-->

DELETE FROM payment 
WHERE payment_id IN (17064, 17067)
RETURNING *;

