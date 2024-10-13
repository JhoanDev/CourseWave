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
                         teacher_id INT,
                         created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                         FOREIGN KEY (teacher_id) REFERENCES users(id) ON DELETE SET NULL
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
