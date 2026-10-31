CREATE DATABASE SQL_Assignment_DB;
  GO  
USE SQL_Assignment_DB;
  GO


SELECT TOP 1* FROM items;
SELECT  TOP 1 * FROM company;
  GO


SELECT c.company_name, 
  AVG(i.price) AS average_price
FROM company c
 JOIN items i ON c.company_id = i.company_id
GROUP BY c.company_name;
  GO


SELECT c.company_name, 
 AVG(i.price) AS average_price
FROM company c
 JOIN items i ON c.company_id = i.company_id
GROUP BY c.company_name
 HAVING AVG(i.price) > (
SELECT AVG(price) 
 FROM items);
 GO


SELECT 
 item_id,
 item_name,
 price, 
 company_id
FROM items
 WHERE price> ( SELECT AVG (price)
FROM items);
 GO
 
SELECT TOP 1*  FROM employees;
SELECT TOP 1* FROM departments;


SELECT 
  e.emp_id, 
  e.emp_fname, 
  e.emp_lname, 
  e.emp_dept AS dept_code
FROM employees e
  JOIN departments d ON e.emp_dept = d.dept_code
WHERE d.dept_budget > ( SELECT AVG(dept_budget) 
  FROM departments);
 GO 


WITH DeptEmpCount AS ( SELECT 
  d.dept_code, 
  d.dept_name, 
COUNT(e.emp_id) AS total_emp
  FROM departments d
 LEFT JOIN employees e ON d.dept_code = e.emp_dept
  GROUP BY d.dept_code, d.dept_name)

SELECT dept_code,
       dept_name
FROM   DeptEmpCount
       WHERE total_emp > (
SELECT AVG(total_emp * 1.0) 
      FROM DeptEmpCount)
 GO


SELECT 
  i1.item_id, 
  i1.item_name, 
  i1.price, 
  i1.company_id
FROM items i1
WHERE i1.price < ( SELECT AVG(i2.price)
 FROM items i2
WHERE i2.company_id = i1.company_id);
 GO


SELECT 
 d.dept_code, 
 d.dept_name, 
COUNT(e.emp_id) AS employee_count
 FROM departments d
JOIN employees e ON d.dept_code = e.emp_dept
 GROUP BY d.dept_code, d.dept_name
HAVING COUNT(e.emp_id) = 1;
 GO


WITH CompanyAvg AS (SELECT 
 c.company_name, 
  AVG(i.price) AS average_price
 FROM company c
  JOIN items i ON c.company_id = i.company_id
 GROUP BY c.company_name)
  SELECT company_name, average_price
FROM CompanyAvg
  WHERE average_price = (
SELECT MIN(average_price) 
  FROM CompanyAvg);
 GO


SELECT 
  e.emp_id, 
  e.emp_fname, 
  e.emp_lname, 
  e.emp_dept AS dept_code
FROM employees e
 JOIN departments d ON e.emp_dept = d.dept_code
WHERE d.dept_budget < (
 SELECT AVG(dept_budget) 
FROM departments);