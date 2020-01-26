/*Your First WITH (CTE)
The same question as you saw in your first subquery is provided here along with the solution.
QUESTION: You need to find the average number of events for each channel per day.
SOLUTION:*/

SELECT channel, AVG(events) AS average_events
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
             channel, COUNT(*) as events
      FROM web_events
      GROUP BY 1,2) sub
GROUP BY channel
ORDER BY 2 DESC;
/*Let's try this again using a WITH statement.
Notice, you can pull the inner query:*/

SELECT DATE_TRUNC('day',occurred_at) AS day,
       channel, COUNT(*) as events
FROM web_events
GROUP BY 1,2
/*This is the part we put in the WITH statement. Notice, we are aliasing the table as events below:*/
WITH events AS (
          SELECT DATE_TRUNC('day',occurred_at) AS day,
                        channel, COUNT(*) as events
          FROM web_events
          GROUP BY 1,2)
/*Now, we can use this newly created events table as if it is any other table in our database:*/
WITH events AS (
          SELECT DATE_TRUNC('day',occurred_at) AS day,
                        channel, COUNT(*) as events
          FROM web_events
          GROUP BY 1,2)

SELECT channel, AVG(events) AS average_events
FROM events
GROUP BY channel
ORDER BY 2 DESC;
/*For the above example, we don't need anymore than the one additional table, but imagine we needed to create a second table to pull from. We can create an additional table to pull from in the following way:*/
WITH table1 AS (
          SELECT *
          FROM web_events),
     table2 AS (
          SELECT *
          FROM accounts)
SELECT *
FROM table1
JOIN table2
ON table1.account_id = table2.id;
/*You can add more and more tables using the WITH statement in the same way.*/

/*********************/
/****WITH Quizzes****/
/*******************/
/*Essentially a WITH statement performs the same task as a Subquery. Therefore, you can write any of the queries we worked with in the "Subquery Mania" using a WITH. That's what you'll do here. Try to perform each of the earlier queries again, but using a WITH instead of a subquery.*/

/* 1-Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.*/


/* 2-For the region with the largest sales total_amt_usd, how many total orders were placed?*/


/* 3-How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?*/


/* 4-For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?*/


/* 5-What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?*/


/* 6-What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.*/
