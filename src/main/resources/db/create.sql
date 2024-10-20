CREATE
DATABASE coursewave;
USE
coursewave;

CREATE TABLE users (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       name VARCHAR(100) NOT NULL,
                       login VARCHAR(50) NOT NULL UNIQUE,
                       email VARCHAR(100) NOT NULL UNIQUE,
                       password VARCHAR(255) NOT NULL,
                       role ENUM('student', 'teacher') NOT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE courses (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         title VARCHAR(255) NOT NULL,
                         description TEXT NOT NULL,
                         hours INT NOT NULL,
                         created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

CREATE TABLE links (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       course_id INT NOT NULL,
                       name VARCHAR(255) NOT NULL,
                       type ENUM('pdf', 'video', 'drive', 'image') NOT NULL,
                       url VARCHAR(255) NOT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);

CREATE TABLE enrollment (
                     user_id int NOT NULL,
                     course_id int NOT NULL,
                     enrollment_date timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                     completed tinyint(1) DEFAULT '0',
                     PRIMARY KEY (user_id, course_id),
                     KEY course_id (course_id),
                     CONSTRAINT enrollment_ibfk_1 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
                     CONSTRAINT enrollment_ibfk_2 FOREIGN KEY (course_id) REFERENCES courses (id) ON DELETE CASCADE
)