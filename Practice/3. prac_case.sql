
USE employees;

SELECT NOW();
SELECT CONCAT(CURRENT_DATE(), CURRENT_TIME());
SELECT CURRENT_TIME();

SELECT *
FROM 
	employees e
JOIN
	dept_emp de 
    ON e.emp_no = de.emp_no
LIMIT 5;

SELECT
	e.emp_no,
    e.hire_date, 
    de.from_date,
	DATEDIFF(de.from_date, e.hire_date) AS working_years
FROM
	employees e
JOIN
	dept_emp de
	ON e.emp_no = de.emp_no
ORDER BY working_days DESC
LIMIT 5;

-- CTE
WITH WorkingYears (emp_no, hire_date, from_date, working_years)
AS (
	SELECT
		e.emp_no,
		e.hire_date, 
		de.from_date,
		DATEDIFF(de.from_date, e.hire_date)
	FROM
		employees e
	JOIN
		dept_emp de ON e.emp_no = de.emp_no
	ORDER BY 4 DESC
)
SELECT *, 
	CASE
		WHEN working_years < 1095 THEN "Less than 3 years"
		WHEN working_years >= 1095 AND working_years < 1825 THEN "3 - 5 years"
        WHEN working_years >= 1825 AND working_years < 2555 THEN "5 - 7 years"
        WHEN working_years >= 2555 AND working_years < 3650 THEN "7 - 10 years"
        WHEN working_years >= 3650 AND working_years < 5475 THEN "10 - 15 years"
        ELSE "More than 15 years"
	END AS working_years
FROM WorkingYears;


DROP PROCEDURE IF EXISTS employees.WorkingYears;

DELIMITER $$
USE employees;

CREATE PROCEDURE employees.WorkingYears(
	IN p_emp_no INT,
    OUT p_emp_years VARCHAR(20)
)
BEGIN
	DECLARE years VARCHAR(20) DEFAULT 0;
    
SELECT
	DATEDIFF(de.from_date, e.hire_date)
INTO years
FROM
	employees e
JOIN
	dept_emp de ON e.emp_no = de.emp_no
WHERE 
	e.emp_no = p_emp_no
ORDER BY 1 DESC;
    
	CASE
		WHEN years < 1095 THEN 
			SET p_emp_years = "Less than 3 years";
		WHEN years >= 1095 AND years < 1825 THEN 
			SET p_emp_years = "3 - 5 years";
        WHEN years >= 1825 AND years < 2555 THEN 
			SET p_emp_years = "5 - 7 years";
        WHEN years >= 2555 AND years < 3650 THEN 
			SET p_emp_years = "7 - 10 years";
        WHEN years >= 3650 AND years < 5475 THEN 
			SET p_emp_years = "10 - 15 years";
        ELSE 
			SET p_emp_years = "More than 15 years";
	END CASE;

END $$

DELIMITER ;



