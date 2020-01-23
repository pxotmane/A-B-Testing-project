/*****************************************/
/****Solutions to Your First Subquery****/
/***************************************/
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
