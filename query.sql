use sakila;
select payment_id , customer_id,amount from payment where amount >(select amount from payment where payment_id = 247);

select payment_id , customer_id, amount from payment where amount> (select avg(amount) from payment ); 

# Q.1 get those customer id and the number of amount where the number of amount is less than the number of customer_id 1

select customer_id , count(amount) as totalcount
from payment group by customer_id
having  count(amount) <(select count(customer_id) from payment where customer_id=1) 
order by totalcount;

select payment_id , customer_id, amount from payment where amount in (select amount from payment where customer_id =1) ;

select payment_id , customer_id, amount from payment where amount = any(select amount from payment where customer_id =1) ;

select payment_id , customer_id, amount from payment where amount > any(select amount from payment where customer_id =1) ;

select payment_id , customer_id, amount from payment where amount < any(select amount from payment where customer_id =61) ;

select payment_id , customer_id, amount from payment where amount > all(select amount from payment where customer_id =61) ;

select customer_id , amount 
from payment where exists ( select customer_id from payment group by customer_id);
create table customerOrder  (select customer_id , amount from payment );
select * from customerOrder;

select * from payment where exists(select customer_id from customerOrder );

#CRreate , retrieve
# update , delete , drop , truncate , alter 
select * from customerOrder;

update customerOrder set amount=100;
update customerOrder set amount = (select avg(amount) from customerOrder where customer_id=7 group by customer_id) where customer_id=3;
 # you need to update the amount of customer-Id as equal to the average amount of customer_id 7
 # 
 
 #delete
 
 delete from customerOrder;
 drop table customerOrder;
 
 create table customerOrder as select * from payment ;
 select * from customerOrder;
 # end the transaction
 truncate customerOrder;
 
 drop table customerOrder;
 
 alter table customerOrder
 drop column last_update;
 
 -- add column called first name of varchar(20) data type , then change the column name firstname to full name , and datatype will be changed to char(20)
 
 alter table customerOrder add column first_name varchar(20) ;
 alter table customerOrder change column first_name full_name char(20);
 
 
 # Q1. add a column age in the starting place of your table 
 select * from customerOrder;
 alter table customerOrder add column age int FIRST;
 
 # Q2. create a salary column of varchar data type , insert a value , then change varchar to int data type:
			#a. the data can be loose
			#b. the data must not be loose
alter table customerOrder add column salary varchar(20) default "123";  
alter table customerOrder modify column salary int ;   
desc customerOrder;       
# Q3. add a address column after the Id 
alter table customerOrder add column address varchar(50) AFTER customer_id; 
# Q4. create a column with the name pincode having a default value as 49946 and make sure that the pincode should not be of more than 49946.
alter table customerOrder add column pincode int check( pincode < 49946) default 49945; 
update customerOrder set pincode = 123475 where rental_id =1185;
# Q5. we have to drop the primary key constraint from the same table 
desc customerOrder;
alter table customerOrder add constraint primary key(rental_id);
alter table customerOrder drop primary key;
# Q6. make the pincode as a primary key constraint 
			#chnage the constraint name of pincode 
alter table customerOrder add constraint primary key(rental_id);

            
# Q.. what is character set and collate ?




#  	CTE
use learning;
CREATE TABLE if not exists customers (
        id INT PRIMARY KEY AUTO_INCREMENT,
        first_name VARCHAR(50),
        last_name VARCHAR(50),
        email VARCHAR(50)
    );
desc customers;
     
    CREATE TABLE orders (
        id INT PRIMARY KEY AUTO_INCREMENT,
        order_date DATE,
        amount DECIMAL(8,2),
        customer_id INT,
        FOREIGN KEY (customer_id) REFERENCES customers(id)
    );
     
    INSERT INTO customers (first_name, last_name, email) 
    VALUES ('Boy', 'George', 'george@gmail.com'),
           ('George', 'Michael', 'gm@gmail.com'),
           ('David', 'Bowie', 'david@gmail.com'),
           ('Blue', 'Steele', 'blue@gmail.com'),
           ('Bette', 'Davis', 'bette@aol.com');
	select * from customers;
           
    INSERT INTO orders (order_date, amount, customer_id)
    VALUES ('2016-02-10', 99.99, 1),
           ('2017-11-11', 35.50, 1),
           ('2014-12-12', 800.67, 2),
           ('2015-01-03', 12.50, 2),
           ('1999-04-11', 450.25, 5);
           
	select  customers.name, orders.id , orders.amount 
    from customers inner join orders on customers.id=orders.customer_id;
    
    
	-- SQL - views , indexes , cursor , windows , triggers ,pivots 
    -- group by vs windows , type of indexings , how a user defined index is separate from primary key , cursors , procedures and function
    
    -- big data - hadoop , ecosystem , HDFS , mapreduce , mapreduce vs yarn , 
    -- hadoop vs data warehouse , hadoop version 1 vs 2 ,daemons in hadoop and hive
    -- name node , data node , client node
    
    -- hive - partitioning and bucketing , join , bucket join , reading compress file 
    -- census 
    
    
    use project;
    show triggers; 
    drop trigger update_government_hospital_trigger;
    drop trigger update_goverment_hospital_beds_trigger;
    
    create database training;
    use training;
    create table orders(
    orderid int, customerid int , orderdate date);
    select * from orders;
    insert into orders values (10308,2,'1996-09-18');
    insert into orders values (10309,37,'1996-09-19');
    insert into orders values (10310,77,'1996-09-20');
    
    create table customers(
    customerid int, customername varchar(30),contactname varchar(30), country varchar(30));
    select * from customers;
    
    insert into customers values(1,'alfred futterkiste','maria anders', 'germany');
    insert into customers values(2,'ana trujillo ','ana trujilo','mexico');
    insert into customers values(3,'antinio moreno','antonio','mexico');
    insert into customers values(77,'aman','nitin','india');
    
    select o.orderid,c.customername from orders o , customers c where o.customerid=c.customerid;
    
	-- left outer join

    select customers.customername, orders.orderid
    from customers
    left join orders on customers.customerid=orders.customerid
    order by customername;
    
     
	-- right outer join
    select customers.customername, orders.orderid
    from customers
    right join orders on customers.customerid=orders.customerid
    order by customername;
    
    
    -- cross join 
    select customers.customername, orders.orderid
    from customers
    cross join orders
    order by customername;
   