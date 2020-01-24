/*> (greater than), < (less than), >= (greater than or equal to), <= (less than or equal to), = (equal to), != (not equal to)*/
/*******************************************/
/****Solutions to Your First Subquery 1****/
/*****************************************/
/* 1-First, we needed to group by the day and channel. Then ordering by the number of events (the third column) gave us a quick way to answer the first question.*/
SELECT DATE_TRUNC('day',occurred_at) AS day,
   channel, COUNT(*) as events
FROM web_events
GROUP BY 1,2
ORDER BY 3 DESC;

/* 2-Here you can see that to get the entire table in question 1 back, we included an * in our SELECT statement. You will need to be sure to alias your table.*/
SELECT *
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
           channel, COUNT(*) as events
     FROM web_events
     GROUP BY 1,2
     ORDER BY 3 DESC) sub;
/* 3-Finally, here we are able to get a table that shows the average number of events a day for each channel.*/
SELECT channel, AVG(events) AS average_events
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
             channel, COUNT(*) as events
      FROM web_events
      GROUP BY 1,2) sub
GROUP BY channel
ORDER BY 2 DESC;
/*******************************************/
/****Solutions to Your First Subquery 2****/
/*****************************************/
/* 1-Here is the necessary quiz to pull the first month/year combo from the orders table.*/
SELECT DATE_TRUNC('month', MIN(occurred_at)) AS min_occur
FROM orders

/* 2-Then to pull the average for each, we could do this all in one query, but for readability, I provided two queries below to perform each separately.*/

SELECT AVG(standard_qty) avg_std, AVG(gloss_qty) avg_gls, AVG(poster_qty) avg_pst
FROM orders
WHERE DATE_TRUNC('month', occurred_at) =
     (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);

SELECT SUM(total_amt_usd)
FROM orders
WHERE DATE_TRUNC('month', occurred_at) =
      (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);
/************************/
/****Subquery QUIZZ ****/
/**********************/
/* 1-Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.*/
SELECT RegionNAME, SalesRepsNAME, MAX(total_sales)
FROM(
  SELECT r.name AS RegionNAME, s.name AS SalesRepsNAME, SUM(o.total_amt_usd) AS total_sales
  FROM region r
  JOIN sales_reps s ON s.region_id = r.id
  JOIN accounts a ON a.sales_rep_id = s.id
  JOIN orders o ON o.account_id = a.id
  GROUP BY r.name, s.name) SRAL
GROUP BY 1, 2
ORDER BY 3
/* 2-For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?*/


/* 3-How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?*/


/* 4-For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?*/


/* 5-What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?*/


/* 6-What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.*/
