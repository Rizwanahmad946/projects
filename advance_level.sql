
create table advance_project (Employee_ID int primary key,	Performance_ID int,	Manager varchar(20),Manager_ID int ,	
Employee_name varchar(40),	Project_ID	int,Department varchar(50),	Salary float,	Experience int,	Projects varchar(40));

create table advance_project2(Performance_ID int,Employee_ID int,Manager_ID int,	Project_ID int,	Performance_rating int,	Feedback varchar(20));

insert into advance_project values(1,	1,	'Aizen',	1,	'Mohit',	2,	'IT',	50000,	2,	'Project “A”'),
(2,	2,	'Ichigo',	2,	'Reema',	3,	'Sales',	30000,	1,	'Project ”B”'),
(3,	3,	'Aizen',	1,	'Harish',	2,	'IT',	50000,	2,	'Project ”A”'),
(4,	4,	'Aizen',	1,	'Paras',	2,	'IT',	95000,	4,	'Project ”A”'),
(5,	5,	'Shunsui',	3,	'Shivam',	1,	'HR',	77000,	4,	'Project “C”'),
(6,	6,	'Ichigo',	1,	'Harsh',	3,	'Sales',	30000,	1,	'Project ”B”'),
(7,	7,	'Shunsui',	3,	'Dorthy',	1,	'HR',	65000,	3,	'Project “C”'),
(8,	8,	'Ichigo',	2,	'Archana',	3,	'Sales',	18000,	Null,	'Project ”B”'),
(9,	9,	'Ichigo',	2,	'Vishal',	3,	'Sales',	18000,	Null,	'Project ”B”'),
(10,	10,	'Shunsui',	3,	'Shubendu',	1,	'HR',	150000,	8,	'Project “C”'),
(11,	11,	'Rukia',	4,	'Drigga',	4,	'Finance',	48000,	3,	'Project “D”'),
(12,	12,	'Aizen',	1,	'Maninder',	2,	'IT',	145000,	7,	'Project ”A”'),
(13,	13,	'Rukia',	4,	'Nithish',	4,	'Finance',	115000,	6,	'Project “D”'),
(14,	14	,'Rukia',	4,	'Shubham',	4,	'Finance',	74000,	5,	'Project “D”'),
(15,	15,	Null,	Null, 	Null,	Null,	'Finance',	17000,	Null,	Null),
(16,	16,	Null,	Null, 	'Prince',	Null,	Null,	Null,	Null,	Null);


insert into advance_project2 values(1,	1,	1,	2,	9,	'Excellent'),
(2,	2,	2,	3,	8,	'Good'),
(3,	3,	1,	2,	9,	'Excellent'),
(4,	4,	1,	2,	9.3,	'Excellent'),
(5,	5,	3,	1,	9,	'Excellent'),
(6,	6,	1,	3,	8.5,	'Good'),
(7,	7,	3,	1,	8,	'Good'),
(8,	8,	2,	3,	5,	'Average'),
(9,	9,	2,	3,	6,	'Average'),
(10,10,	3,	1,	9.4,	'Excellent'),
(11,	11,	4,	4,	7,	'Average'),
(12,	12,	1,	2,	9.5,	'Average'),
(13,	13,	4,	4,	8.5,	'Good'),
(14,	14,	4,	4,	8,	'Good'),
(15,	15,	Null, 	Null, NULL,		'Worst'),
(16,	16,	Null, 	Null, NULL,		'Worst');


#Q 1. Retrieve the Department along with the average Performance_rating for each department.

select department,avg(performance_rating) from advance_project
 inner join advance_project2 on advance_project.Performance_ID=advance_project2.Performance_ID group by Department;

#Q 2. Retrieve the Employee_name, Department, and Performance_rating of employees whose Performance_rating is above 8 and are assigned to project ID 1.

select employee_name,department,performance_rating from advance_project
 inner join advance_project2 on advance_project.Employee_ID=advance_project2.Employee_ID where Performance_rating>8 and project_id=1; 
 
 #Q 4. Retrieve the Employee_name and Performance_rating for employees whose Performance_rating is higher than the average Performance_rating for their respective departments.

select employee_name,Performance_rating from advance_project 
inner join advance_project2 on advance_project.Performance_ID=advance_project2.Performance_ID where ( select  avg(performance_rating) from advance_project2 group by department);

##Q 5. Retrieve the Department along with the average Performance_rating for departments having an average Performance_rating greater than 7.

select  department,avg(performance_rating) from advance_project inner join advance_project2 
on advance_project.Performance_id=advance_project2.Performance_rating group by Performance_rating, Department having (Performance_rating)>7;

#Q 7. Retrieve the Employee_name for employees who have a corresponding record in the employee_performance table and do not have a manager.

select employee_name from  advance_project inner join advance_project2 on advance_project.Employee_ID=advance_project2.Employee_ID where advance_project2.Manager_ID is null;

#Q 8. Create a temporary table containing the Employee_name and Performance_rating of employees. 
##Then, retrieve the details of employees along with their department names from both the employee table and the temporary table.

create view temporary_advance 
as (select employee_name,performance_rating from  advance_project inner join advance_project2 on advance_project.employee_id=advance_project2.Performance_ID  );

select * from temporary_advance;

#Q 9. Retrieve the Employee_name and Department for employees who are assigned to a project with a Project_ID greater than 2.

select employee_name,department from advance_project inner join advance_project2 on advance_project.Employee_ID=advance_project2.Employee_ID where advance_project.project_id>2;

#Q 10. Retrieve the Employee_name, Department, and Project_name for employees assigned to projects with manager name “Kurosaki”.

select employee_name,department,projects from advance_project2 inner join advance_project 
on advance_project.Employee_ID=advance_project2.Employee_ID where Manager='kurosaki';