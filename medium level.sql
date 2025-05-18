

select max(salary) from project1 where department = 'it';
#MEDIUM LEVEL
create table project12(Performance_ID int,	Employee_ID int,	Project_ID int,
	Performance_rating int,	Feedback varchar(50));
    insert into project12 values(1,	1,	2,	9,	'Excellent'),
(2,2,3,8,'Good'),
(3,3,2,9,'Excellent'),
(4,4,2,9.3,'Excellent'),
(5,5,1,9,'Excellent'),
(6,6,3,8.5,'Good'),
(7,7,1,8,'Good'),
(8,8,3,5,'Average'),
(9,9,3,6,'Average'),
(10,10,1,9.4,'Excellent'),
(11,11,4,7,'Average'),
(12,12,2,9.5,'Average'),
(13,13,4,8.5,'Good'),
(14,14,4,8,'Good'),
(15,15,Null,Null,'Worst'),
(16,16,Null,Null,'Worst');
select max(salary)from project1;
#Medium Level :-


# How many employees are there in each department, and what is the maximum salary in each department?

select count(*),max(salary),Department from project1 group by Department;

#Q 5.  Retrieve the Employee_name, Department, and Performance_rating of all employees along with their respective departments.

select employee_name,department from project1 join project12 on project1.employee_name=project12.performance_rating;


##Q 4. Retrieve the Employee_name and Feedback for employees with Employee_ID between 11 and 16.

select Employee_name,feedback from project1  join project12 on project1.Employee_ID=project12.Employee_ID where project12.Employee_ID between 11 and 16; 

#Q 5. Retrieve Employee_name who have Salary more than “50,000”, performance_rating greater than “8” from “Sales” Department?

select employee_name,performance_rating from project12 join project1 on project12.Employee_ID=project1.Employee_ID
 where salary>50000 and Performance_rating > 8 and Department = 'sales';
 
 #Q 6. Which employee_ID have “Average” Feedback with Project_ID “3”.
 
 select project1.employee_id,feedback,project12.Project_ID from project1 join project12 on project1.Employee_ID=project12.Employee_ID 
 where feedback = 'average' and project1.Project_ID = '3' group by Feedback,project1.employee_id,project12.Project_ID;
 
 #Q 7. Find a employee_name who have who do not have any project with Feedback “Average”?

select Employee_name,Feedback from project1 join project12 on project1.Employee_ID=project12.Employee_ID where Feedback not like 'Average' ;

#Q 8. Retrieve performance_id with the performance_rating above “6” and below “9” With feedback “Good”.

select performance_id,Performance_rating from project12 where Performance_rating between 6 and 9 and Feedback = 'Good';



