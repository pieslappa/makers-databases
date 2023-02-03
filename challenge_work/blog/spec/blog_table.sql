CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text
);

-- Then the table with the foreign key first.
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  content text,
  author text,
-- The foreign key name is always {other_table_singular}_id
  post_id int,
  CONSTRAINT fk_post FOREIGN KEY(post_id)
    REFERENCES posts(id)
    ON DELETE CASCADE
);