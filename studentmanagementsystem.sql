create database studentmanagement;

use studentmanagement;

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name varchar(100),
    last_name varchar(100),
    dob Date,
    phone varchar(15)
);

insert into Students (student_id, first_name, last_name, dob, phone) values
(1, 'Selva', 'Raj', '2003-12-05', '9847234569'),
(2, 'Deepak', 'Kumar', '2002-03-22', '8967452309'),
(3, 'Sai', 'Kishore', '2001-06-10', '7896543289'),
(4, 'Hari', 'Haran', '2002-11-30', '9347234002'),
(5, 'Mani', 'kandan', '2004-01-18', '6996543279'),
(6, 'Helan', 'Keerthana', '2003-12-25', '9898342389'),
(7, 'Shalini', 'Nisha', '2004-07-09', '7087378408'),
(8, 'Naveen', 'Kumar', '2001-07-01', '6995903459'),
(9, 'Priya', 'Dev', '2002-10-05', '9923409876'),
(10, 'Naresh', 'Kumar', '2003-04-14', '9085678769');

update students 
set phone='9889786723'
where student_id=4;

select * from students;

CREATE TABLE Courses (
    course_id int PRIMARY KEY,
    course_name varchar(100),
    credits int
);

insert into Courses (course_id, course_name, credits) values
(1, 'Computer Science', 4),
(2, 'Cloud Computing', 3),
(3, 'Data Structures', 4),
(4, 'Computer Networks', 3),
(5, 'Software Engineering', 4),
(6, 'Web Development', 3),
(7, 'Artificial Intelligence', 4),
(8, 'Machine Learning', 3),
(9, 'Web Development', 4),
(10, 'Cloud Computing', 3);

select * from courses;

CREATE TABLE Enrollments (
    enrollment_id int PRIMARY KEY,
    student_id int,
    course_id int,
    semester varchar(20),
    grade varchar(2),
    foreign key (student_id) references Students(student_id),
    foreign key (course_id) references Courses(course_id)
);

insert into Enrollments (enrollment_id, student_id, course_id, semester, grade) values
(1, 1, 1, 'Fall 2024', 'A'),
(2, 2, 2, 'Fall 2024', 'B+'),
(3, 3, 3, 'Fall 2024', 'A-'),
(4, 4, 4, 'Fall 2024', 'B'),
(5, 5, 5, 'Fall 2024', 'A+'),
(6, 6, 6, 'Fall 2024', 'C'),
(7, 7, 7, 'Fall 2024', 'B-'),
(8, 8, 8, 'Fall 2024', 'A'),
(9, 9, 9, 'Fall 2024', 'B+'),
(10, 10, 10, 'Fall 2024', 'B');

select * from enrollments;

CREATE TABLE Attendance (
    attendance_id int PRIMARY KEY,
    student_id int,
    course_id int,
    date date,
    status ENUM('Present', 'Absent', 'Late'),
    foreign key (student_id) references Students(student_id),
    foreign key (course_id) references Courses(course_id)
);

insert into Attendance (attendance_id, student_id, course_id, date, status) values
(1, 1, 1, '2024-10-01', 'Present'),
(2, 2, 2, '2024-10-01', 'Absent'),
(3, 3, 3, '2024-10-01', 'Late'),
(4, 4, 4, '2024-10-01', 'Present'),
(5, 5, 5, '2024-10-01', 'Absent'),
(6, 6, 6, '2024-10-01', 'Present'),
(7, 7, 7, '2024-10-01', 'Late'),
(8, 8, 8, '2024-10-01', 'Present'),
(9, 9, 9, '2024-10-01', 'Absent'),
(10, 10, 10, '2024-10-01', 'Present');

select* from attendance;

CREATE TABLE Grades (
    grade_id int PRIMARY KEY,
    student_id int,
    course_id int,
    assignment_title varchar(100),
    score decimal(5, 2),
    comments text,
    foreign key (student_id) references Students(student_id),
    foreign key (course_id) references courses (course_id)
);

insert into Grades (grade_id, student_id, course_id, assignment_title, score, comments)values
(1, 1, 1, 'Midterm Exam', 85.50, 'Good performance'),
(2, 2, 2, 'Final exam', 90.00, 'Well done'),
(3, 3, 3, 'Assignment 1', 88.75, 'Excellent'),
(4, 4, 4, 'Lab Work', 78.20, 'Needs improvement'),
(5, 5, 5, 'Pratical', 92.50, 'Great job'),
(6, 6, 6, 'Assignment 2', 65.00, 'Average work'),
(7, 7, 7, 'Midterm Exam', 70.00, 'Could do better'),
(8, 8, 8, 'Final Exam', 95.75, 'Outstanding'),
(9, 9, 9, 'Project Presentation', 82.50, 'Good effort'),
(10, 10, 10, 'Assignment 3', 89.25, 'Very good');

select * from grades;

show tables from studentmanagement;

delimiter $$
CREATE PROCEDURE GetStudentDetails(IN studentID INT)
begin
    select student_id, first_name, last_name, dob, phone
    from Students
    where student_id = studentID;
end $$

call GetStudentDetails(5);

delimiter $$
CREATE PROCEDURE GetCourseByID(IN course_id INT)
begin
    select * from Courses where course_id = course_id;
end $$

call GetCourseByID(7);

delimiter $$
CREATE procedure GetGrade(IN Grade int)
begin
    select* from grades
    where score<80;
    select grade_id,student_id,comments
    from grades;
end $$

call GetGrade (1);

create view viewstudent AS
select student_id, first_name, last_name ,dob
from students;

select * from viewstudent;

create view viewscore AS
select s.student_id, s.first_name, s.last_name, g.assignment_title, g.score
from students s
join grades g on s.student_id = g.student_Id
where g.score<70;

select * from viewscore;


