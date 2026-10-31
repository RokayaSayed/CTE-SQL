CREATE  DATABASE SQL_Assignment_DB_Part2;
 GO
USE SQL_Assignment_DB_Part2;

SELECT TOP 1 * FROM [company (1)];
SELECT TOP 1 * FROM [items (1)];
SELECT TOP 1 * FROM [employees (1)];
SELECT TOP 1 * FROM [departments (1)];


WITH AvgPriceCTE AS (
  SELECT AVG(price) AS avg_price
FROM [items (1)])
  SELECT items.*
FROM [items (1)] AS items, AvgPriceCTE
  WHERE items.price > AvgPriceCTE.avg_price;
 GO
WITH CompanyItemCount AS (
  SELECT c.company_name, COUNT(i.item_id) AS item_count
   FROM [company (1)] AS c
  JOIN [items (1)] AS i ON c.company_id = i.company_id
   GROUP BY c.company_name)
SELECT company_name, item_count
 FROM CompanyItemCount;

 GO

 WITH CompanyAvgPrice AS (
  SELECT c.company_name, AVG(i.price) AS avg_price
  FROM [company (1)] AS c
 JOIN [items (1)] AS i ON c.company_id = i.company_id
  GROUP BY c.company_name)
SELECT company_name, avg_price
 FROM CompanyAvgPrice
WHERE avg_price > 2000;
  GO

WITH EmpDeptCTE AS (
 SELECT e.emp_fname + ' ' + e.emp_lname AS full_name,
   d.dept_name
  FROM [employees (1)] AS e
   JOIN [departments (1)] AS d ON e.emp_dept = d.dept_code)
SELECT full_name, dept_name
  FROM EmpDeptCTE;
  GO

WITH DeptAvgBudget AS (
 SELECT dept_code, dept_name, dept_budget
  FROM [departments (1)])
 SELECT dept_code, dept_name, dept_budget
  FROM DeptAvgBudget
 WHERE dept_budget > 
  (SELECT AVG(dept_budget) 
 FROM [departments (1)]);
  GO
 
WITH DeptEmpCount AS (
 SELECT d.dept_code, d.dept_name, COUNT(e.emp_id) AS emp_count
   FROM [departments (1)] AS d
 LEFT JOIN [employees (1)] AS e ON d.dept_code = e.emp_dept
   GROUP BY d.dept_code, d.dept_name)
 SELECT dept_code, dept_name, emp_count
  FROM DeptEmpCount
 WHERE emp_count > 1;
  GO

WITH CompanyAverage AS (
 SELECT c.company_name, AVG(i.price) AS comp_avg
  FROM [company (1)] AS c
 JOIN [items (1)] AS i ON c.company_id = i.company_id
  GROUP BY c.company_name),
OverallAverage AS (
 
 SELECT AVG(price) AS overall_avg
  FROM [items (1)])
SELECT c.company_name, c.comp_avg
 FROM CompanyAverage AS c, OverallAverage AS o
 WHERE c.comp_avg < o.overall_avg;