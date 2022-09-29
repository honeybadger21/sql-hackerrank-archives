-- Solution Archive for HackerRank SQL problems 
-- Created by Ruchi Sharma, UT Austin (MS Business Analytics '23)
-- Language: MySQL 

-- Weather Observation Station - Complete Series 

-- Weather Observation Station 1
select city, state from station

-- Weather Observation Station 2
select round(sum(lat_n), 2), round(sum(long_w), 2) from station

-- Weather Observation Station 3
select distinct city from station
where MOD(ID, 2) = 0

-- Weather Observation Station 4
select (count(city)-count(distinct city)) from station

-- Weather Observation Station 5
select city, length(city) from station order by length(city), city limit 1;
select city, length(city) from station order by length(city) desc, city limit 1;

-- Weather Observation Station 6
select distinct city from station
where REGEXP_LIKE(city,'^[aeiou]')

-- Weather Observation Station 7
select distinct city from station 
where REGEXP_LIKE(city,'[aeiou]$')

-- Weather Observation Station 8
select distinct city from station where 
REGEXP_LIKE(city,'^[aeiou]') and REGEXP_LIKE(city,'[aeiou]$')

-- Weather Observation Station 9
select distinct city from station
where CITY RLIKE '^[^aeiouAEIOU].*';

-- Weather Observation Station 10
select distinct city from station 
where REGEXP_LIKE(city,'[^aeiou]$')

-- Weather Observation Station 11
select distinct city from station 
where REGEXP_LIKE(city,'[^aeiou]$') or REGEXP_LIKE(city,'^[^aeiou]')

-- Weather Observation Station 12
select distinct city from station 
where REGEXP_LIKE(city,'[^aeiou]$') and REGEXP_LIKE(city,'^[^aeiou]')


-- Weather Observation Station 13
select round(sum(lat_n), 4) from station
where lat_n < 137.2345 and lat_n > 38.7880

-- Weather Observation Station 14
select round(max(lat_n), 4) from station
where lat_n < 137.2345

-- Weather Observation Station 15
select round(long_w, 4) from station
where lat_n = (select max(lat_n) from station where lat_n < 137.2345);

-- Weather Observation Station 16
select round(min(lat_n), 4) from station where lat_n > 38.7780

-- Weather Observation Station 17
select round(long_w, 4) from station
where lat_n = (select min(lat_n) from station where lat_n > 38.7780);

-- Weather Observation Station 18
select round(abs(max(lat_n)-min(lat_n)) + abs(max(long_w)-min(long_w)), 4) from station

-- Weather Observation Station 19
SELECT CAST(SQRT(POWER((MAX(lat_n)-min(lat_n)), 2)+POWER((MAX(long_w)-min(long_w)), 2)) AS DECIMAL(10, 4))
FROM STATION

-- Weather Observation Station 20
SELECT ROUND(LAT_N,4) FROM STATION ORDER BY LAT_N LIMIT 1 OFFSET 249










