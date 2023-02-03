TRUNCATE TABLE posts RESTART IDENTITY CASCADE;
TRUNCATE TABLE comments RESTART IDENTITY;

INSERT INTO posts (title, content) VALUES('Hello', 'Hello, world!');
INSERT INTO posts (title, content) VALUES('Hello again', 'It is me, again!');
INSERT INTO posts (title, content) VALUES('Hello 3.0', 'Yep, still me!');

INSERT INTO comments (content, author, post_id) VALUES('This is great', 'Chris', 1);
INSERT INTO comments (content, author, post_id) VALUES('This is bad', 'Ben', 1);
INSERT INTO comments (content, author, post_id) VALUES('4 stars', 'Alfie', 2);
INSERT INTO comments (content, author, post_id) VALUES('1 star', 'Charles', 2);
INSERT INTO comments (content, author, post_id) VALUES('2 stars', 'Derek', 2);
INSERT INTO comments (content, author, post_id) VALUES('Stop now', 'Eric', 3);