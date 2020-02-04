/*
odrders table: id	account_id	occurred_at	standard_qty	gloss_qty	poster_qty	total	standard_amt_usd	gloss_amt_usd	poster_amt_usd	total_amt_usd
accounts table: id	name	website	lat	long	primary_poc	sales_rep_id
region table: id	name
sales_reps table: id	name	region_id
web_events: id	account_id	occurred_at	channel
*/

/* database creation*/
Create database 'Udacity_db'
USE 'Udacity_db'
