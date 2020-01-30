/*****************************/
/****LEFT & RIGHT Quizzes****/
/***************************/
/* 1-In the accounts table, there is a column holding the website for each company. The last three digits specify what type of web address they are using. A list of extensions (and pricing) is provided here. Pull these extensions and provide how many of each website type exist in the accounts table.*/
WITH tab1 AS (
  SELECT website,
         RIGHT(website, 3) AS domain
  FROM accounts
  GROUP BY 1, 2
)
SELECT domain, COUNT(domain) AS num_domain
FROM tab1
GROUP BY 1
ORDER BY 2 DESC /*Same solution*/
/*Udacity solution*/
SELECT RIGHT(website, 3) AS domain, COUNT(*) num_companies
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;
/* 2-There is much debate about how much the name (or even the first letter of a company name) matters. Use the accounts table to pull the first letter of each company name to see the distribution of company names that begin with each letter (or number).*/
WITH tab1 AS (
  SELECT name, LEFT(name, 1) AS FLetter
  FROM accounts
)
SELECT FLetter, COUNT(FLetter)
FROM tab1
GROUP BY 1
ORDER BY 2 DESC
/*Udacity solution*/
SELECT LEFT(UPPER(name), 1) AS first_letter, COUNT(*) num_companies
FROM accounts
GROUP BY 1
ORDER BY 2 DESC; /*correct result*/
/* 3-Use the accounts table and a CASE statement to create two groups: one group of company names that start with a number and a second group of those company names that start with a letter. What proportion of company names start with a letter?*/
WITH tab1 AS(
  SELECT name, LEFT(name, 1) AS FLetter
  FROM accounts
),
tab2 AS(
  SELECT Fletter, CASE WHEN FLetter LIKE '3%' THEN 'numbers'
                ELSE 'letter' END AS letter_number,
                COUNT(*) AS Count_fl_type
  FROM tab1
  GROUP BY 1, 2
  ORDER BY 3 DESC
)
SELECT letter_number, SUM(Count_fl_type)
FROM tab2
GROUP BY 1
/*Udacity solution*/
/*There are 350 company names that start with a letter and 1 that starts with a number. This gives a ratio of 350/351 that are company names that start with a letter or 99.7%.*/
SELECT SUM(num) nums, SUM(letter) letters
FROM (SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9')
                       THEN 1 ELSE 0 END AS num,
         CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9')
                       THEN 0 ELSE 1 END AS letter
      FROM accounts) t1; /* correct result*/

/* 4-Consider vowels as a, e, i, o, and u. What proportion of company names start with a vowel, and what percent start with anything else?*/
WITH tab1 AS(
  SELECT name, LEFT(name, 1) AS FLetter
  FROM accounts
),
tab2 AS(
  SELECT CASE WHEN FLetter IN ('a', 'A', 'e', 'E', 'i', 'I', 'o', 'O') THEN 'vowels'
              ELSE 'no_vowels' END AS select_vowels,
              COUNT(*) AS Count_vowels
  FROM tab1
  GROUP BY 1
)
SELECT select_vowels, COUNT(select_vowels)/SUM(Count_vowels)
FROM tab2
GROUP BY 1
HAVING select_vowels = 'vowels'
/*Udacity solution*/
/*There are 80 company names that start with a vowel and 271 that start with other characters. Therefore 80/351 are vowels or 22.8%. Therefore, 77.2% of company names do not start with vowels.*/
SELECT SUM(vowels) vowels, SUM(other) other
FROM (SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U')
                        THEN 1 ELSE 0 END AS vowels,
          CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U')
                       THEN 0 ELSE 1 END AS other
         FROM accounts) t1;

/********************************************************/
/****POSITION, STRPOS, & SUBSTR - AME DATA AS QUIZ 1****/
/******************************************************/
/*You will need to use what you have learned about LEFT & RIGHT, as well as what you know about POSITION or STRPOS to do the following quizzes.*/
/* 1-Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc.*/
  SELECT LEFT(primary_poc, POSITION(' ' IN primary_poc)) AS Fname, RIGHT(primary_poc, LENGTH(primary_poc)-POSITION(' ' IN primary_poc)) AS Lname
  FROM accounts /*do the same thing*/
/*Udacity solution*/
SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1 ) first_name,
RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name
FROM accounts;

/* 2-Now see if you can do the same thing for every rep name in the sales_reps table. Again provide first and last name columns.*/
SELECT name, POSITION(' ' IN name) AS space, LEFT(name, POSITION(' ' IN name)) AS Fname, RIGHT(name, LENGTH(name) - POSITION(' ' IN name)) AS Lname
FROM sales_reps
/*Udacity solution*/
SELECT LEFT(name, STRPOS(name, ' ') -1 ) first_name,
       RIGHT(name, LENGTH(name) - STRPOS(name, ' ')) last_name
