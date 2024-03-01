CREATE DATABASE eda_supermarket;

Use eda_supermarket;

SELECT * FROM supermarket;

/* 1. Display the first five rows from the dataset*/
SELECT * FROM supermarket
LIMIT 5;

/* 2. Display the last five rows from the dataset*/
SELECT * FROM supermarket
ORDER BY 'Invoice ID'DESC
LIMIT 5;

/* 3. Display random five rows from the dataset*/
SELECT * FROM supermarket
ORDER BY rand()
LIMIT 5;

/* We would perform a Univariate analysis using one variable like one column at a time to perform an analysis */

/* 4. Display count, min, max, avg, and std values for the quantity column in the dataset*/
SELECT 
count(quantity),
  min(quantity),
  max(quantity),
  avg(quantity),
  std(quantity)
FROM supermarket;

/* 5. Find the number of missing values in branch column*/
SELECT count(*) FROM supermarket
WHERE branch is null;

/* 6. Count the number of occurrence on each city*/
SELECT city,count(city) FROM supermarket
GROUP BY  city;

/* 7. Find the most frequently used payment methods*/
SELECT payment,count(*) FROM supermarket
GROUP BY payment
ORDER BY count(*) DESC
LIMIT 1;

/* 8. Does the cost of goods(numerical) affect the ratings(numerical) that customers provide? we would perform bivariate and multivariate analysis. in this case we are using more than one variable at a time to solve our analysis */ 
SELECT rating,cogs FROM supermarket;

/* 9. Find the most possible branch as per cost of goods*/
SELECT Branch,round(sum(cogs),2) as sum_cogs 
FROM supermarket
GROUP BY Branch
ORDER BY sum_cogs DESC;

SELECT city,branch,round(sum(cogs),2) as sum_cogs
FROM supermarket
GROUP BY city,branch;

/* 10. Find the most used payment method city-wise*/
SELECT city,
sum(case when payment="cash" then 1 else 0 end) as "cash",
sum(case when payment="Ewallet" then 1 else 0 end) as "Ewallet",
sum(case when payment="Credit card" then 1 else 0 end) as "Credit card"
FROM supermarket
GROUP BY city;


/* 12. Display the daily sales by day of the week*/
SELECT * FROM supermarket;

SET SQL_SAFE_UPDATES=0;

update supermarket SET date = str_to_date(Date, '%m/%d/%Y');

SELECT dayname(date),dayofweek(date),sum(total) FROM supermarket
GROUP BY dayname(date),dayofweek(date);


/* 13. Find the month with the highest sales*/
SELECT monthname(date) as name, month(date) as month, sum(total) as total 
FROM supermarket
GROUP BY name,month order by total DESC;

/* 14. Find the time at which sales are highest*/
SELECT hour(time) as hour, sum(total) as total 
FROM supermarket
GROUP BY hour order by total DESC;

/* 15. Which gender spends interms of quantity more on average?*/
SELECT gender,avg(quantity) FROM supermarket
GROUP BY gender;

SET SQL_SAFE_UPDATES=1;
