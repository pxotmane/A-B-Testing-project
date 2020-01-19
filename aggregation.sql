/*> (greater than), < (less than), >= (greater than or equal to), <= (less than or equal to), = (equal to), != (not equal to)*/

SELECT MIN(occurred_at)
FROM orders;
/*same result*/
SELECT occurred_at
FROM orders
ORDER BY occurred_at
LIMIT 1;

SELECT MAX(occurred_at)
FROM web_events;
/*same result*/
SELECT occurred_at
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1;


SELECT AVG(standard_amt_usd) AS std_avg, AVG(gloss_amt_usd) AS glo_avg, AVG(poster_amt_usd) AS post_avg, AVG(standard_amt_usd*standard_qty) AS std_avg_cmd, AVG(gloss_amt_usd*gloss_qty) AS gloss_avg_cmd, AVG(poster_amt_usd*poster_qty) AS poster_avg_cmd
FROM orders;
/*median*/
SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;
/*Since there are 6912 orders - we want the average of the 3457 and 3456 order amounts when ordered. This is the average of 2483.16 and 2482.55. This gives the median of 2482.855. This obviously isn't an ideal way to compute. If we obtain new orders, we would have to change the limit. SQL didn't even calculate the median for us. The above used a SUBQUERY, but you could use any method to find the two necessary values, and then you just need the average of them.*/

/*Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.*/
SELECT a.name, o.occurred_at
FROM orders o
JOIN accounts a
ON o.account_id = a.id
ORDER BY o.occurred_at
/*Udacity solution*/
SELECT a.name, o.occurred_at
FROM accounts a
JOIN orders o
ON a.id = o.account_id
ORDER BY occurred_at
LIMIT 1;

/*Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.*/
SELECT a.name AS CompanyNAME, SUM(o.total_amt_usd)
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY CompanyNAME
ORDER BY CompanyNAME
/*Udacity solution*/
SELECT a.name, SUM(total_amt_usd) total_sales
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name;

/*Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.*/
SELECT a.name AS NameACCOUNT, w.channel AS WebCHANNEL, w.occurred_at AS OccuDATE
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
ORDER BY OccuDATE
/*Udacity solution*/
SELECT w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY w.occurred_at DESC
LIMIT 1;

/*Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.*/
SELECT channel, COUNT(channel) AS TotalUSED
FROM web_events
GROUP BY channel
ORDER BY channel
/*Udacity solution*/
SELECT w.channel, COUNT(*)
FROM web_events w
GROUP BY w.channel

/*Who was the primary contact associated with the earliest web_event?*/
SELECT a.name AS AccName, w.channel AS CHANNEL, w.occurred_at AS OccuDATE
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
ORDER BY OccuDATE
/*Udacity solution*/
SELECT a.primary_poc
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1;

/*What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.*/
SELECT a.name AS AccNAME,  SUM(o.total_amt_usd) AS TotalAMT
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY AccNAME
ORDER BY TotalAMT
/*Udacity solution*/
SELECT a.name, MIN(total_amt_usd) smallest_order
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY smallest_order;

/*Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps.*/
SELECT r.name AS RegionNAME, COUNT(s.name) AS SalesRepsNAME
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
GROUP BY RegionNAME
ORDER BY SalesRepsNAME
/*Udacity solution*/
SELECT r.name, COUNT(*) num_reps
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
GROUP BY r.name
ORDER BY num_reps;
