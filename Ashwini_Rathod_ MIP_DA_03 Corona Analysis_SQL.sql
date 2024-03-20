SELECT * FROM db.`corona virus dataset (1)`;
use db;

#Q1 Write a code to check NULL values
SELECT *
FROM db.`corona virus dataset (1)`
WHERE 'Province' IS NULL OR 'Country/Region' IS NULL OR 'Latitude' IS NULL 
    OR 'Longitude' IS NULL OR Date IS NULL OR 'Confirmed' IS NULL 
    OR 'Deaths' IS NULL OR 'Recovered' IS NULL;
    
    Select  * from db.`corona virus dataset (1)`
where Recovered is  Null;
SELECT DISTINCT `Province`, 
                `Confirmed`, 
                `Deaths`, 
                `Recovered` 
FROM `corona virus dataset (1)`;


    #___Q2. If NULL values are present, update them with zeros for all columns. 

set SQl_safe_updates = 0;
UPDATE `corona virus dataset (1)`
SET Confirmed = 0, Deaths = 0, Recovered = 0
WHERE Confirmed IS NULL
  AND Deaths IS NULL
  AND Recovered IS NULL;
#__ there is no Null values found in dataset 
  

#Q3 check total number of rows
SELECT COUNT(*) AS TotalRows
FROM db.`corona virus dataset (1)`; 

#Q4 Check what is start_date and end_date
SELECT MIN(Date) AS start_date, MAX(Date) AS end_date
FROM `corona virus dataset (1)`;  

#Q5 Number of month present in dataset
SELECT COUNT(DISTINCT DATE_FORMAT(Date, '%m')) AS num_months
FROM db.`corona virus dataset (1)`;  



#Q6. Find monthly average for confirmed, deaths, recovered
SELECT DATE_FORMAT(Date, '%m') AS month,
       AVG(Confirmed) AS avg_confirmed,
       AVG(Deaths) AS avg_deaths,
       AVG(Recovered) AS avg_recovered
FROM db.`corona virus dataset (1)`
GROUP BY month;


#Q7. Find most frequent value for confirmed, deaths, recovered each month
SELECT 
    month,
    (SELECT Confirmed FROM `corona virus dataset (1)` WHERE DATE_FORMAT(Date, '%m') = month ORDER BY Confirmed DESC LIMIT 1) AS most_frequent_confirmed,
    (SELECT Deaths FROM `corona virus dataset (1)` WHERE DATE_FORMAT(Date, '%m') = month ORDER BY Deaths DESC LIMIT 1) AS most_frequent_deaths,
    (SELECT Recovered FROM `corona virus dataset (1)` WHERE DATE_FORMAT(Date, '%m') = month ORDER BY Recovered DESC LIMIT 1) AS most_frequent_recovered
FROM (
    SELECT DATE_FORMAT(Date, '%m') AS month
    FROM `corona virus dataset (1)`
    GROUP BY month
) AS months;


#Q8. Find minimum values for confirmed, deaths, recovered per year
SELECT YEAR(Date) AS year,
       MIN(Confirmed) AS min_confirmed,
       MIN(Deaths) AS min_deaths,
       MIN(Recovered) AS min_recovered
FROM `corona virus dataset (1)`
GROUP BY year;


#Q9. Find maximum values of confirmed, deaths, recovered per year
SELECT YEAR(Date) AS year,
       MAX(Confirmed) AS max_confirmed,
       MAX(Deaths) AS max_deaths,
       MAX(Recovered) AS max_recovered
FROM `corona virus dataset (1)`
GROUP BY year;

# Extraone 
SELECT Province  AS country,
       MAX(Confirmed) AS max_confirmed
FROM `corona virus dataset (1)`
GROUP BY province
limit 5;

#Q10. The total number of case of confirmed, deaths, recovered each month
SELECT DATE_FORMAT(Date, '%m') AS month,
       SUM(Confirmed) AS total_confirmed,
       SUM(Deaths) AS total_deaths,
       SUM(Recovered) AS total_recovered
FROM `corona virus dataset (1)`
GROUP BY month;


#Q11. Check how corona virus spread out with respect to confirmed case
SELECT SUM(Confirmed) AS total_confirmed,
       AVG(Confirmed) AS avg_confirmed,
       VARIANCE(Confirmed) AS variance_confirmed,
       STDDEV_POP(Confirmed) AS std_dev_confirmed
FROM `corona virus dataset (1)` ;


#Q12. Check how corona virus spread out with respect to death case per month
SELECT SUM(Deaths) AS total_deaths,
       AVG(Deaths) AS avg_deaths,
       VARIANCE(Deaths) AS variance_deaths,
       STDDEV_POP(Deaths) AS std_dev_deaths
FROM `corona virus dataset (1)` 
GROUP BY MONTH(Date);


#Q13. Check how corona virus spread out with respect to recovered case
SELECT SUM(Recovered) AS total_recovered,
       AVG(Recovered) AS avg_recovered,
       VARIANCE(Recovered) AS variance_recovered,
       STDDEV_POP(Recovered) AS std_dev_recovered
FROM `corona virus dataset (1)` ;



#Q14. Find Country having highest number of the Confirmed case
SELECT `Country/Region`, max(confirmed) AS max_confirmed
FROM `corona virus dataset (1)` 
GROUP BY `Country/Region`
ORDER BY max_confirmed DESC
LIMIT 1;

SELECT `Country/Region`, max(confirmed) AS max_confirmed
FROM `corona virus dataset (1)` 
GROUP BY `Country/Region`
ORDER BY max_confirmed DESC;

#Q15. Find Country having lowest number of the death case
SELECT `Country/Region`, max(confirmed) AS max_confirmed
FROM `corona virus dataset (1)` 
GROUP BY `Country/Region`
ORDER BY max_confirmed DESC
LIMIT 1;

SELECT `Country/Region`, max(confirmed) AS max_confirmed
FROM `corona virus dataset (1)` 
GROUP BY `Country/Region`
ORDER BY max_confirmed DESC;


#Q16. Find top 5 countries having highest recovered case
SELECT `Country/Region`, sum(Recovered) AS total_recovered
FROM `corona virus dataset (1)` 
GROUP BY `Country/Region`
ORDER BY total_recovered DESC
LIMIT 5;