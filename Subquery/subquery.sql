USE employees;

SELECT *
FROM salaries;

-- Subquery in Select
SELECT 
    emp_no,
    salary,
    (SELECT 
            AVG(salary)
        FROM
            salaries) AS AVG_salary
FROM
    salaries;

-- How to do it with Partition By

SELECT 
    emp_no,
    salary,
    AVG(salary) OVER () AS AVG_salary
FROM
    salaries;


-- Why Group By doesn't work

SELECT 
    emp_no,
    salary,
    AVG(salary) AS AVG_salary
FROM
    salaries
GROUP BY emp_no, salary
ORDER BY 1, 2;


-- Subquery in From		--> the entire table (all columns) can be selected
-- Using subquery in this way is slower than using CTE or TEMP, and not reusable?
SELECT a.emp_no, AVG_salary
FROM (SELECT 
    emp_no,
    salary,
    AVG(salary) OVER () AS AVG_salary
FROM
    salaries) a;


-- Subquery in Where	--> ONLY one column can be selected
SELECT 
    emp_no, salary
FROM
    salaries
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            titles
        WHERE
            title = 'Engineer');