FROM sales_reps;

/***********************/
/****Quizzes CONCAT****/
/*********************/
/* 1-Each company in the accounts table wants to create an email address for each primary_poc. The email address should be the first name of the primary_poc . last name primary_poc @ company name .com.*/
WITH tab1 AS(
  SELECT primary_poc,
         website,
         LEFT(primary_poc, (POSITION(' ' IN primary_poc)-1)) AS Fname,
         RIGHT(primary_poc, LENGTH(primary_poc)-POSITION(' ' IN primary_poc)) AS Lname,
         RIGHT(website, LENGTH(website)-4) AS part_email
  FROM accounts
)
/*SELECT Fname||'.'||Lname||'@'||part_email As Email*/
SELECT CONCAT(Fname,'.',Lname,'@',part_email) AS Email
FROM tab1 /*the same result*/
WHERE CONCAT(Fname,'.',Lname,'@',part_email) LIKE '%com'
/*Udacity solution*/
WITH t1 AS (
 SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1 ) first_name,
        RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
 FROM accounts)
SELECT first_name, last_name,
       CONCAT(first_name, '.', last_name, '@', name, '.com')
FROM t1;
/* 2-You may have noticed that in the previous solution some of the company names include spaces, which will certainly not work in an email address. See if you can create an email address that will work by removing all of the spaces in the account name, but otherwise your solution should be just as in question 1. Some helpful documentation is here.*/
WITH tab1 AS(
  SELECT primary_poc,
         website,
         LEFT(primary_poc, (POSITION(' ' IN primary_poc)-1)) AS Fname,
         RIGHT(primary_poc, LENGTH(primary_poc)-POSITION(' ' IN primary_poc)) AS Lname,
         RIGHT(website, LENGTH(website)-4) AS part_email
  FROM accounts
),
tab2 AS(
  /*SELECT Fname||'.'||Lname||'@'||part_email As Email*/
  SELECT CONCAT(Fname,'.',Lname,'@',part_email) AS Email
  FROM tab1
  /*WHERE CONCAT(Fname,'.',Lname,'@',part_email) LIKE '%com'*/
)
SELECT replace(Email, ' ', '') AS email-f
FROM tab2 /*the same result*/
/*Udacity solution*/
WITH t1 AS (
 SELECT LEFT(primary_poc,     STRPOS(primary_poc, ' ') -1 ) first_name,  RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
 FROM accounts)
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', REPLACE(name, ' ', ''), '.com')
FROM  t1;

/* 3-We would also like to create an initial password, which they will change after their first log in. The first password will be the first letter of the primary_poc's first name (lowercase), then the last letter of their first name (lowercase), the first letter of their last name (lowercase), the last letter of their last name (lowercase), the number of letters in their first name, the number of letters in their last name, and then the name of the company they are working with, all capitalized with no spaces*/
WITH tab1 AS(
  SELECT primary_poc,
         LEFT(primary_poc, (POSITION(' ' IN primary_poc)-1)) AS Fname,
         RIGHT(primary_poc, LENGTH(primary_poc)-POSITION(' ' IN primary_poc)) AS Lname,
         LEFT(lower(primary_poc), 1) AS Fname_lettre,
         LEFT(RIGHT(lower(primary_poc), LENGTH(primary_poc)-POSITION(' ' IN primary_poc)), 1) AS Lname_lettre,
         replace(name, ' ', '') AS cap_name
  FROM accounts
),
tab2 AS(
  SELECT primary_poc, Fname_lettre, Lname_lettre, LENGTH(Fname) AS Len_F, LENGTH(Lname) AS Len_L, UPPER(cap_name) AS CAP_L
  FROM tab1
)
SELECT primary_poc, CONCAT(Fname_lettre, Lname_lettre, Len_F, Len_L, CAP_L) AS Pwd
FROM tab2 /*Udacity solution*/
/*Udacity solution*/
WITH t1 AS (
 SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1 ) first_name,
        RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name,
        name
 FROM accounts)
SELECT first_name,
      last_name,
      CONCAT(first_name, '.', last_name, '@', name, '.com'), LEFT(LOWER(first_name), 1) || RIGHT(LOWER(first_name), 1) || LEFT(LOWER(last_name), 1) || RIGHT(LOWER(last_name), 1) || LENGTH(first_name) || LENGTH(last_name) || REPLACE(UPPER(name), ' ', '')
FROM t1;
