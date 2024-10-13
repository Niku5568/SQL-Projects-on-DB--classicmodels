# Question1: Total payment from each customer after a certain date 
-- -----------------------------------------------------------------
select * from payments;

select customerNumber,sum(amount) as total_amount, customerName 
from payments join customers using (customerNumber)
where paymentDate > "2002-02-02"
group by customerNumber
order by customerNumber, customerName ;

-- ---------------------------------------------------------------------------------------
# Question2: value of each unique order sorted by total order values
-- ----------------------------------------------------------------------------------------
select orderNumber,sum(quantityOrdered*priceEach) as order_total 
from orderdetails 
group by orderNumber
order by order_total desc ;


-- ---------------------------------------------------------------------------------------
# Question3: value of each unique order and it's customer name sorted by total order values
-- ----------------------------------------------------------------------------------------
select * from orderdetails;
select * from orders;
select * from customers;

select orderNumber,customerNumber,customerName,sum(quantityOrdered*priceEach) as order_total 
from orderdetails 
join orders using (orderNumber) 
join customers using (customerNumber)
group by orderNumber
order by order_total desc;


-- ---------------------------------------------------------------------------------------
# Question 4: value of each unique order and it's customer name and sales employees sorted by total order values
-- ----------------------------------------------------------------------------------------

select * from orderdetails;
select * from orders;
select * from customers;

select orderNumber,customerNumber,customerName,
sum(quantityOrdered*priceEach) as order_total, salesRepEmployeeNumber, 
concat(emp.firstName," ",emp.lastName) as salesRepEmployeeName
from orderdetails 
join orders using (orderNumber) 
join customers using (customerNumber)
join employees as emp on (salesRepEmployeeNumber = employeeNumber)
group by orderNumber
order by order_total desc;


-- ---------------------------------------------------------------------------------------
# Question 5: Number of orders placed by each customers and sales employee of that customer.
-- ----------------------------------------------------------------------------------------

select * from employees;
select * from orders;
select * from customers;

select customerNumber,count(*) as Total_Order,  
salesRepEmployeeNumber as emp_number, concat(firstName," ",lastName) as emp_name
from orders 
join customers using(customerNumber)
join employees on ( salesRepEmployeeNumber = employeeNumber)
group by customerNumber;


-- ---------------------------------------------------------------------------------------
# Question 6: Number of orders Through each sales employee/Representive.
-- ----------------------------------------------------------------------------------------

select employeeNumber, concat(firstName," ",lastName) as emp_name, count(orderNumber) as total_orders
from orders 
join customers using (customerNumber)
join employees on ( salesRepEmployeeNumber = employeeNumber)
group by employeeNumber
order by total_orders desc;

-- ---------------------------------------------------------------------------------------
# Question 6: Number of orders country wise
-- ----------------------------------------------------------------------------------------
select * from orders;
select * from customers;

select country,orderDate,count(*) as total_orders from orders
join customers using (customerNumber)
group by country,orderDate
order by country,orderDate;


-- ---------------------------------------------------------------------------------------
# Question 7: find the customers from france whose total orders values > 80,000 across all thier orders
-- ----------------------------------------------------------------------------------------

select customerNumber,customerName,sum(quantityOrdered*priceEach) as order_values from customers
join orders using (customerNumber)
join orderdetails using (orderNumber)
where country = "France"
group by customerNumber,customerName
having order_values> 80000
order by order_values desc;
