
-- UNF (un-normalized Form)
create database university_managment_System; 
use university_managment_System;
CREATE TABLE university_data_unf (
    student_id INT,
    student_name VARCHAR(100),
    student_email VARCHAR(100),
    phone VARCHAR(15),

    department_id INT,
    department_name VARCHAR(100),
    office_location VARCHAR(100),

    course_code VARCHAR(10),
    course_name VARCHAR(100),
    credits INT,

    faculty_id INT,
    faculty_name VARCHAR(100),

    semester VARCHAR(10),
    grade CHAR(2)
);

INSERT INTO university_data_unf VALUES
(101, 'Aarav Sharma', 'aarav@gmail.com', '9876543210',
 10, 'Computer Science', 'Block A',
 'CS101', 'Database Systems', 4,
 501, 'Dr. Mehta',
 'Sem1', 'A'),

(101, 'Aarav Sharma', 'aarav@gmail.com', '9876543210',
 10, 'Computer Science', 'Block A',
 'CS102', 'Operating Systems', 4,
 502, 'Dr. Rao',
 'Sem1', 'B'),

(102, 'Priya Verma', 'priya@gmail.com', '9876501234',
 20, 'Electronics', 'Block B',
 'EC201', 'Digital Electronics', 3,
 503, 'Dr. Singh',
 'Sem1', 'A'),

(103, 'Rohan Patel', 'rohan@gmail.com', '9123456789',
 10, 'Computer Science', 'Block A',
 'CS101', 'Database Systems', 4,
 501, 'Dr. Mehta',
 'Sem2', 'A');
 
 -- Final UNF table
 
 SELECT * FROM university_managment_system.university_data_unf;
 
 -- 1NF (1st Normal Form)
 -- Table 1
 CREATE TABLE university_data_1nf (
    student_id INT,
    student_name VARCHAR(100),
    student_email VARCHAR(100),
    phone VARCHAR(15),

    department_id INT,
    department_name VARCHAR(100),
    office_location VARCHAR(100),

    course_code VARCHAR(10),
    course_name VARCHAR(100),
    credits INT,

    faculty_id INT,
    faculty_name VARCHAR(100),

    semester VARCHAR(10),
    grade CHAR(2),

    PRIMARY KEY (student_id, course_code, semester)
);

-- Inserting data into 1nf table
INSERT INTO university_data_1nf VALUES
(101,'Aarav Sharma','aarav@gmail.com','9876543210',
 10,'Computer Science','Block A',
 'CS101','Database Systems',4,
 501,'Dr. Mehta','Sem1','A'),

(101,'Aarav Sharma','aarav@gmail.com','9876543210',
 10,'Computer Science','Block A',
 'CS102','Operating Systems',4,
 502,'Dr. Rao','Sem1','B'),

(102,'Priya Verma','priya@gmail.com','9876501234',
 20,'Electronics','Block B',
 'EC201','Digital Electronics',3,
 503,'Dr. Singh','Sem1','A'),

(103,'Rohan Patel','rohan@gmail.com','9123456789',
 10,'Computer Science','Block A',
 'CS101','Database Systems',4,
 501,'Dr. Mehta','Sem2','A');
 
 -- Final 1NF Table
 SELECT * FROM university_managment_system.university_data_1nf;
 
 -- 2NF - Second Normal Form
 
 -- Table 1
 -- creating Student table1
 CREATE TABLE student_2nf (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    student_email VARCHAR(100),
    phone VARCHAR(15),
    department_id INT
) ENGINE=InnoDB;


-- inserting data into Student 2NF table
INSERT INTO student_2nf VALUES
(101,'Aarav Sharma','aarav@gmail.com','9876543210',10),
(102,'Priya Verma','priya@gmail.com','9876501234',20),
(103,'Rohan Patel','rohan@gmail.com','9123456789',10);
 
 
 -- Table 2
 -- creating course 2nf table
 CREATE TABLE course_2nf (
    course_code VARCHAR(10) PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT,
    faculty_id INT
) ENGINE=InnoDB;


