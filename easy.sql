#EASY

create table project1(Employee_ID int primary key,	Employee_name varchar(20),	
Project_ID int ,
	Department varchar(10),	Salary float,	Experience int,	Projects varchar(30));
insert into project1 values(1,'mohit',2,'it',500000,2, "Projects_a"),
(2,'Reema',3,'Sales',30000,1, "Projects_B"),
(3,'Harish',2,	'IT',50000,2, "Projects_A"),
(4,'Paras',2,'IT',95000	,4, "Projects_A"),
(5,'Shivam',1,'HR',77000,4, "Projects_C"),
(6,'Harsh',3,'Sales',30000,1, "Projects_B"),
(7,'Dorthy', 1,'HR',65000,3, "Projects_C"),
(8,'Archana',3,'Sales',18000,Null, "Projects_B"),
(9,'Vishal',3,'Sales',18000,null,  "projects_B"),
(10,'Shubendu',1,'HR',	150000,8, "Projects_c"),
(11,'Drigga',4	,'Finance',	48000,	3, "Projects_D"),
(12,'Maninder',	2,	'IT',145000,7	, "Projects_A"),
(13,	'Nithish',4	,'Finance',	115000,6, "Projects_D"),
(14,'Shubham',	4,'Finance',74000,	5, "Projects_D"),
(15,Null,Null,'Finance',17000,Null,Null),
(16,'Prince',Null,Null,Null,Null,Null);


#Q 1. Insert a new employee with the following details: Employee_ID = 22, Employee_name = 'John', Project_ID = 1, Department = 'IT', Salary = 50000, Experience = 2 years, Projects = 'ProjectA'.

insert into  project1 (Employee_ID, Employee_name, project_id, Department, Salary , Experience , Projects)
 values( 22, 'John', 1,  'IT', 50000,  2 , 'ProjectA');
  
  #Q 2. How would you add a new column called "Manager_ID" to the employee table?
  
 alter table project1 add column manager_id  int;
 
 #Q 3. What is the total salary expenditure of the company?
 
  select avg(salary)from project1;
  
  #Q 4. How many employees are there in each department?

 select count(*),department from project1 group by department;

 
 #Q 5. Are there any employees with an Experience of more than 5 years?

 select experience,employee_name from project1 group by experience,employee_name having Experience>5;
 
#Q6. Retrieve the details of employees whose Salary is greater than the average salary of all employees

select * from project1 where salary>=all(select avg(salary) from project1 ); 


 #Q7. Add a new project 'ProjectB' for the employee with Employee_ID = 25.
 
 insert into project1(projects,employee_id) values('projectB',25);
 
#Q 8. What is the average experience of employees in each department?

select avg(experience),department from project1 group by experience,Department;

#Q 9. Modify the data type of the Salary column from INT to DECIMAL(10, 2).

alter table project1 modify column Salary DECIMAL(10,2);

#Q 10. What is the maximum salary among all employees in “IT” department?

select max(salary) from project1 where department = 'it';

select * from project1;