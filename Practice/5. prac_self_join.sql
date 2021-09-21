
-- https://www.mysqltutorial.org/mysql-self-join/
USE employees;

SELECT *
FROM employees
LIMIT 5; 

SELECT
	e.emp_no AS 'Employees Number',
    CONCAT(UCASE(LEFT(m.first_name, 1)), LOWER(SUBSTR(m.first_name, 2)),  
			', ', 
			UPPER(LEFT(m.last_name, 1)), LOWER(SUBSTR(m.last_name, 2))) AS 'Full Name',
    m.first_name,
    m.last_name
FROM 
	employees e
INNER JOIN employees m ON
	e.emp_no = m.emp_no
ORDER BY 'Employees Number'
LIMIT 15;

-- With Left join 
SELECT
	e.emp_no AS 'Employees Number',
    m.first_name,
    m.last_name
FROM 
	employees e
LEFT JOIN employees m ON
	e.emp_no = m.emp_no
ORDER BY 'Employees Number'
LIMIT 15;


# 
WITH Emp_name(first_name, last_name_1, last_name_2) AS
(
	SELECT
		e.first_name,
		e.last_name,
		m.last_name
	FROM 
		employees e
	LEFT JOIN employees m ON
		e.first_name = m.first_name
		AND e.last_name > m.last_name
	WHERE e.first_name = 'Georgi'
)
SELECT
	first_name AS 'fisrt name',
    last_name_2,
    '<> operator' AS operator
FROM 
	Emp_name
UNION
SELECT
	e.first_name,
	m.last_name,
    '> operator' AS operator
FROM 
	employees e
LEFT JOIN employees m ON
	e.first_name = m.first_name
	AND e.last_name <> m.last_name # different result 
-- ORDER BY 'Employees Number'
-- WHERE e.first_name = 'Georgi'
LIMIT 80;


SELECT
	e.first_name,
	e.last_name,
	m.last_name
FROM 
	employees e
LEFT JOIN employees m ON
	e.first_name = m.first_name
	AND e.last_name > m.last_name
WHERE e.first_name = 'Georgi'
	AND m.last_name = 'Facello';





