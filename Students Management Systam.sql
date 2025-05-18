create database studentsinformation;
use studentsinformation;

create table Students (  student_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,name VARCHAR(50) NOT NULL,email VARCHAR(50) UNIQUE,dob DATE );
create table Courses(course_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, course_name VARCHAR(100) NOT NULL,credits INT  );
create table  Enrollments(enrollment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,student_id INT,course_id INT, semester VARCHAR(10),year YEAR,                                             
FOREIGN KEY (student_id) REFERENCES Students(student_id), FOREIGN KEY (course_id) REFERENCES Courses(course_id));  
create table  Grades(grade_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,enrollment_id INT,grade CHAR(1),FOREIGN KEY (enrollment_id) REFERENCES Enrollments(enrollment_id));
create table  Professors(professor_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,name VARCHAR(50) NOT NULL,department VARCHAR(50));

INSERT INTO Students (name, email, dob) VALUES
(1,'Mitchel Hogg', 'mitchel@example.com', '2003-05-12'),
(2,'Branden Scot', 'branden@example.com', '2002-11-30');

INSERT INTO Courses (course_name, credits) VALUES
(11,'Mathematics', 3),
(12,'Physics', 4);

INSERT INTO Professors (name, department) VALUES
('Dr. Eden Kerry', 'Mathematics'),
('Dr. Peter Birds', 'Physics');

INSERT INTO Enrollments (student_id, course_id, semester, year) VALUES
(1, 1, 'Fall', 2024),
(2, 2, 'Spring', 2024);

INSERT INTO Grades (enrollment_id, grade) VALUES
(1, 'A'),
(2, 'B');
#-------------------------------------------------------------------------PROCEDURE--------------------------------------------------------------------------------------------
# Get All Courses of a Student
#Return course names, semesters, and grades for a given student.

DELIMITER //
CREATE PROCEDURE GetStudentCourses(IN p_student_id INT)
BEGIN
    SELECT c.course_name, e.semester, e.year, g.grade,s.name,e.enrollment_id,s.email
    FROM Enrollments e
    JOIN Courses c ON e.course_id = c.course_id
    LEFT JOIN Grades g ON e.enrollment_id= g.enrollment_id
    left join students s on e.student_id=s.student_id
    WHERE e.student_id = p_student_id;
END //
DELIMITER ;
call GetStudentCourses(2);

#------------------------------------------------------------------------PROCEDURE===2-------------------------------------------------------------------------------------------
#Enroll a Student in a Course
#Automatically insert into Enrollments and return the enrollment_id.
#we can make more procedure  that Automatically insert into other tables same as that

DELIMITER //
CREATE PROCEDURE EnrollStudent(
    IN p_student_id INT,
    IN p_course_id INT,
    IN p_semester VARCHAR(10),
    IN p_year YEAR
)
BEGIN
    INSERT INTO Enrollments(student_id, course_id, semester, year)
    VALUES (p_student_id, p_course_id, p_semester, p_year);
END //
DELIMITER ;
call EnrollStudent(22,5,"spring",2020); 

#---------------------------------------------------------------------Triggers------------------------------------------------------------------------------------------------
#Trigger to prevent duplicate enrollment

DELIMITER //

CREATE TRIGGER prevent_duplicate_enrollment
BEFORE INSERT ON Enrollments
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM Enrollments
        WHERE student_id = NEW.student_id
          AND course_id = NEW.course_id
          AND semester = NEW.semester
          AND year = NEW.year
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student already enrolled in this course for the semester.';
    END IF;
END//
DELIMITER ;

#------------------------------------------------some queries----------------------------------------------------------------------------------------------------------------

#1--  View all courses?
select * from courses;

#2--   Get all professors by department?
select name,department from professors;

#3--   Count of students in each course?
select count(*) as total_students,course_name from  Enrollments join courses on Enrollments.course_id=courses.course_id group by course_name order by course_name asc;

#4--    Display all enrollments for a particular semester?
select student_id from enrollments where semester = "spring";

#5--    Check student grades for a course?
select grade,course_name,name from grades join courses on grades.grade_id=courses.course_id  join students on courses.course_id=students.student_id where course_name="Mathematics";

#6--    List courses a student is enrolled in?
select Courses.course_name from  Enrollments join Courses on Enrollments.course_id = Courses.course_id where Enrollments.student_id = 1;

#7--    Retrieve the professor for each course?
select name,course_name from professors join courses on  courses.course_id=professors.professor_id;

#8--     Find students with no grades assigned?
select name from students join grades on students.name=grades.grade_id where grade is null;

#9--     Count of students enrolled in each course?
select Courses.course_name,COUNT(Enrollments.student_id) as student_count from Enrollments
join Courses on Enrollments.course_id = Courses.course_id 
group by Courses.course_name;

#10--     List the top 5 students with the highest average grades?
select Students.name, avg(CASE 
            WHEN Grades.grade = 'A' THEN 4.0         
            WHEN Grades.grade = 'B' THEN 3.0       
            WHEN Grades.grade = 'C' THEN 2.0      
            WHEN Grades.grade = 'D' THEN 1.0       
            ELSE 0                                 
        END) AS average_grade                     
from  Grades
join Enrollments on Grades.enrollment_id = Enrollments.enrollment_id 
join Students on Enrollments.student_id = Students.student_id        
group by Students.name                                                
order by average_grade desc                                        
limit 5; 

#11--      Get the total number of courses offered in each department?
select count(course_name) as total_courses,department from courses join professors on courses.course_id=professors.professor_id group by department;

#12--       Retrieve students who are enrolled in more than one course?
SELECT students.name, COUNT(courses.course_name) AS course_count
FROM students
JOIN courses ON students.student_id = courses.course_id
GROUP BY students.name
HAVING COUNT(courses.course_name) > 1;

#13--       Find the course with the highest enrollment?
select course_name,count(enrollments.course_id) as higest from courses join enrollments on courses.course_id=enrollments.enrollment_id group by course_name order by higest desc limit 1;

#14--        Get the number of grades assigned for each course?
select count(grade) as total_grade,course_name from grades join courses on grades.enrollment_id=courses.course_id group by course_name;

#15--         List professors who teach more than one course?
SELECT p.name
FROM professors AS p
JOIN courses AS c ON p.department = c.course_name
GROUP BY p.name
HAVING COUNT(c.course_id) > 1;
