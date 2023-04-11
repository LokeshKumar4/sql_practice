-- =====================*** HR Data set Queries ***=======================================================

SELECT TABLE_NAME, TABLE_ROWS
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'hr'
ORDER BY TABLE_ROWS DESC; 

select * from employees;
select * from departments;

select concat(e.first_name,e.last_name) as "Full Name",
e.department_id, d.department_name from employees e 
join departments d on e.department_id=d.department_id;

select d.department_id,d.department_name ,l.street_address,l.postal_code,l.city,l.state_province,c.country_name , r.region_name
from departments d 
join locations  l on d.location_id=l.location_id 
join countries c on l.country_id=c.country_id 
join regions r on c.region_id=r.region_id;

-- task 1 
select concat(e.first_name,e.last_name)as Fullname,e.job_id,d.department_name,l.state_province,c.country_name from employees e 
join departments d on e.department_id=d.department_id 
join locations l on d.location_id=l.location_id
join countries c on l.country_id=c.country_id
where l.city='London';

-- task 2
select concat(e1.first_name," ",e1.last_name)as fullname ,
e1.manager_id, 
concat(e2.first_name," ",e2.last_name)
from employees e1
join employees e2
on e1.manager_id=e2.employee_id;

-- task 3 
select e.department_id,d.department_name,count(employee_id) as total_empoyees
from employees e 
join departments d 
on e.department_id=d.department_id
group by e.department_id;

-- task 4 

select e.employee_id,concat(e.first_name," " ,e.last_name )as fullname , 
j.job_id,jobs.job_title,DATEDIFF(j.end_date,j.start_date)as total_job_period, e.department_id
from employees e
join job_history j on e.employee_id=j.employee_id
join jobs on j.job_id=jobs.job_id
where e.department_id=90;

-- task 5 
select d.department_id,d.department_name, coalesce(d.manager_id,"Not assigned"),coalesce(concat(e.first_name," ", e.last_name),"Not assigned") as Manager_name
from departments d
left join employees e on e.employee_id=d.manager_id;

-- Q1.write a query to display the department name , manager name , city 
select d.department_id,d.department_name,d.manager_id,coalesce(concat(m.first_name," ", m.last_name),"Not assigned") as Manager_name
from departments d
left join employees m on d.manager_id=m.employee_id ;

-- Q2. write a query to display the job title and average salary of employees
select e.job_id,j.job_title,round(avg(e.salary)) as Average_Salary 
from employees e
join jobs j on e.job_id=j.job_id
group by e.job_id
order by Average_Salary desc;

-- Q3. write a query to display job title, employee name and the difference between salary of the employee and minimum salary for the job.
select e.employee_id,coalesce(concat(e.first_name," ", e.last_name),"Not assigned") as Full_name, e.salary-j.min_salary as Salary_difference
from employees e 
join jobs j on e.job_id=j.job_id
order by Salary_difference;

with cte  as (select job_id,min(salary) as min_sal from employees group by job_id)
select e.employee_id,coalesce(concat(e.first_name," ", e.last_name),"Not assigned") as Full_name, salary , min_sal,salary - min_sal as salary_differnce
from employees e 
join cte on cte.job_id=e.job_id
order by salary_differnce  ;
 

-- Q4. write a query to find the name (firstname ,Last name) and hire datwe of the employees who were hired after Jones.
select coalesce(concat(e.first_name," ", e.last_name),"Not assigned") as Full_name,e.hire_date
from employees e
where hire_date>(select em.hire_date  from employees em where em.last_name='Jones')
order by e.hire_date ;

select e.first_name,e.last_name,e.department_id,d.department_name,l.city
from employees e
join departments d
on e.department_id=d.department_id
join locations l
on d.location_id=l.location_id;

-- write a SQL query to find the first name, last name, salary, and job_ID for all employees. (completed by ff17)
select e.first_name,e.last_name,e.salary,e.job_id
from employees e;


-- write a SQL query to find all those employees who work in department ID 80 or 40. Return first name, last name, department number and department name.
select e.first_name,e.last_name,e.department_id,d.department_name
from employees e
join departments d
on e.department_id=d.department_id 
where d.department_id in (80,40);

-- write a SQL query to find those employees whose first name contains the letter ‘z’. Return first name, last name, department, city, and state province.
select e.first_name,e.last_name,d.department_name,l.city,l.state_province
from employees e
join departments d on e.department_id=d.department_id
join locations l on l.location_id=d.location_id
where e.first_name like "%z%";

