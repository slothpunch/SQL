USE employees;

/*
	String Functions - TRIM, LTRIM, RTRIM, REPLACE, SUBSTRING, UPPER, LOWER
*/

-- Drop Table EmployeeErrors;


CREATE TABLE EmployeeErrors (
emp_no varchar(50)
,first_name varchar(50)
,last_name varchar(50)
);

Insert into EmployeeErrors Values 
('10001  ', 'Georgi', 'Facello')
,('  10002', 'Bezalel', 'Simmel')
,('10005', 'KYoichI', 'Maliniak - Fired');

SELECT * FROM employees LIMIT 10;

SELECT * FROM EmployeeErrors;

-- Using TRIM, LTRIM, RTRIM
-- Remove leading and trailing spaces from a string

-- Both sides
SELECT emp_no, TRIM(emp_no) as No_TRIM
FROM employeeerrors;

-- Left side only
SELECT emp_no, LTRIM(emp_no) as ID_TRIM
FROM employeeerrors;

-- Right side only
SELECT emp_no, RTRIM(emp_no) as ID_TRIM
FROM employeeerrors;

-- Using REPLACE
-- REPLACE(column, 'a', 'b') replace a with b
SELECT last_name, REPLACE(last_name, '- Fired', '') as last_name_fixed
FROM employeeerrors;

-- Using Substring
-- Extract a substring from a string. (substring, start, end)
SELECT SUBSTRING(first_name, 3, 3)
FROM employeeerrors;

-- SUBSTRING in JOIN
SELECT SUBSTRING(err.first_name, 1, 3) AS first_3, 
		TRIM(err.emp_no) AS emp_no, 
        SUBSTRING(em.first_name, 1, 3) AS first_3,
        em.first_name,
        em.emp_no
FROM employeeerrors err
JOIN employees em
	ON SUBSTRING(err.first_name, 1, 3) = SUBSTRING(em.first_name, 1, 3)
ORDER BY 1,3;


-- Using UPPER and LOWER
SELECT * FROM employeeerrors;

SELECT first_name, 
		CONCAT(UPPER(LEFT(first_name, 1)), LOWER(RIGHT(first_name, LENGTH(first_name)-1))) AS first_name,
        CONCAT(UPPER(LEFT(first_name, 1)), LOWER(SUBSTRING(first_name, 2))) AS first_name
FROM employeeerrors;

