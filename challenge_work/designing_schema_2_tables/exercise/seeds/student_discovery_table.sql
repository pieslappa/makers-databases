CREATE TABLE cohorts (
  id SERIAL PRIMARY KEY,
  cohort_name text,
  start_date text
);

-- Then the table with the foreign key.
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  student_name text,
-- The foreign key name is always {other_table_singular}_id
  artist_id int,
  constraint fk_student foreign key(cohort_id)
    references cohorts(id)
    on delete cascade
);