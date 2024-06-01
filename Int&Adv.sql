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

