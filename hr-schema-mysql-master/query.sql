
-- task 
create table student (
sno int not null primary key auto_increment,
sname varchar(30) not null,
dob date not null,
city varchar(30)
);
insert into student(sname,dob,city) values('lokesh','2000-01-08','Meerut');
insert into student(sname,dob,city) values('kumar','2000-01-18','Meerut');

select * from student;
alter table student add CONSTRAINT sname_check2 check (length(sname)>2);
alter table student add CONSTRAINT sname_check3 check (sname like "%k%");
alter table student add column size enum('small','medium','large');
insert into student(sname,dob,city) values('pawank','2000-01-18','Meerut');

-- ==============================
create table area(
citys varchar(30) primary key,
state varchar(30),
sno int ,
foreign key sno references student on delete cascade);
insert into area values('meerut','Uttar Pradesh');
insert into area values('delhi','delhi');
select * from area;

create table employee(
empid int not null,
name varchar(40) not null,
birthdate date not null,
gender varchar(10) not null,
hire_date date not null,
primary key (empid));
select * from employee;

insert into employee values 
(101,'Bryan','1988-08-12','M','2015-08-26'), (102,'Joseph','1978-05-12','M','2014-10-21'),
(103,'Mike','1984-10-13','M','2017-10-28'),(104,'Daren','1979-04-11','M','2006-11-01'),(105,'Marie','1990-02-11','F','2018-10-12');
create table payment(payment_id int primary key not null,
emp_id int not null,
amount float not null,
payment_date date not null,
foreign key(emp_id) references employee (empid) on update cascade);
insert into payment (payment_id,emp_id,amount,payment_date) values
(301,101,1200,'2015-09-15'),
(302,101,1200,'2015-09-30'),
(303,101,1500,'2015-10-15'),
(304,101,1500,'2015-10-15'),
(305,102,1800,'2015-09-15'),
(306,102,1800,'2015-09-30');

select * from employee;
select * from payment;

delete from employee where empid=102;

use information_schema;
select table_name from referential_constraints
where constraint_schema ='hr'
and referenced_table_name='employee'
and delete_rule='CASCADE';

alter table payment add constraint payment_update 
foreign key (emp_id) references employee(empid) on update cascade; 
set foreign_key_checks=1;
update employee set empid=1111 where empid=102;

-- ================================SQL - Day 4 =============================
create database empdb;
use empdb;
create table employeeUK(
empid int primary key,
first_name varchar(50),
last_name varchar(50),
gender varchar(10),
department varchar(30));
select * from employeeUK;

create table employeeUSA(
empid int primary key,
first_name varchar(50),
last_name varchar(50),
gender varchar(10),
department varchar(30));
select * from employeeUSA;


INSERT INTO EmployeeUK VALUES(1, 'Pranaya', 'Rout', 'Male', 'IT');
INSERT INTO EmployeeUK VALUES(2, 'Priyanka', 'Dewangan', 'Female', 'IT'); 
INSERT INTO EmployeeUK VALUES(3, 'Preety', 'Tiwary', 'Female', 'HR'); 
INSERT INTO EmployeeUK VALUES(4, 'Subrat', 'Sahoo', 'Male', 'HR'); 
INSERT INTO EmployeeUK VALUES(5, 'Anurag', 'Mohanty', 'Male','IT'); 
INSERT INTO EmployeeUK VALUES(6, 'Rajesh', 'Pradhan', 'Male', 'HR'); 
INSERT INTO EmployeeUK VALUES(7, 'Hina', 'Sharma', 'Female','IT');


select * from EmployeeUK;

INSERT INTO EmployeeUSA VALUES(1, 'James', 'Pattrick', 'Male', 'IT');
INSERT INTO EmployeeUSA VALUES(3, 'Sara', 'Taylor', 'Female', 'HR');
INSERT INTO EmployeeUSA VALUES(4, 'Subrat', 'Sahoo', 'Male', 'HR');
INSERT INTO EmployeeUSA VALUES(2, 'Priyanka', 'Dewangan', 'Female', 'IT'); 
INSERT INTO EmployeeUSA VALUES(5, 'Sushanta', 'Jena', 'Male', 'HR'); 
INSERT INTO EmployeeUSA VALUES(6, 'Mahesh', 'Sindhey', 'Female', 'HR'); 
INSERT INTO EmployeeUSA VALUES(7, 'Hina', 'Sharma', 'Female', 'IT');


