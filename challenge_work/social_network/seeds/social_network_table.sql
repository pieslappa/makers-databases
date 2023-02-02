CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email_address text,
  username text
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  views int,
  user_id int,
  CONSTRAINT fk_user FOREIGN KEY(user_id)
    REFERENCES users(id)
    ON DELETE CASCADE
);