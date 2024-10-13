-- ----------------------------
# Summarising Data
-- ----------------------------
-- Real Life Business case 
-- # No of order placed daily/ monthly / year
-- # No of unique customer every month
-- # year wise increase in profit/ sales
-- # monthwise increase in enrollment
-- # average rating per course
-- -----------------------------------------
-- Aggregate Function in MySQL
-- -----------------------------------------
-- # MAX()
-- # MIN()
-- # AVG()
-- # SUM()
-- # COUNT()

-- -------------------
# Query 1
-- ------------------
select sum(amount) as Total_Payment,
max(amount) as Highest_Sale,
min(amount) as Lowest_Sale,
avg(amount) as Avg_Sale,
count(amount) as Total_Transaction
from payments;


-- -------------------
# Query 2
-- ------------------
select count(requiredDate) as Total_Orders,
		count(shippedDate) as shipped_orders,
        ( count(requiredDate) - count(shippedDate)) as pending_orders
from Orders;

-- -------------------
# Query 3
-- ------------------
select count(*) as under_processing
from orders
where status="In Process";

-- -------------------
# Query 4
-- ------------------
select max(paymentDate) as recent_last_date,
min(paymentDate) as oldest_data
from payments;

-- -------------------
# Query 5
-- ------------------
select max(checkNumber),
min(checkNumber)
from payments;

-- -------------------
# Query 6
-- ------------------
SELECT * FROM products;
-- -------------------
# Group By
-- ------------------