select * from employeeUK 
union
select * from employeeUSA;


select * from employeeUK 
union all
select * from employeeUSA;


select * from employeeUK 
union
select * from employeeUSA
order by first_name;


select * from employeeUK where first_name
not in ( select first_name from employeeUSA);


SELECT t1.* FROM EmployeeUK AS t1 
LEFT JOIN EmployeeUSA AS t2 ON
t1.first_name=t2.first_name
AND t1.last_name =t2.last_name
AND t1.gender=t2.gender
AND t1.department =t2.department
WHERE t2.empid IS NULL;

select * from employeeUK 
except
select * from employeeUSA
order by first_name;

select * from employeeUK 
intersect
select * from employeeUSA
order by first_name;

select * from employeeUK
where first_name in (select first_name from employeeUSA);

SELECT t1.* FROM EmployeeUK AS t1 
JOIN EmployeeUSA AS t2 ON
t1.first_name=t2.first_name
AND t1.last_name =t2.last_name
AND t1.gender=t2.gender
AND t1.department =t2.department



-- =======================*** SQL - Day 4 ***====================================

CREATE TABLE Sales(

Employee_Name VARCHAR(45) NOT NULL,

Year INT NOT NULL,

Country VARCHAR(45) NOT NULL,

Product VARCHAR(45) NOT NULL,

Sale DECIMAL(12,2) NOT NULL, PRIMARY KEY(Employee_Name, Year)
);

select * from sales;

INSERT INTO Sales(Employee_Name, Year, Country, Product, Sale) 
VALUES('Joseph', 2017, 'India', 'Laptop', 10000),
('Joseph', 2018, 'India', 'Laptop', 15000),
('Joseph', 2019, 'India', 'TV', 20000),
('Bob', 2017, 'US', 'Computer', 15000),
('Bob', 2018, 'US', 'Computer', 10000),
('Bob', 2019, 'US', 'TV', 20000),
('Peter', 2017, 'Canada', 'Mobile', 20000),
('Peter', 2018, 'Canada', 'Calculator', 1500),
('Peter', 2019, 'Canada', 'Mobile', 25000);

select sum(sale) from Sales;

SET sql_mode = 'ONLY_FULL_GROUP_BY';

select Year,Product ,sum(sale) as total_sale 
from sales 
group by Year,Product
order by Year;

select Year ,sum(sale) as total_sale 
from sales 
group by Year
order by Year;

select Year, Product , Sale,Sum(Sale) over (partition by Year) as Total_sales from sales;
 
select Year, Product , Sale,Sum(Sale) over (order by Year) as Total_sales from sales;
  
select Year, Product , Sale,Sum(Sale) over (partition by Year order by sale) as Total_sales from sales;
 select * from sales;
select year,Product , Sale,
Ntile(4) over() as total_sale
from sales order by Product;

select Year ,Product , Sale  , Lead ( sale ,1) over (partition by year  ) as total_sales from sales;

create table t (val int);
insert into t(val) values (1),(2),(3),(4),(5),(6);
insert into t(val) values (2),(4);
select * from t;

select val ,Rank() over (order by val ) myrank from t;
select val ,Rank() over () myrank from t;

select employee_name ,year , sale ,Rank() over (partition by year order by sale desc) sales_rank from sales;

select i from t;
insert into t values(3);

select i, percent_rank() over (order by i) as percent_ranking from t;

-- =============================SQL - Day 7 ====================================
-- classic model queries
set sql_mode=(select Replace (@@sql_mode, 'ONLY_FULL_GROUP_BY',''));

use classicmodels;
create table productlinesales
select productline , year(orderdate) orderyear, quantityordered* priceeach  ordervalue
from orderdetails
inner join orders using(ordernumber)
inner join products using (productcode)
group by productline, year(orderdate);

Select * from productlinesales;

select *,  round(percent_rank() over (partition by orderyear order by ordervalue),2) as percentile_rank from productlinesales;

select row_number() over (order by productname) row_num , productname,msrp from products order by productname;


