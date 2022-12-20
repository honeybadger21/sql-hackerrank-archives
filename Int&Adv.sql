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
