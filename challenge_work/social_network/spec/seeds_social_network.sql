TRUNCATE TABLE users RESTART IDENTITY CASCADE;
TRUNCATE TABLE posts RESTART IDENTITY;

INSERT INTO users (email_address, username) VALUES ('hello@cleech.uk', 'cdog');
INSERT INTO users (email_address, username) VALUES ('adam@hello.uk', 'adoggydogg');

INSERT INTO posts (title, content, views, user_id) VALUES ('Hello World', 'I just wanted to say hello', 1, 1);
INSERT INTO posts (title, content, views, user_id) VALUES ('Hello Again', 'I just wanted to say hello again', 5, 1);
INSERT INTO posts (title, content, views, user_id) VALUES ('Hello', 'I also wanted to say hello', 3, 2);