# subquery - query under query like nested if else or nested loop in python.
-- -------------------------------------------------------------------------------------
# Query 1:  Find products that have same product line as of "1917 Grand Touring Seadan"  
-- -------------------------------------------------------------------------------------
select * from  products
where productLine = "Vintage Cars";

select productLine from  products
where productName = "1917 Grand Touring Sedan";

-- --------------------------------------
# creating subquery
-- --------------------------------------
select * from  products
where productLine =  
(select productLine from  products 
where productName = "1917 Grand Touring Sedan");

-- -------------------------------------------------------------------------------------
# Query 2:  Find cars that are costlier than "1936 Mercedes-Benz 500K Special Roadster".
-- -------------------------------------------------------------------------------------

select * from products
where buyPrice > 24.26;

select * from products
where productName = "1936 Mercedes-Benz 500K Special Roadster";

# Subquery
select * from products
where productLine regexp "Cars" and MSRP > (select MSRP from products
where productName = "1936 Mercedes-Benz 500K Special Roadster");


-- -------------------------------------------------------------------------------------
# Query 3:   find the cars that are costlier than average cost of all cars
-- -------------------------------------------------------------------------------------
select * from products
where productLine regexp "Cars" and MSRP > (select avg(MSRP) from products
where productLine in ("Classic Cars","Vintage Cars") );

select * from products
where productLine regexp "Cars" and MSRP > (select avg(MSRP) from products );

-- -------------------------------------------------------------------------------------
# Query 4: custome who has never placed an orders (subqueries and join)
-- -------------------------------------------------------------------------------------

select customerNumber from customers;
select distinct customerNumber from orders;

# subquery: - 
select customerNumber from customers
where customerNumber not in (select distinct customerNumber from orders);

# same query using join
select * from customers left join orders using (customerNumber)
where orderNumber is null;

-- -------------------------------------------------------------------------------------
# Query 5:  customer who ordered the product with product code "S18_1749"
# (example where join is prefrred over subquery)
-- -------------------------------------------------------------------------------------
select count(customerNumber) from orderdetails
join orders using (orderNumber) 
where productCode = "S18_1749" ;

# using subquery
select * from customers
where customerNumber in (select customerNumber from orderdetails
join orders using (orderNumber) 
where productCode = "S18_1749" );

# using join function
select distinct * from customers
join orders using (customerNumber)
join orderdetails using (orderNumber)
where productCode = "S18_1749";

-- -------------------------------------------------------------------------------------
-- ------------------------------ All Keyword ------------------------------------------
# Query 6: Find products costlier than all trucks	 
-- -------------------------------------------------------------------------------------

select * from products 
where MSRP > (
select max(MSRP) from products 
where productLine regexp "truck");

-- using all keywords
select * from products 
where MSRP > all(
select max(MSRP) from products 
where productLine regexp "truck");


-- -------------------------------------------------------------------------------------
-- ------------------------------ Any Keyword ------------------------------------------
# Query 7: select clients who has made atleast two payments 
-- -------------------------------------------------------------------------------------

select * from customers
where customerNumber in (
select customerNumber from payments
group by customerNumber
having count(amount) >= 2); 

select * from customers
where customerNumber =any (
select customerNumber from payments
group by customerNumber
having count(amount) >= 2); 


-- --------------------------------------------------------------------------------------------
-- ------------------------------ Correlated Subquery (always Depends on main query) -----------
# Query 8: find products whose price higher than average MSRP in their corrosponding line 
-- ---------------------------------------------------------------------------------------------

select * from products p
where MSRP > (
select avg(MSRP) from products
where productLine = p.productLine
)


-- --------------------------------------------------------------------------------------------
-- -----------------------------------------  Exists ------------------------------------------
# Query 9: select customer who made any payment

select * from customers 
where customerNumber in (
select distinct customerNumber
from payments);


select * from customers 
where customerNumber (select distinct customerNumber
from payments);
# using exists--------------------------------------
select * from customers c
where exists (
select customerNumber
from payments
where customerNumber=c.customerNumber);


-- --------------------------------------------------------------------------------------------
-- -----------------------------------------  Subquery in Select clause -----------------------
# Query 10: write a query create the following "view" of payment table
-- --------------------------------------------------------------------------------------------

select *, (select avg(amount) from payments) as Avg_amount,
amount - (select avg_amount) as Diffrence
from payments;

-- --------------------------------------------------------------------------------------------
-- -----------------------------------------  Subquery in From clause -------------------------
# Query 10: write a query create the following "view" of payment table where differnce > 0 
# (amount is higher than average)
-- --------------------------------------------------------------------------------------------

select * from 
(select *, 
(select avg(amount) from payments) as Avg_amount,
amount - (select avg_amount) as Diffrence
from payments) as pay
where Diffrence > 0;




-- ---------------------------------------------------------------------------------------------