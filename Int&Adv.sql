-- Solution Archive for HackerRank SQL problems 
-- Created by Ruchi Sharma, UT Austin (MS Business Analytics '23)
-- Language: MySQL 

-- SQL Intermediate & Advanced 

-- Problem 01: Binary Tree Nodes 
SELECT DISTINCT (B1.N), 
CASE WHEN B1.P IS NULL THEN 'Root'
     WHEN B2.P IS NULL THEN 'Leaf'
     WHEN B1.P IS NOT NULL THEN 'Inner'
END AS NAME
FROM BST B1 LEFT JOIN BST B2 ON B1.N = B2.P ORDER BY B1.N

-- Problem 02: New Companies 
SELECT C.company_code, C.founder, 
       COUNT(DISTINCT E.lead_manager_code), COUNT(DISTINCT E.senior_manager_code), 
       COUNT(DISTINCT E.manager_code), COUNT(DISTINCT E.employee_code)
FROM company as C INNER JOIN employee as E USING(company_code) GROUP BY c.company_code, c.founder

-- Problem 03: Draw the Triangle 1
DELIMITER $$

CREATE PROCEDURE DrawTriangle(IN p int)
BEGIN
  WHILE p > 0 DO
    SELECT REPEAT('* ', p);  
    SET p = p - 1;
  END WHILE;
END$$

DELIMITER ;

CALL DrawTriangle(20);

-- Problem 04: Draw the Triangle 2
DELIMITER $$

CREATE PROCEDURE DrawTriangle(IN p int)
BEGIN
  WHILE p < 21 DO
    SELECT REPEAT('* ', p);  
    SET p = p + 1;
  END WHILE;
END$$

DELIMITER ;

CALL DrawTriangle(1);

-- Problem 05: SYMMETRIC PAIRS
SELECT X, Y FROM (SELECT T1.X, T1.Y FROM FUNCTIONS T1 INNER JOIN FUNCTIONS T2 ON 
                    T1.X = T2.Y AND T1.Y = T2.X AND T1.X < T1.Y 
                        UNION SELECT X, Y FROM FUNCTIONS GROUP BY X, Y HAVING COUNT(*)>1)T1
ORDER BY X

-- Problem 06: OCCUPATIONS
SELECT MAX(IF(occupation = 'Doctor', name, null)) AS Doctor,
       MAX(IF(occupation = 'Professor', name, null)) AS Professor,
       MAX(IF(occupation = 'Singer', name, null)) AS Singer,
       MAX(IF(occupation = 'Actor', name, null)) AS Actor
FROM
(
SELECT name, occupation, row_number() OVER (PARTITION BY occupation ORDER BY name) name_order
FROM Occupations
) AS row_nm
GROUP BY name_order;

-- Problem 06: TOP COMPETITORS
SELECT hacker_id, name FROM

(SELECT h.hacker_id, h.name, count(s.submission_id) as count_max
FROM Submissions s JOIN Challenges c ON s.challenge_id = c.challenge_id
               JOIN Difficulty d ON c.difficulty_level = d.difficulty_level
               JOIN Hackers h ON s.hacker_id = h.hacker_id
WHERE s.score = d.score
GROUP BY 1, 2
ORDER BY 3 DESC, 1) as cte

WHERE count_max > 1

-- Problem 07: Ollivander's Inventory
SELECT A.id, B.age, A.coins_needed, A.power FROM Wands A JOIN Wands_Property B ON A.code = B.code 
WHERE B.is_evil = 0 AND
A.coins_needed = (SELECT MIN(coins_needed) FROM Wands A1 JOIN Wands_Property B1 ON A1.code = B1.code 
                                WHERE A1.power = A.power AND B1.age = B.age)
ORDER BY A.power DESC, B.age DESC

-- Problem 08: Challenges
WITH CTE AS
(SELECT A.hacker_id, A.name, COUNT(B.challenge_id) AS total FROM Hackers A JOIN Challenges B On A.hacker_id = B.hacker_id GROUP BY 1, 2)

SELECT * FROM CTE WHERE total = (SELECT MAX(total) FROM CTE)
                                        OR total IN (SELECT total FROM CTE GROUP BY total HAVING count(*) = 1)
ORDER BY total DESC, hacker_id

-- Problem 09: Contest Leaderboard
select h.hacker_id, h.name, sum(max_score) as total_score
from (select s.hacker_id, s.challenge_id, max(s.score) as max_score
     from Submissions s
     group by 1,2) a 
join Hackers h on h.hacker_id=a.hacker_id
group by 1, 2
having total_score>0
order by total_score desc, h.hacker_id asc

-- Problem 10: Placements 
select name from (
select a.id, a.name, b.friend_id, c.salary from 
students a inner join friends b on a.id = b.id inner join packages c on b.id = c.id
) d inner join packages e on d.friend_id = e.id
where d.salary < e.salary order by e.salary

-- Problem 11: Interviews (This is a GOOD question, looks straightforward but isn't)
SELECT c.contest_id, c.hacker_id, c.name, SUM(COALESCE(s.total_submissions, 0)) AS total_submissions, SUM(COALESCE(s.total_accepted_submissions, 0)) AS total_accepted_submissions, SUM(COALESCE(v.total_views, 0)) AS total_views, SUM(COALESCE(v.total_unique_views, 0)) AS total_unique_views 

FROM contests c JOIN colleges col ON c.contest_id = col.contest_id JOIN challenges chal ON col.college_id = chal.college_id 

LEFT JOIN ( SELECT challenge_id, SUM(total_submissions) AS total_submissions, SUM(total_accepted_submissions) AS total_accepted_submissions FROM Submission_Stats GROUP BY challenge_id ) s ON chal.challenge_id = s.challenge_id 
LEFT JOIN ( SELECT challenge_id, SUM(total_views) AS total_views, SUM(total_unique_views) AS total_unique_views FROM view_stats GROUP BY challenge_id ) v ON chal.challenge_id = v.challenge_id 

GROUP BY c.contest_id, c.hacker_id, c.name 

HAVING (SUM(COALESCE(s.total_submissions, 0)) + SUM(COALESCE(s.total_accepted_submissions, 0)) + SUM(COALESCE(v.total_views, 0)) + SUM(COALESCE(v.total_unique_views, 0))) > 0 ORDER BY c.contest_id;

-- Problem 12: Print Prime Numbers (IMP question, keep this in mind)
WITH recursive cte_numgen AS (
    SELECT 2 AS n
    UNION ALL
    SELECT n+1 FROM cte_numgen WHERE n < 1000
)
SELECT 
    GROUP_CONCAT(a.n SEPARATOR '&') AS prime_string
FROM cte_numgen a
WHERE NOT  EXISTS (
    SELECT 1
    FROM cte_numgen b
    WHERE a.n > b.n AND a.n % b.n = 0

-- Problem 13: SQL Project Planning (https://www.w3schools.com/sql/func_mysql_date_sub.asp)
SELECT MIN(Start_Date), MAX(End_Date) 
FROM (
SELECT Start_Date, End_Date, DATE_SUB(Start_Date, INTERVAL ROW_NUMBER() OVER(ORDER BY Start_Date) DAY) AS ProjectDays 
FROM Projects
)AS A 
GROUP BY ProjectDays 
ORDER BY DATEDIFF(MAX(End_Date), MIN(Start_Date)), MIN(Start_Date);


-- Problem 14: The Report
select case
    when marks<70 then 'NULL'
    else name
    end,
grade, marks from students, grades where marks between min_mark and
    max_mark order by grade desc, name, marks;


-- Problem 15: 15 Days of Learning SQL
