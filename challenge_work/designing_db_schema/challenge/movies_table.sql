CREATE TABLE movies (
  id SERIAL PRIMARY KEY,
  title text,
  genre text,
  release_year int
);

INSERT INTO movies (title, genre, release_year) VALUES('Step Brothers', 'Comedy', '2008');
INSERT INTO movies (title, genre, release_year) VALUES('Saving Private Ryan', 'War', '1998');
INSERT INTO movies (title, genre, release_year) VALUES('Dirty Dancing', 'Romance', '1987');