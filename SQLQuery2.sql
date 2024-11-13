select * from project.[dbo].[SQL - RSA]
--#data cleaning
--to find any columns with null values
where transactions_id is null or
 sale_date is null or
  sale_time is null or
 customer_id is null or
 gender is null or
 age is null or
 category is null or
 quantiy is null or
 price_per_unit is null or
 cogs is null or
 total_sale is null	

 --To delete unnecessary columns
 delete from project.[dbo].[SQL - RSA] where quantiy is null 

 
--To find number of sales by each customers
select customer_id,count(*)as No_of_sales from project.[dbo].[SQL - RSA]
group by customer_id
order by customer_id

--Finding sales on 2202-11-05
select * from project.[dbo].[SQL - RSA] 
where sale_date='2022-11-05'

--sales done during nov-2022 in clothing category where quantity is more than 3
select * from project.[dbo].[SQL - RSA]
where category='clothing' and quantiy>3 and month(sale_date) =11 and year(sale_date)=2022

--total sales in each category
select category,sum(total_sale)
from project.[dbo].[SQL - RSA]
group by category

--average age of customers purchased in beauty category
select avg(age) as average_age
from project.[dbo].[SQL - RSA]
where category ='Beauty'

--Sales greater than 1000
select * from project.[dbo].[SQL - RSA] 
where total_sale>1000

--transactions made by each gender in each category
select count(transactions_id),gender,category
from project.[dbo].[SQL - RSA] 
group by gender,category


--average sale in each month
select avg(total_sale),month(sale_date)
from project.[dbo].[SQL - RSA] 
group by month(sale_date)
order by month(sale_date)

--month with maximum sale in a year
with CTE as
(
select avg(total_sale) as b,month(sale_date) as c,year(sale_date) as d
from project.[dbo].[SQL - RSA] 
group by month(sale_date),year(sale_date)
--order by c
)
select max(b),d from CTE
group by d
order by d

--top 5 customers based on total_sale
select top 5 sum(total_sale) z,customer_ID from project.[dbo].[SQL - RSA]
group by customer_ID
order by z desc

--unique customers in each category
select count(distinct customer_id),category from project.[dbo].[SQL - RSA]
group by category

--creating shift based on sale time and finding number of order in each shift

select sale_time,
       CASE WHEN HOUR(sale_time) < 12 THEN 'Morning'
            WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
			END as 'Shift',
count(*) as 'Orders'
from Retail_sales
group by 1;