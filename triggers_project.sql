create table students(
id int not null auto_increment,
name varchar(45) not null,
class int not null,
email_id varchar(65) not null,
primary key(id));
select * from students;

insert into students(name,class,email_id) values('Stephen',6,'stephen@project.com'),
('Bob',7,'bob@project.com'),
('Steven',8,'steven@project.com'),
('Alexandar',7,'alexandar@project.com');

create table student_log(
user varchar(45) not null,
descriptions varchar(100) not null);

Delimiter //
create trigger after_update_studentinfo
after update 
on students for each row
begin
insert into student_log values(user(),concat('Updated student Record',old.name,' Previous Class :',old.class,' Present class :',new.class));

end //
Delimiter ;
set sql_safe_updates=0;
update students set class=class+1;
select * from student_log;

create table salaries(emp_num int primary key,valid_from date not null,
amount dec(8,2) not null default 0);

select * from salaries;

insert into salaries values (102,'2020-01-10',45000),
(103,'2020-01-10',65000),
(107,'2020-01-10',75000),
(105,'2020-01-10',55000),
(109,'2020-01-10',40000);


create table salary_archives(
id int primary key auto_increment,
emp_num int,
valid_from date not null,
amount dec(8,2) not null default 0,
deleted_time timestamp default now() );

select * from salary_archives;

Delimiter //
create trigger before_delete_salaries
before delete
on salaries for each row
begin
insert into salary_archives (emp_num,valid_from, amount) values (old.emp_num, old.valid_from, old.amount);

end //
Delimiter ;

delete from salaries where emp_num=105;

create table total_salary_budget(
total_budget decimal(10,2) not null);

select * from total_salary_budget;

insert into total_salary_budget(total_budget) select sum(amount) from salaries;

Delimiter //
create trigger after_delete_salaries
after delete
on salaries for each row
begin
update total_salary_budget set total_budget=total_budget-old.amount;
end //
Delimiter ;

delete from salaries where emp_num=102;
-- ======================== 11 April 2023 ==================================

Delimiter //
create procedure getofficebycountry( IN countryname varchar(255))
begin
select * from offices where country=countryname;
end //
Delimiter ;

call getofficebycountry('USA');

Delimiter //
create procedure getordercountbystatus( in orderstatus varchar(25), out total int)
begin
select count(ordernumber) into total from orders where status=orderstatus;
end //
Delimiter ;

call getordercountbystatus('shipped',@total);
select @total;
call getordercountbystatus('on Hold',@total);
select @total;

Delimiter //
create procedure inoutDemo (inout par int)
begin
select count(*) into par
from payments where amount<par;
end //
Delimiter ;

set @par=6066.78;
call inoutDemo(@par);
select @par;

Delimiter //
create function customerlevel( credit Decimal(10,2))
returns varchar(30)
deterministic
begin
declare customerlevel varchar(30);
if credit>5000 then set customerlevel="Platinum";
elseif(credit <=5000 and credit>=1000) then set customerlevel="Gold";
elseif credit <10000 then set customerlevel="Silver";
end if;
return(customerlevel);
end //
Delimiter ;

select customerName, customerLevel(creditLimit) from customers order by customerName;

Delimiter //
create procedure getcustomerlevel( in customerno int, out customerlevel varchar(20))
begin 
declare credit dec(10,2) default 0;
select creditlimit into credit from customers where customerNumber =customerno;
set customerlevel=customerlevel (credit);
end //
Delimiter ;
call getcustomerlevel (131, @customerlevel);
select @customerlevel;