-- write a SQL query to find all departments, including those without employees. Return first name, last name, department ID, department name.

select d.department_id,d.department_name,e.first_name,e.last_name
from employees e
right join departments d on e.department_id=d.department_id
order by d.department_id; 



-- write a SQL query to find the employees who earn less than the employee of ID 182. Return first name, last name and salary.
 select e.employee_id,coalesce(concat(e.first_name," ",e.last_name),"Error") as "Full name",e.department_id,e.salary
 from employees e
 where e.salary<(select salary from employees where employee_id=182);
 
-- write a SQL query to find the employees and their managers. Return the first name of the employee and manager. 
select e.employee_id,coalesce(concat(e.first_name," ",e.last_name),"Error") as "Full name",e.manager_id,coalesce(concat(m.first_name," ",m.last_name),"Error") as "Manager name"
from employees e
join employees m on e.manager_id=m.employee_id;

-- write a SQL query to display the department name, city, and state province for each department.
select d.department_id,d.department_name,l.city,l.state_province,c.country_name
from departments d
join locations l on d.location_id=l.location_id
join countries c on l.country_id=c.country_id;

-- write a SQL query to find the employees and their managers.Return the first name of the employee and manager. 
select e.employee_id,coalesce(concat(e.first_name," ",e.last_name),"Error") as "Full name",e.manager_id,coalesce(concat(m.first_name," ",m.last_name),"Error") as "Manager name"
from employees e
join employees m on e.manager_id=m.employee_id;
 
-- write a SQL query to find the employees who work in the same department as the employee with the last name Taylor. Return first name, last name and department ID.
 select e.employee_id,e.department_id,coalesce(concat(e.first_name," ",e.last_name),"Error") as "Full name"
 from employees e 
 where e.department_id in (select department_id
 from employees 
 where last_name='Taylor');
 
-- write a SQL query to find all employees who joined on or after 1st January 1993 and on or before 31 August 1997. Return job title, department name, employee name, and joining date of the job.
select e.employee_id,e.department_id,coalesce(concat(e.first_name," ",e.last_name),"Error") as "Full name",j.job_title,d.department_name
from employees e 
join departments d on e.department_id=d.department_id
join jobs j on e.job_id=j.job_id 
where e.hire_date between '1993/01/01' and '1997/08/31';

-- write a SQL query to calculate the difference between the maximum salary of the job and the employee's salary. Return job title, employee name, and salary difference. 
 with cte as (select job_id, max_salary from jobs)
 select  e.employee_id,e.department_id,coalesce(concat(e.first_name," ",e.last_name),"Error") as "Full name",e.job_id,cte.max_salary-e.salary as "salary difference"
 from employees e 
 join cte on e.job_id=cte.job_id;
 
-- calculate the average salary, the number of employees receiving commissions in that department. Return department name, 
-- average salary and number of employees.
 with cte as (select job_id,round(avg(salary)) as avg_salary
 from employees 
 group by job_id)
 select e.employee_id,coalesce(concat(e.first_name," ",e.last_name),"Error") as "Full name",d.department_name,e.salary,cte.avg_salary,e.commission_pct
 from employees e 
 join departments d on e.department_id=d.department_id
 join cte on e.job_id=cte.job_id
 order by e.employee_id;
 
-- write a SQL query to find the department name, full name (first and last name) of the manager and their city.
select d.department_id,d.department_name,d.manager_id,coalesce(concat(m.first_name," ",m.last_name),"Not Assigned") as "Full name"
from departments d 
left join employees m on d.manager_id=m.employee_id
order by d.department_id;

-- write a SQL query to calculate the number of days worked by employees in a department of ID 80. Return employee ID, job title, number of days worked. 
 select e.employee_id,coalesce(concat(e.first_name," ",e.last_name),"Error") as "Full name",e.department_id,jobs.job_title,datediff(j.end_date,j.start_date) as "working Days"
 from employees e
 join jobs on e.job_id=jobs.job_id
 join job_history j on e.job_id=j.job_id 
 where e.department_id=80;
-- write a SQL query to find full name (first and last name), job title, start and end date of last jobs of employees who did not receive commissions.
select e.employee_id,coalesce(concat(e.first_name," ",e.last_name),"Error") as "Full name",jobs.job_title,j.start_date,j.end_date
from employees e
join jobs on e.job_id=jobs.job_id
join job_history j on e.job_id=j.job_id
where e.commission_pct is null 
order by e.employee_id; 

