-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

-- TRUNCATE TABLE artists RESTART IDENTITY;
TRUNCATE TABLE albums RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.


INSERT INTO albums (title, release_year, artist_id) VALUES ('Thriller', '1982', 1);
INSERT INTO albums (title, release_year, artist_id) VALUES ('Bad', '1987', 1);
INSERT INTO albums (title, release_year, artist_id) VALUES ('Hotel California', '1976', 2);