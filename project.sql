DROP TABLE if exists retail_sales;
create table retail_sales(
		transaction_id INT PRIMARY KEY,	
		sale_date DATE,	 
		sale_time TIME,	
		customer_id	INT,
		gender	VARCHAR(30),
		age	INT,
		category VARCHAR(30),	
		quantity	INT,
		price_per_unit FLOAT,	
		cogs	FLOAT,
		total_sale FLOAT
)
select * from retail_sales
limit 10

select count(*) from retail_sales

-- Data cleaning

select * from retail_sales
where 
	transaction_id is NULL
	OR
	sale_date is NULL
	OR
	sale_time is NULL
	OR
	customer_id is NULL
	OR
	gender is NULL
	OR
	age is NULL
	OR
	category is NULL
	OR
	quantity is NULL
	OR
	price_per_unit is NULL
	OR
	cogs is NULL
	OR
	total_sale is NULL

delete from retail_sales
where
	transaction_id is NULL
	OR
	sale_date is NULL
	OR
	sale_time is NULL
	OR
	customer_id is NULL
	OR
	gender is NULL
	OR
	age is NULL
	OR
	category is NULL
	OR
	quantity is NULL
	OR
	price_per_unit is NULL
	OR
	cogs is NULL
	OR
	total_sale is NULL

select count(*) from retail_sales

-- Data Exploration

-- how many total sales
select count(*) as total_sale from retail_sales

-- number of unique customers
select count(distinct customer_id) from retail_sales

-- number of unique category
select distinct category from retail_sales

-- Data Analysis

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

-- Q1
select * 
from retail_sales
where sale_date = '2022-11-05';

-- Q2

select *
from retail_sales
where
	category = 'Clothing'
	AND
	quantity >= 4
	AND 
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'

-- Q3

select 
	category,
	sum(total_sale) as net_sale,
	count(*) as total_order
from retail_sales
group by 1 

-- Q4

select ROUND(AVG(age),2) as avg_age 	
from retail_sales
where 
	category = 'Beauty'

-- Q5
select * from retail_sales
where total_sale > 1000

-- Q6 
select 
	category,
	gender,
	count(*) as total_transactions
from retail_sales
group
	by
	category,
	gender
order by 1

-- Q7
SELECT year, month, avg_sale
FROM 
(    
	SELECT 
	    EXTRACT(YEAR FROM sale_date) as year,
	    EXTRACT(MONTH FROM sale_date) as month,
	    AVG(total_sale) as avg_sale,
	    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
	FROM retail_sales
	GROUP BY 1, 2
) as t1
WHERE rank = 1 

--Q8
SELECT
	customer_id, 
	SUM(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5

--Q9

select category, 
		count(distinct customer_id) as distinct_customers 
from retail_sales
group by 1