select * from
(select * from employees order by employee_id desc limit 10 ) sub
order by employee_id ;


select department_id,avg(salary)
from employees group by department_id having avg(salary)<=all(select avg(salary) from employees group by department_id );

select first_name,job_id,salary
from employees e
where salary>( select avg(salary) from employees where job_id=e.job_id);

select e.employee_id,e.first_name,e.last_name,e.manager_id
from employees e where not  exists (select * from employees a where a.manager_id=e.employee_id);

select e.first_name,e.last_name,e.department_id,e.salary
from employees e where exists (select employee_id from employees where e.salary>3700)
order by e.salary;

select e.first_name,e.last_name,e.department_id,e.salary
from employees e where salary < any (select s.salary from  employees s join jobs j on s.job_id=j.job_id where j.job_id='SH_CLERK' )
order by e.salary;

select distinct s.salary from  employees s join jobs j on s.job_id=j.job_id where j.job_id='SH_CLERK' ;

select e.first_name,e.last_name 
from employees e where salary >(select salary from employees where employee_id=163)
order by salary;

select e.first_name,e.last_name ,e.salary, e.department_id, e.job_id
from employees e where job_id in (select job_id from employees where employee_id=169)
order by salary;

select e.first_name,e.last_name ,e.salary,e.department_id
from employees e where salary <= any(select min(k.salary) from employees k where e.department_id=k.department_id group by k.department_id )
order by salary;

select distinct department_id from employees;
select e.first_name,e.last_name ,e.salary,e.department_id
from employees e where salary <= all(select min(k.salary) from employees k )
order by salary;

select e.first_name,e.last_name ,e.salary,e.department_id
from employees e where salary >= any(select avg(k.salary) from employees k  )
order by salary;

select e.first_name,e.last_name ,e.salary,e.department_id,e.manager_id
from employees e where manager_id in(select k.employee_id from employees k where k.first_name='Steven' )
order by salary;


/* Write a query to display the department number, name (first name and last name), job_id and
 department name for all employees in the Finance department. */
 select e.employee_id,e.department_id,e.first_name
 from employees e
 where department_id in (select department_id from departments where department_name='Finance' );
 
/* Write a query to display all the information of an employee whose salary and reporting person id is 3000
 and 121, respectively. */
select * from employees where employee_id in (select employee_id from employees where manager_id =121 and salary=3000);

/* Display all the information of an employee whose id is any of the number 134, 159 and 183. */
select *
from employees where employee_id = any(select employee_id from employees where  employee_id in (134,159,183));

/* Write a query to display all the information of the employees whose salary is within the 
range 1000 and 3000. */
select * from employees where employee_id = any(
select employee_id from employees where salary between 1000 and 3000);

/* Write a query to display all the information of the employees whose salary is within the range of 
smallest salary and 2500. */ 
select * from employees where employee_id = any(
select employee_id from employees where salary between 0 and 2500) order by salary;

select * from employees where salary between (select min(salary) from employees  ) and 2500 ;


/* Write a query to display all the information of the employees who does not work in those departments 
where some employees works whose manager id within the range 100 and 200. */
select * from employees where  employee_id not in (
 select employee_id from employees where  manager_id between 100 and 200);

/* Write a query to display all the information for those employees whose id is any id who earn the second 
highest salary. */ 
select * from employees where salary = (
select max(salary) from employees where salary <> (
select max(salary) from employees));

/* Write a query to display the employee number, name (first name and last name) and job title for all 
employees whose salary is more than any average salary of any department. */
select * from employees e
where salary> any(
select avg(salary) from employees s group by department_id );

/* Write a query to display the employee id, name (first name and last name) and the job id column with a 
modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is 
IT_PROG. */ 
select e.employee_id, concat(e.first_name ," " ,e.last_name)as "Full Name",e.job_id,j.job_id,
CASE  
 WHEN j.job_id = 'ST_MAN' THEN 'SALESMAN'  
WHEN j.job_id='IT_PROG' THEN 'DEVELOPER'  
ELSE j.job_title  
END AS Job_title
from employees e join jobs j on e.job_id=j.job_id ;

/* Write a subquery that returns a set of rows to find all departments that do actually have one or more 
employees assigned to them. */

select department_id,count(employee_id) from employees group by department_id having count(employee_id)>1;