-- inserting data into course  table
INSERT INTO course_2nf VALUES
('CS101','Database Systems',4,501),
('CS102','Operating Systems',4,502),
('EC201','Digital Electronics',3,503);

 -- Table 3
 -- creating Enrollment 2nf table
CREATE TABLE enrollment (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_code VARCHAR(10),
    semester VARCHAR(10),
    grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES student_2nf(student_id),
    FOREIGN KEY (course_code) REFERENCES course_2nf(course_code)
);

-- inserting data into Enrollment table
INSERT INTO enrollment (student_id, course_code, semester, grade) VALUES
(101, 'CS101', 'Sem1', 'A'),
(101, 'CS102', 'Sem1', 'B'),
(102, 'EC201', 'Sem1', 'A'),
(103, 'CS101', 'Sem2', 'A');

-- Final 2NF tables 
SELECT * FROM university_managment_system.student_2nf;
SELECT * FROM university_managment_system.course_2nf;
SELECT * FROM university_managment_system.enrollment;


-- 3NF ( 3rd Normal Form)

-- Department Table (3NF)

CREATE TABLE department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    office_location VARCHAR(100)
) ENGINE=InnoDB;

-- Inserting data
INSERT INTO department VALUES
(10, 'Computer Science', 'Block A'),
(20, 'Electronics', 'Block B');

-- Student Table (3NF)

CREATE TABLE student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    student_email VARCHAR(100),
    phone VARCHAR(15),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(department_id)
);

-- inserting data

INSERT INTO student VALUES
(101, 'Aarav Sharma', 'aarav@gmail.com', '9876543210', 10),
(102, 'Priya Verma', 'priya@gmail.com', '9876501234', 20),
(103, 'Rohan Patel', 'rohan@gmail.com', '9123456789', 10);


-- Faculty Table (3NF)
CREATE TABLE faculty (
    faculty_id INT PRIMARY KEY,
    faculty_name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(department_id)
) ENGINE=InnoDB;

-- inserting
INSERT INTO faculty VALUES
(501, 'Dr. Mehta', 10),
(502, 'Dr. Rao', 10),
(503, 'Dr. Singh', 20);

-- Course table
CREATE TABLE course (
    course_code VARCHAR(10) PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT,
    faculty_id INT,
    department_id INT,
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id),
    FOREIGN KEY (department_id) REFERENCES department(department_id)
) ENGINE=InnoDB;

-- inserting
INSERT INTO course VALUES
('CS101', 'Database Systems', 4, 501, 10),
('CS102', 'Operating Systems', 4, 502, 10),
('EC201', 'Digital Electronics', 3, 503, 20);


-- Enrollment Table (3NF)
CREATE TABLE enrollment_3nf (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_code VARCHAR(10),
    semester VARCHAR(10),
    grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (course_code) REFERENCES course(course_code)
) ENGINE=InnoDB;

-- inserting 
INSERT INTO enrollment_3nf (student_id, course_code, semester, grade) VALUES
(101, 'CS101', 'Sem1', 'A'),
(101, 'CS102', 'Sem1', 'B'),
(102, 'EC201', 'Sem1', 'A'),
(103, 'CS101', 'Sem2', 'A');

-- Final 3NF  tables
SELECT * FROM university_managment_system.department;
SELECT * FROM university_managment_system.student;
SELECT * FROM university_managment_system.course;
SELECT * FROM university_managment_system.faculty;
SELECT * FROM university_managment_system.enrollment_3nf;

-- Indexing 
-- Create Indexes
CREATE INDEX idx_student_id ON student(student_id);
CREATE INDEX idx_course_code ON course(course_code);
CREATE INDEX idx_department_id ON department(department_id);

-- Query with Index
EXPLAIN SELECT * FROM student WHERE student_id = 101;

--  Query Example
SELECT s.student_name, c.course_name, e.grade
FROM student s
JOIN enrollment e ON s.student_id = e.student_id
JOIN course c ON e.course_code = c.course_code
WHERE s.student_id = 101;