create table t( id int, name varchar(30) not null ) ;
insert into t values(1,'A'),(2,'B'),(2,'B'),(3,'C'),(3,'C'),(3,'C'),(4,'D');
SELECT * FROM t;

select id ,name, row_number() over (partition by id,name order by id  ) as row_num from t;

select * from (select id ,name, row_number() over (partition by id,name order by id  ) as row_num from t )as x where x.row_num=1;


select * from (select productname ,msrp ,row_number() over (order by msrp) as row_num from products) t where row_num between 11 and 20;
select productname ,msrp from products order by msrp limit 10 offset 10;
 
select * from t;
select * from sales;
select sales_rank,sales_employee,fiscal_year from (select sales_employee ,fiscal_year , sale ,DENSE_RANK() over(partition by fiscal_year order by sale desc ) sales_rank from sales) t ;


create table employeedetail (Name varchar(20),age int ,Department varchar(20),salary float );

insert into employeedetail value ( 'ramesh',20, 'Finance',50000),('Deep',25,'Sales',30000),('Suresh',28,'Finance',50000),('Ram',28,	'Finance',20000),('Pradeep',22,'Sales',20000);
select * from employeedetail;

-- Find average salary of employees for each department and order employees within a department by age.
select * ,
avg(salary) over (partition by department order by age range between unbounded preceding and unbounded following) as average_salary from employeedetail ;

-- Find average salary of employees for each department and order employees within a department by age, order the records as per age values.
select * ,avg(salary) over (partition by department order by age range between unbounded preceding and unbounded following) as average_salary from employeedetail order by age;


-- Calculate row no., rank, dense rank of employees is employee table according to salary within each department.
select name , age , salary ,department,row_number() over (partition by department order by salary) as row_numbering, 
rank()  over (partition by department order by salary) as ranking, 
dense_rank()  over (partition by department order by salary) as dense_ranking from employeedetail; 



-- =====================================================================================

use hr;

-- Delimiter //
-- create procedure us_customer23()
-- Begin
-- select location_id , city from locations where country_id='US';
-- end //

-- call  us_customer23();

-- DELIMITER //
-- CREATE PROCEDURE ctr_customers (ctr VARCHAR(50))
-- BEGIN
-- SELECT location_id, city
-- FROM locations
-- WHERE Country_id = ctr;
-- END //

-- call ctr_customers('UK');


CREATE TABLE BookCollection
( BookID INT PRIMARY KEY auto_increment, 
Title VARCHAR(50), 
Author VARCHAR(20),
Genre VARCHAR(25)
);

insert into BookCollection values('1984', 'Orwell','Fiction');
select * from BookCollection;

select Title from BookCollection;

use hr;
select * from employees;

delimiter //
create procedure sal5000()
begin
select first_name,salary+500 from employees;
end //
delimiter ;
call sal5000();

delimiter //
create procedure employee_details_view(n varchar(30))
begin
select concat(first_name," ",last_name),
salary from employees where first_name=n ;
end //
delimiter ;
call employee_details_view('Steven');

-- ==================================================

create database windowFunctionsPractice;
use windowFunctionsPractice;

DROP TABLE IF EXISTS student_score;

CREATE TABLE student_score (
  student_id SERIAL PRIMARY KEY,
  student_name VARCHAR(30),
  dep_name VARCHAR(40),
  score INT
);

INSERT INTO student_score VALUES (11, 'Inaya', 'Computer Science', 80);
INSERT INTO student_score VALUES (7, 'Taiwo', 'Microbiology', 76);
INSERT INTO student_score VALUES (9, 'Nancy', 'Biochemistry', 80);
INSERT INTO student_score VALUES (8, 'Joel', 'Computer Science', 90);
INSERT INTO student_score VALUES (10, 'Mustachio', 'Industrial Chemistry', 78);
INSERT INTO student_score VALUES (5, 'Muritadoh', 'Biochemistry', 85);
INSERT INTO student_score VALUES (2, 'Tasigne', 'Biochemistry', 70);
INSERT INTO student_score VALUES (3, 'Barbarra', 'Microbiology', 80);
INSERT INTO student_score VALUES (1, 'Tomiwa', 'Microbiology', 65);
INSERT INTO student_score VALUES (4, 'Gbadebo', 'Computer Science', 80);
INSERT INTO student_score VALUES (12, 'Tolu', 'Computer Science', 67);

