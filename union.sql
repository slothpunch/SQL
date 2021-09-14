
-- https://www.mysqltutorial.org/sql-union-mysql.aspx

-- combine two or more result sets of queries into a single result set

-- SELECT columns
-- FROM table
-- UNION [DISTINCT | ALL]
-- SELECT columns
-- FROM table
-- UNION [DISTINCT | ALL]
-- SELECT columns
-- FROM table
-- UNION [DISTINCT | ALL]
-- ...

-- UNION and UNION ALL 
-- UNION displays distinct/unique values
-- UNION ALL displays all duplicate values

-- UNION ALL is faster than UNION

-- JOIN vs UNION
-- JOIN works horizontally, UNION works vertically
USE employees;

SELECT * FROM employees LIMIT 5; # 6 columns
SELECT * FROM employeeerrors LIMIT 5;  # 3 columns

-- Gives an error because BOTH SELECT statements must have the same number of columns
SELECT emp_no, first_name, last_name FROM employees
UNION 
SELECT emp_no, salary FROM employeeerrors LIMIT 5;


SELECT 
	emp_no AS No, 
    'Employee' AS Type 
FROM 
	employees
UNION 
SELECT 
	emp_no, 
    'Error' AS Type 
FROM 
	employeeerrors
ORDER BY 1
LIMIT 15;


