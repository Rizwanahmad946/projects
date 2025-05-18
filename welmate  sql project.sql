SELECT * FROM walmartsales.sales;

#----------------------------------------------------------### Generic Question ###--------------------------------------------------------------------------------------------

-- 1. How many unique cities does the data have?
-- 2. In which city is each branch?

select distinct city from sales;
select distinct branch,city from sales;

#---------------------------------------------------------------### Product###---------------------------------------------------------------------------------------------------------------

-- 1. How many unique product lines does the data have?
      select distinct product_line from sales;
-- 2. What is the most common payment method?
      select count(payment) as c,payment from sales group by payment order by c desc limit 1; 
-- 3. What is the most selling product line?
      select count(product_line) as p,product_line from sales group by product_line order by p desc;
-- 4. What is the total revenue by month?
      SELECT MONTH(date) as month, SUM(total) as revenue from sales GROUP BY MONTH(date) ORDER BY month;
-- 5. What month had the largest COGS?
      select month(date) as month,max(COGS) as m from sales group by month(date) order by m desc; 
-- 6. What product line had the largest revenue?
      select max(total) as max_total,product_line from sales group by product_line order by max_total desc;
-- 5. What is the city with the largest revenue?
      select max(total)as max_revenue,city from sales group by city order by max_revenue desc;
-- 6. What product line had the largest VAT?
      select max(tax_pct) as max_vat,product_line from sales group by product_line order by max_vat desc;
-- 7. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
      SELECT AVG(quantity) AS avg_qnty FROM sales;
	  SELECT product_line,CASE
		WHEN AVG(quantity) >= 5 THEN "Good"
        ELSE "Bad"
    END AS remark
    FROM sales
    GROUP BY product_line;
-- 8. Which branch sold more products than average product sold?
      select branch,sum(quantity) as qnt from sales group by branch having sum(quantity) > (select avg(quantity)as avg_qnt from sales);
 -- 9. What is the most common product line by gender?
     select gender,product_line,count(gender) as gen from sales  group by gender,product_line order by gen desc;
-- 12. What is the average rating of each product line?
       select avg(product_line) as avg_rating,product_line from sales group by product_line;

-- --------------------------------------------------------------### Sales ###------------------------------------------------------------------------------------------------------------------

-- 1. Number of sales made in each time of the day per weekday
      SELECT
	time_of_day,
	COUNT(*) AS total_sales
FROM sales
WHERE day_name = "Sunday"
GROUP BY time_of_day 
ORDER BY total_sales DESC;
 # 2. Which of the customer types brings the most revenue?
 SELECT
	customer_type,
	SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue;
-- 3. Which city has the largest tax percent/ VAT (**Value Added Tax**)?
SELECT
	city,
    ROUND(AVG(tax_pct), 2) AS avg_tax_pct
FROM sales
GROUP BY city 
ORDER BY avg_tax_pct DESC;
-- 4. Which customer type pays the most in VAT?
SELECT
	customer_type,
	AVG(tax_pct) AS total_tax
FROM sales
GROUP BY customer_type
ORDER BY total_tax;

-- ---------------------------------------------------------------------### Customer###----------------------------------------------------------------------------------------

-- 1. How many unique customer types does the data have?
      select distinct customer_type from sales ;
-- 2. How many unique payment methods does the data have?
      select distinct payment from sales ;
-- 3. What is the most common customer type?
      select customer_type,count(*) as ct from sales group by customer_type order by ct desc;
-- 4. Which customer type buys the most?
      SELECT customer_type, COUNT(*) FROM sales GROUP BY customer_type;
-- 5. What is the gender of most of the customers?
      select gender,count(*) from sales group by gender ;
-- 6. What is the gender distribution per branch?
      SELECT gender,COUNT(*) as gender_cnt FROM sales WHERE branch = "C" GROUP BY gender ORDER BY gender_cnt DESC; 

#--------------------------------------------------------### Add the time_of_day column ###-----------------------------------------------------------------------------------------
SELECT
	time,
	(CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_day
FROM sales;


ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

#---------------------------------------------------------- For this to work turn off safe mode ---------------------------------------------------------------------------------

UPDATE sales SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);


#-------------------------------------------------------------### ADD DAY_NAME COLUMN ###--------------------------------------------------------------------------------------
SELECT date,DAYNAME(date)FROM sales;
ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);
UPDATE sales SET day_name = DAYNAME(date);

----------------------------------------### ADD MONTH_NAME COLUMN ###-------------------------------------------------------------------------------------------------------

SELECT date, MONTHNAME(date)FROM sales;
ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);
UPDATE sales SET month_name = MONTHNAME(date);

-- 7. Which time of the day do customers give most ratings?
     SELECT time_of_day,AVG(rating) AS avg_rating FROM sales GROUP BY time_of_day ORDER BY avg_rating DESC;
-- 8. Which time of the day do customers give most ratings per branch?
      SELECT time_of_day,AVG(rating) AS avg_rating FROM sales WHERE branch = "A"GROUP BY time_of_day ORDER BY avg_rating DESC;
-- 9. Which day fo the week has the best avg ratings?
      SELECT day_name,AVG(rating) AS avg_rating FROM sales GROUP BY day_name ORDER BY avg_rating DESC;
-- 10. Which day of the week has the best average ratings per branch?
       SELECT day_name,COUNT(day_name) total_sales FROM sales WHERE branch = "C"GROUP BY day_name ORDER BY total_sales DESC;
