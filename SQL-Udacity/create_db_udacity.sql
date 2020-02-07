/*
odrders table: id	account_id	occurred_at	standard_qty	gloss_qty	poster_qty	total	standard_amt_usd	gloss_amt_usd	poster_amt_usd	total_amt_usd
accounts table: id	name	website	lat	long	primary_poc	sales_rep_id
region table: id	name
sales_reps table: id	name	region_id
web_events: id	account_id	occurred_at	channel
*/

/* database creation*/
Create database 'Udacity_db';
USE 'Udacity_db';

CREATE TABLE 'accounts'(
  'id' INT(11) NOT NUll,
  'name' VARCHAR(250) NOT NULL,
  'website' VARCHAR(250) NOT NULL,
  'lat' DECIMAL(2,8) NOT NULL,
  'long' DECIMAL(2,8) NOT NULL,
  'primary_poc' VARCHAR(2,8) NOT NULL,
  'sales_rep_id' INT(8) NOT NULL,
  PRIMARY KEY('id'),
  KEY `sales_rep_id` (`sales_rep_id`),
  CONSTRAINT `sales_reps_ibfk_1` FOREIGN KEY (`sales_rep_id`) REFERENCES `sales_reps` (`id`)
  ON UPDATE CASCADE
  ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT, CHARSET = latin1;

CREATE TABLE 'orders' (
  'id' INT(11) NOT NULL AUTO_INCREMENT,
  'account_id' INT(11) NOT NULL,
  'occurred_at' DATETIME NOT NULL,
  'standard_qty' INT(11),
  'gloss_qty' INT(11)
)
