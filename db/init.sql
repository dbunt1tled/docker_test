CREATE TABLE IF NOT EXISTS test (
    id serial PRIMARY KEY,
    name varchar(255) NOT NULL
);

INSERT INTO test (name) VALUES ('test');
