-- -------------------
# Group By
-- ------------------
SELECT count(*) FROM products;
select distinct productline from products;

-- ------------------------
# Query  1 - no of products  in each product line
-- ------------------------
SELECT productline,count(*) 
from products 
group by productline;

-- ------------------------------------------------------------------------------------------
# Query 2 : count of employees, display office code, location that work in the same office
-- ------------------------------------------------------------------------------------------
select * from employees;
select * from Offices;

select officeCode,
	   count(employeeNumber) as employee_count, city,state
from employees join offices using (officeCode)
group by officeCode;

-- -------------------------
# Having 
-- ---------------------------------------------------
-- Query 1 : offic have more than 4 employees
-- ---------------------------------------------------
select officeCode,
	   count(employeeNumber) as employee_count, city
from employees join offices using (officeCode)
group by officeCode
having employee_count ;

-- ------------------------------------------
select officeCode,
	   count(employeeNumber) as employee_count, city
from employees join offices using (officeCode)
where officeCode in (1,2,4,5) -- filter out rows befor grouping
group by officeCode;

-- -------------------------------------------
select officeCode,
	   count(employeeNumber) as employee_count, city
from employees join offices using (officeCode)
group by officeCode
having employee_count >4 ; -- filter rows after grouping
-- ---------------------------------------------
select officeCode,
	   count(employeeNumber) as employee_count, city
from employees join offices using (officeCode)
where officeCode in (1,2,4,5) -- filter out rows befor grouping
group by officeCode
having employee_count >4 ; -- filter rows after grouping

# how it works
-- from -> where -> group by -> having -> select -> distinct -> order by -> limit 

-- -------------------------------------------------------------------------
# Query 2 : country wise no of orders,  display total order count > 20 
-- -------------------------------------------------------------------------
select * from orders;
select * from customers;

select country,count(orderNumber) as total_orders from orders 
join customers using (customerNumber)
group by country 
having total_orders > 20;
-- ---------------------------------------------------------------------
select country,count(*) as total_orders from orders 
join customers using (customerNumber)
group by country 
having total_orders > 20;

-- ---------------------------------------------------------------------
#  show only orders of country - "France","Japan", "Finland","USA"
-- ---------------------------------------------------------------------
select country,count(*) as total_orders from orders 
join customers using (customerNumber)
where country in ("France","Japan", "Finland","USA")
group by country 
having total_orders > 20;

