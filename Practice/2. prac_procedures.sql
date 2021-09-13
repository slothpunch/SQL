

USE employees;

-- ------------------------ 1 ----------------------------
-- Create a procedure called Test that calls up all salaries.
-- Drop if it already exists.
-- Call the procedure to check.
-- -------------------------------------------------------

DELIMITER $$
USE employees $$
CREATE PROCEDURE Test()
BEGIN
	SELECT *
    FROM salaries;
END $$

DELIMITER ;

CALL employees.Test();

-- ------------------------ 2 ----------------------------
-- Create a procedure called emp_salaries. 
-- Drop if it already exists. 
-- Use IN parameter to take an employee's number 
-- and show their employee number, salary, and etc.
-- -------------------------------------------------------

DROP PROCEDURE IF EXISTS employees.emp_salaries;

DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_salaries(IN p_emp_no INTEGER)
BEGIN
	SELECT 
		e.emp_no,
        salary,
        first_name,
        last_name,
        gender,
        hire_date
    FROM 
		employees e
    JOIN
		salaries s ON
        e.emp_no = s.emp_no
	WHERE e.emp_no = p_emp_no;
END $$

DELIMITER ;

CALL employees.emp_salaries(10005);

SELECT *
FROM employees
-- FROM salaries
LIMIT 5;


-- ------------------------ 3 ----------------------------
-- Create a procedure called out_avg_emp_salaries. 
-- Drop if it already exists. 
-- Use IN and OUT parameters to take an employee's number
-- and print out their employee number and average salary.
-- -------------------------------------------------------

DROP PROCEDURE IF EXISTS employees.out_avg_emp_salaries;

DELIMITER $$
USE employees $$
CREATE PROCEDURE out_avg_emp_salaries(
									IN p_in_emp_no INT,
									OUT p_out_emp_no INT,
                                    OUT p_out_avg_salary INT
                                    )
BEGIN
	SELECT 
		e.emp_no,
        AVG(salary)
        -- first_name,
--         last_name,
--         gender,
--         hire_date
	INTO
		p_out_emp_no,
        p_out_avg_salary
	FROM
		employees e
	JOIN
		salaries s 
			ON e.emp_no = s.emp_no
	WHERE e.emp_no = p_in_emp_no;

END $$

DELIMITER ;

call employees.out_avg_emp_salaries(10001, @p_out_emp_no, @p_out_avg_salary);
select @p_out_emp_no AS emp_no, @p_out_avg_salary AS avg_salary;



 