CREATE
DATABASE coursewave;
USE
coursewave;

CREATE TABLE users
(
    id       INT AUTO_INCREMENT PRIMARY KEY,
    name     VARCHAR(50)  NOT NULL,
    login    VARCHAR(20)  NOT NULL,
    email    VARCHAR(100) NOT NULL,
    password VARCHAR(150) NOT NULL,
    role     VARCHAR(8)   NOT NULL -- Pode ser 'student' ou 'teacher'
);
