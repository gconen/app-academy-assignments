DROP TABLE users;
DROP TABLE questions;
DROP TABLE question_follows;
DROP TABLE replies;
DROP TABLE question_likes;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(20) NOT NULL,
  lname VARCHAR(20)
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255),
  body VARCHAR(255) NOT NULL,
  author_id INTEGER NOT NULL,
  FOREIGN KEY (author_id) REFERENCES questions(id)
);


CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  body VARCHAR(255) NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);


CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Alice', 'Smith'),
  ('Bob', 'Costas'),
  ('Carol', 'Carter'),
  ('David', 'Duval'),
  ('Emily', 'Esteban');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('What?', 'What is the meaning of life?', 1),
  ('Quest?', 'What is your quest?', 3),
  ('Air Speed?', 'What is the airspeed of an unladen swallow?', 2);

INSERT INTO
  replies (question_id, parent_id, user_id, body)
VALUES
  (1, NULL, 2, "42"), (1, 1, 1, "But, what's the question?");

INSERT INTO
  question_follows(question_id, user_id)
VALUES
  (1, 2), (1, 1), (2, 3), (1, 3), (3, 5), (2, 4);

INSERT INTO
  question_likes(question_id, user_id)
VALUES
  (1, 5), (1, 4), (1, 3), (3, 3);
