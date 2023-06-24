-- Active: 1687640944323@@localhost@5432@cursodb@public
CREATE Table teste (
    id INT,
    name CHARACTER(200) NOT NULL,
    CONSTRAINT pk_id PRIMARY KEY (id)
);

SELECT * from teste;

CREATE SEQUENCE TEST_SEQ INCREMENT 1 START 1;

ALTER TABLE teste RENAME COLUMN name TO nome;

ALTER TABLE teste ALTER COLUMN id SET DEFAULT nextval('TEST_SEQ');


insert into teste (nome) VALUES ('Gaiola');