select * from student_score;
-- Tasks:
-- compare the minimum score and maximum score from all the records in the table .
select student_id, student_name dep_name,score , min(score) over (order by score range between unbounded preceding and unbounded following) as minimum_score ,
 max(score)  over (order by score range between unbounded preceding and unbounded following)as maximum_score from student_score;

-- compare the maximum score and average score in each department with the individual score.
select * , max(score) over (partition by dep_name)as max_score,avg(score) over (partition by dep_name)as avg_score from student_score;

-- add row numbers to the dataset based on their names in alphabetical order.
select *,row_number() over (order by student_name)as rownumber from student_score;

-- Provide department wise rank holders based on their score(rank and dense rank 2 queries expected;
select *,rank() over (partition by dep_name order by score desc)as ranking, 
dense_rank() over (partition by dep_name order by score desc )as denserank from student_score;

-- Provide cumulative sum of all the student scores.

select *,sum(score) over ( order by score)as cummulative_sum from student_score;




-- ================= SQL - 06 April ===================================================================

create table employee(name varchar(30) not null, occupation varchar(30) not null, working_date date, working_hours varchar(10));
select * from employee;

INSERT INTO employee VALUES
('Robin', 'Scientist', '2020-10-04', 12), ('Warner', 'Engineer' ,'2020-10-04', 10), ('Peter', 'Actor', '2020-10-04', 13), ('Marco', 'Doctor', '2020-10-04', 14), 
('Brayden', 'Teacher', '2020-10-04', 12), ('Antonio', 'Business', '2020-10-04', 11);

Delimiter //
create trigger before_insert_employee_table
before
insert on employee for each row 
begin
if new.working_hours<0 then set new.working_hours=0;
end if ;
end //
Delimiter ;
insert into employee values('lokesh','engineer','2023-01-16',-5);
show triggers;
Delimiter //
create trigger insert_role_employee_table
before
insert on employee for each row 
begin
if new.occupation='Scientist' then set new.occupation='Doctor';
end if;
end //
Delimiter ;

insert into employee values('vinay','Scientist','2023-02-15',-10);
select * from employee;

-- Create a table named "student_info" as follows:

CREATE TABLE student_info( stud_id int NOT NULL, stud_code varchar(15) DEFAULT NULL, stud_name varchar(35) DEFAULT NULL, 
subject varchar(25) DEFAULT NULL, marks int DEFAULT NULL,phone varchar(15) DEFAULT NULL,
PRIMARY KEY (stud_id));

select * from student_info;

CREATE TABLE student_detail( stud_id int NOT NULL, stud_code varchar(15) DEFAULT NULL, stud_name varchar(35) DEFAULT NULL, 
subject varchar(25) DEFAULT NULL, marks int DEFAULT NULL,phone varchar(15) DEFAULT NULL,lastinserted time,
PRIMARY KEY (stud_id));

select * from student_detail;

Delimiter //
create trigger after_insert_details
after insert on student_info for each row 
begin 
insert into student_detail values(new.stud_id,new.stud_code,new.stud_name, new.subject, new.marks, new.phone, curtime());
end //
Delimiter ;

insert into student_info values(1,101,'ravi','maths',90,'1234567890');

select * from student_detail;

create table sales_info ( 
id int auto_increment,
product varchar (100) not null,
quantity int not null default 0,
fiscalyear smallint not null ,
check (fiscalyear between 2000 and 2050 ),
check (quantity>=0),
unique(product , fiscalyear),
primary key(id));

select * from sales_info;
insert into sales_info (product,quantity,fiscalyear) values ('2003 Maruti Suzuki',110,2020),
('2015 Avengers', 120,2020),('2018 Honda Shine',150,2020),('2014 Apache',150,2020);

Delimiter //
create trigger before_update_salesinfo
before update 
on sales_info for each row 
begin 
declare error_msg varchar(255);
set error_msg=('the new quantity cannot be greater than 2 times the current quantity ');
if new.quantity>old.quantity*2 then 
signal SQLSTATE '45000'
set message_text =error_msg;
end if;
end //
Delimiter ;

create database futurense_sql_project;
