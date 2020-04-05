/*To explore the city_list table */
SELECT * FROM city_list
Limit 10

/*To find out the Morocco country name in table*/
SELECT * FROM city_list
WHERE country IN ('Maroc', 'Morocco')

/*To explore the city_data table */
SELECT * FROM city_data
limit 10
/*To find out the Rabat city data in table*/
SELECT * FROM city_data
WHERE city = 'Rabat'

SELECT * FROM global_data
