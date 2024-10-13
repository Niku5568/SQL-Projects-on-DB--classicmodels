SELECT * FROM classicmodels.orders;

-- where order not shipped
select * 
from orders
where status != "Shipped";

select * 
from orders
where status <> "Shipped";

-- exercise --

SELECT * FROM classicmodels.products;

-- select * from products limit 5;

-- Where Clause

select 
productCode,
productName,
buyPrice,
MSRP as "selling price",
(MSRP*0.90) as "10 % discount on selling price" 
from products;

SELECT * FROM payments
where amount >= 40000;

-- logic operator (AND / OR)

SELECT * FROM payments where amount > 40000 and amount < 60000;

SELECT * FROM payments where not (amount > 40000 and amount < 60000);

SELECT * FROM payments where (amount > 40000 or amount < 60000);

SELECT * FROM payments where (amount <= 40000 or amount >= 60000) and paymentDate >= "2005-05-25";

select * from employees where officeCode =1 ;

select * from employees where officeCode !=1 ;

-- IN Membership Operator
select * from employees where officeCode =1 or officeCode =2 or officeCode =4;

select * from employees where officeCode in (1,2,4);

-- Between 

select * from customers where creditLimit between 20000 and 40000;


SELECT * FROM payments where paymentDate between "2003-05-31" and "2004-05-31";

-- Like
select * from employees where jobTitle like "%sale%"

select * from employees where firstName like "%y"

select * from employees where firstName like "____y"

-- REGEXP -----
-- --------------------- 
-- ^ begning of string
-- % ending of string 
-- ! logical or
-- [abcd]
-- a-b
-- --------------------- 
select * from employees jobtitle;

select * from employees where jobTitle regexp "sale";

-- Job title start with word sale -> ^
select * from employees where jobTitle regexp "^sale";


-- Job title ends with word rep -> $
select * from employees where jobTitle regexp "rep$";

-- firstname begin with a or l \ abcdef

select * from employees where firstName regexp "^[al]";

select * from employees where firstName regexp "^[abcdef]";

select * from employees where firstName regexp "^[al]";

-- exercise -> select firstname begin with a- h or names end with lie 

select * from employees where firstName regexp "^[a-h]|lie$";

-- find the customer whos number ends with 55

select * from customers where phone regexp "[|55&]";

-- IS NULL and IS NOT NULL
SELECT * FROM orders WHERE comments IS NULL;

SELECT * FROM orders WHERE shippedDate IS NULL;

SELECT * FROM orders WHERE shippedDate IS NOT NULL;

select * from customers where state is not null;

-- ORDER BY CLAUSE
-- ---------------------
select * from customers order by city desc;

select customerNumber,contactLastName,contactFirstName, city from customers order by city desc;

-- 2 column order by
select customerNumber,contactLastName,contactFirstName, city from customers order by city desc, contactFirstName;

-- limit - work like range function (start, end, gape)

-- first 10 records
select * from customers limit 10;

-- next 10 records
select * from customers limit 20,10;

-- Exercise 
-- find out top 5 customer who have highest credit limit

select * from customers order by creditLimit desc limit 5;


