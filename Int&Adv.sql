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
