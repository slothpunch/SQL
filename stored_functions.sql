/*
	Stored or User-defined functions
    
    https://www.mysqltutorial.org/mysql-stored-procedure-tutorial.aspx
    Section 6. Stored Functions
*/


-- DELIMITER $$

-- CREATE FUNCTION function_name(parameter data_type) RETURNS data_type
-- DETERMINISTIC -- if you don't sepcify it, MySQL uses NOT DETERMINISTIC. But the query doesn't work when I didn't type DETERMINISTIC.
-- BEGIN

-- DECLEAR variable_name data_type -- Create a variable, data_type must be the same as REUTRNS data_type

-- 	SELECT 
-- RETURN variable_name
-- END$$

-- DELIMITER ;

DROP FUNCTION IF EXISTS employees.f_emp_avg_sal;

DELIMITER $$

CREATE FUNCTION f_emp_avg_sal (p_emp_no INT) RETURNS DECIMAL(10,2)

DETERMINISTIC

BEGIN
	
DECLARE v_avg_sal DECIMAL(10, 2);

SELECT AVG(salary)
INTO v_avg_sal
FROM salaries
WHERE emp_no = p_emp_no;

RETURN v_avg_sal;
END$$

DELIMITER ;

SELECT employees.f_emp_avg_sal(11300);

-- a variable and stored function in the statement 

SET @v_emp_no = 10001;

SELECT 
	e.emp_no, 
    first_name, 
    last_name, 
    f_emp_avg_sal(@v_emp_no)
FROM employees e
JOIN salaries s
	ON e.emp_no = s.emp_no
WHERE e.emp_no = @v_emp_no
GROUP BY 1;


