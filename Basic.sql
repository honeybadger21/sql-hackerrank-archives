-- Solution Archive for HackerRank SQL problems 
-- Created by Ruchi Sharma, UT Austin (MS Business Analytics '23)
-- Language: MySQL 

-- SQL Basic 

-- Problem 01: Revising the Select Query I
SELECT * FROM CITY
WHERE CountryCode = "USA" and POPULATION > 100000

-- Problem 02: Select All
Select All

-- Problem 03: Select By ID
select * from city
where ID = 1661

-- Problem 04: Japanese Cities' Attributes
select * from CITY
where COUNTRYCODE = "JPN"

-- Problem 05: Revising the Select Query II
select NAME from CITY
where CountryCode = "USA" and POPULATION > 120000

-- Problem 06: Japanese Cities' Names
select NAME from city
where countrycode = "JPN"

-- Problem 7: Higher Than 75 Marks
select Name from STUDENTS
where Marks > 75
order by RIGHT(Name, 3), ID ASC 

-- Problem 8: Employee Names
select name from employee
order by name asc; 

-- Problem 9: Employee Salaries
select name from employee
where salary > 2000 and months < 10
order by employee_id asc

-- Problem 10: Type of Triangle
select
case 
    when A + B <= C or A + C <= B or B + C <= A then 'Not A Triangle'
    when A = B and B = C and C = A THEN 'Equilateral'
    when A = B or B = C or C = A THEN 'Isosceles'
    else 'Scalene'
end as output
from triangles 

-- Problem 11: Revising Aggregations - The Count Function
select count(name) from city where population > 100000

-- Problem 12: Revising Aggregations - The Sum Function
select sum(population) from city where district = "California"

-- Problem 13: Revising Aggregations - Averages
select avg(population) from city where district = "California"

-- Problem 14: Average Population
select round(avg(population)) from city  

-- Problem 15: Japan Population
select sum(population) from city where countrycode = "JPN"

-- Problem 16: Population Density Difference
select max(population)-min(population) from city

-- Problem 17: The Blunder
select ceil(avg(salary) - avg(replace(salary, '0', ''))) 
from employees 

-- Problem 18: Top Earners
select (months*salary) as earnings, count(*) from employee
group by earnings
order by earnings desc
limit 1

-- Problem 19: Population Census 
select sum(city.population) from city 
inner join country on CITY.CountryCode = COUNTRY.Code
where country.continent = 'Asia'

-- Problem 20: African Cities
select distinct city.name from city
inner join country on city.countrycode = country.code
where country.continent = "Africa"

-- Problem 21: Average Population of Each Continent
select distinct country.continent, floor(avg(city.population)) from country
inner join city on city.countrycode = country.code
group by country.continent

-- Problem 22: The PADS
    -- Method 1
SELECT CONCAT(name, '(', UPPER(substring(occupation, 1, 1)), ')') FROM occupations
ORDER BY name;

SELECT CONCAT("There are a total of", ' ', COUNT(occupation), ' ', LOWER(occupation), 's', ".") 
FROM occupations
GROUP BY occupation
ORDER BY COUNT(occupation) ASC;

    -- Method 2
select concat(name, '(', LEFT(occupation, 1), ')') from occupations order by name;
select concat('There are a total of ', COUNT(occupation), ' ', lower(occupation), 's.') from occupations group by occupation order by count(occupation), occupation;
