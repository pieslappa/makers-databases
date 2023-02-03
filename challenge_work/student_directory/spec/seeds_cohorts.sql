TRUNCATE TABLE cohorts RESTART IDENTITY CASCADE;
TRUNCATE students RESTART IDENTITY;

INSERT INTO cohorts (name, start_date) VALUES('Oct 22', '2022-10-01');
INSERT INTO cohorts (name, start_date) VALUES('Dec 22', '2022-12-01');
INSERT INTO cohorts (name, start_date) VALUES('Jan 23', '2023-01-01');

INSERT INTO students (name, cohort_id) VALUES('A', 1);
INSERT INTO students (name, cohort_id) VALUES('B', 1);
INSERT INTO students (name, cohort_id) VALUES('C', 1);
INSERT INTO students (name, cohort_id) VALUES('H', 2);
INSERT INTO students (name, cohort_id) VALUES('I', 2);
INSERT INTO students (name, cohort_id) VALUES('W', 3);
INSERT INTO students (name, cohort_id) VALUES('X', 3);
INSERT INTO students (name, cohort_id) VALUES('Y', 3);
INSERT INTO students (name, cohort_id) VALUES('Z', 3);
