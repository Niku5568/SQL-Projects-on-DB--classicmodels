-- ----------------------
# inner join
-- ---------------------
select * from payments;
select * from customers;

select * from payments inner join customers on payments.customerNumber = customers.customerNumber;

select payments.customerNumber,
		checkNumber,
		paymentDate,
		amount,
		customerName 
from payments 
inner join customers 
on payments.customerNumber = customers.customerNumber;


-- ----------------------
# Joining multiple tables 
-- ---------------------
# Question: 
# review order tables and 
# find the customername and sales representative number from customer table and 
# representative name from employees tables

select * from orders;
select * from customers;
select * from employees;

select * from orders o join customers c
on o.customerNumber = c.customerNumber;

select orderDate,
		orderNumber,
		status,
		o.customerNumber,
		c.customerName,
		c.salesRepEmployeeNumber, 
		concat(firstName," ", lastName) as "Sales Person Name",
		e.jobTitle
from orders o join customers c
on o.customerNumber = c.customerNumber
join employees e on c.salesRepEmployeeNumber =e.employeeNumber
order by "Sales Person Name";	

-- ----------------------
# Self Join -> join tables with itself
-- ---------------------

select * from employees;

select emp.*,mgr.firstName from employees as emp join employees mgr on emp.reportsTo = mgr.employeeNumber;

select emp.*,concat(mgr.firstName," ",mgr.lastName) as "manger" from employees as emp join employees mgr on emp.reportsTo = mgr.employeeNumber;

-- ----------------------
# implicit Join - without using join function with using where clause.
-- ---------------------
select payments.customerNumber,
		paymentDate,
		amount,
		customerName 
from payments, customers
where payments.customerNumber = customers.customerNumber;

-- ----------------------
# Outer Join
-- ---------------------

-- customer -> what orders have placed by each customer?
-- inner join -(problem - we don't get customers who has not placed any orders.)

select * from customers; 
select * from orders; 

select c.customerNumber,contactFirstName,o.orderNumber from customers as c join orders as o
on c.customerNumber = o.customerNumber
; 

-- select customers who has not placed any orders (subquery)
select customerNumber from customers as c where c.customerNumber not in (select distinct o.customerNumber from orders as o);

# for every customers, show the order that a customer has placed.
select c.customerNumber,contactFirstName,o.orderNumber 
from customers as c 
left join orders as o
on c.customerNumber = o.customerNumber; 


select c.customerNumber,contactFirstName,o.orderNumber 
from customers as c 
right join orders as o
on c.customerNumber = o.customerNumber; 

-- ----------------------
# Explicit Join - using join function
-- ---------------------

select payments.customerNumber,
		paymentDate,
		amount,
		customerName 
from payments 
join customers 
on payments.customerNumber = customers.customerNumber;


-- ----------------------
# self join
-- ---------------------
select emp.employeeNumber,
concat(mgr.firstName," ",mgr.lastName) as "Manger",
mgr.jobTitle as "Manger Title"
from employees as emp join employees mgr on emp.reportsTo = mgr.employeeNumber;

-- ----------------------
# self outer join -> find all the all the employee name by using self outer join
-- ---------------------
select emp.employeeNumber,
concat(emp.firstName," ",emp.lastName) as "Employee",
emp.jobTitle,
concat(mgr.firstName," ",mgr.lastName) as "Manger",
mgr.jobTitle as "Manger Title"
from employees as emp left join employees mgr on emp.reportsTo = mgr.employeeNumber;

-- ----------------------
# Using clause - only used when column name same in both tables like below.
-- ---------------------
select c.customerNumber,contactFirstName,o.orderNumber 
from customers as c 
left join orders as o
on c.customerNumber = o.customerNumber; 

select c.customerNumber,contactFirstName,o.orderNumber 
from customers as c 
left join orders as o
using (customerNumber); 

select c.customerNumber,contactFirstName,o.orderNumber 
from customers as c 
join orders as o
using (customerNumber); 

# multiple tables with USING clause
    
select orderDate,
		orderNumber,
		status,
		o.customerNumber,
		c.customerName,
		c.salesRepEmployeeNumber, 
		concat(firstName," ", lastName) as "Sales Person Name",
		e.jobTitle
from orders o join customers c
using (customerNumber)
join employees e on c.salesRepEmployeeNumber =e.employeeNumber
order by "Sales Person Name";	



-- ----------------------
# Natural Join  -> we don't specify the columns -> loose control on tables and join methods
-- ---------------------
select * from orders natural join customers;



