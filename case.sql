

-- two types: simple and searched CASE statements

-- CASE case_value (optional)
-- 	WHEN when_value_1 THEN do_this
-- 	WHEN when_value_2 THEN do_this
-- 	WHEN when_value_3 THEN do_this
--  ELSE value
-- END CASE
-- END AS case_name

USE employees;

SHOW TABLES FROM employees;

SELECT 
	emp_no,
    first_name,
    CASE -- gender
		WHEN gender = 'M' THEN 'Male'
        ELSE 'Femail'
    END AS gender
FROM employees
LIMIT 5;

SELECT 
	emp_no,
    first_name,
    CASE gender
		WHEN 'M' THEN 'Male'
        ELSE 'Femail'
    END AS gender
FROM employees
LIMIT 5;

SELECT 
	emp_no,
    first_name,
    IF (gender = 'M', 'Mail', 'Femail') AS gender
FROM employees
LIMIT 5;

SELECT 
    *
FROM
    employees.employeeerrors;


-- CASE with ORDER BY
SELECT 
    *
FROM
    employees.employeeerrors
ORDER BY (CASE first_name
    WHEN NULL THEN last_name
    ELSE emp_no
END);

SHOW TABLES FROM employees;

USE project;

SHOW TABLES FROM project;

SELECT *
FROM nashville_housing; -- 56,373

SELECT *
FROM nashville_housing
WHERE OwnerAddress IS NOT NULL; -- 25,969


-- Count the number of values that are not NULL in a column
SELECT 
	SUM(CASE
		WHEN PropertyAddress IS NOT NULL THEN 1
        ELSE 0
	END) AS num_of_PA,
    SUM(CASE
		WHEN OwnerAddress IS NOT NULL THEN 1
        ELSE 0
	END) AS num_of_OA,
    COUNT(*) AS total -- Show the total number of rows
FROM nashville_housing;

SELECT 
	SUM(CASE
		WHEN OwnerAddress IS NOT NULL THEN 1
        ELSE 0
	END) AS OA_num_not_null,
    SUM(CASE
		WHEN OwnerAddress IS NULL THEN 1
        ELSE 0
	END) AS OA_num_null,
    COUNT(*) AS total
FROM nashville_housing;




