
-- https://www.mysqltutorial.org/mysql-stored-procedure-tutorial.aspx

/*
A stored routine can be devided into two: stored procedures and functions (user-defined functions)
Users can call, reference, or invloke the routine.

A stored procedure is a groupd SQL statements stored on the database server
and can be used by several different users in a netowrk 
reduce network traffic and imporve the performance.
 
*/

/*******************

When you make a typo, like type DELIM"E"TER instead of DELIM"I"TER, you will get an error: 
	
    Error Code: 2014. Commands out of sync; you can't run this command now	0.000 sec
    
Also, when you drop a stored procedure without specifying the schema, for example, 
	
    DROP PROCEDURE IF EXISTS TEST; inseated of DROP PROCEDURE IF EXISTS employees.TEST;

you will get the error as well.

********************/

--  Stored Procedures 

-- DELIMITER $$
-- CREATE PROCEDURE procedures_name(IN, OUT, INOUT)
-- CREATE PROCEDURE procedures_name(IN parameter_name data_type, OUT parameter_name data_type)
-- BEGIN
-- 		SELECT *
-- 		FROM table;
-- END $$
-- DELIMITER ;


-- -------------------------------------
-- Stored procedures without parameters
-- -------------------------------------

USE employees;
DROP PROCEDURE IF EXISTS TEST;

DELIMITER $$
USE employees;
CREATE PROCEDURE TEST()
BEGIN
		SELECT *
		FROM employees LIMIT 1000;
END$$

DELIMITER ; -- it has to be DELIMITER(space);

-- Three ways to call the procedure
-- 1. type database and call the procedure with the dot notation 
CALL employees.TEST();
-- 2. type the name of procedure
CALL TEST();
-- 3. click the lightening symbol in the Stored Procedures in the SCHEMAS section, located the left side 


-- ------------------------------------
-- Stored procedures with IN parameter
-- ------------------------------------

USE employees;
DROP PROCEDURE IF EXISTS emp_salaries;

DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_salaries(IN p_emp_no INTEGER) -- p_emp_no will take any emp_no from the user to search that employee's salary
BEGIN
	SELECT e.emp_no, e.first_name, e.last_name, AVG(s.salary)
    FROM employees e
    JOIN salaries s
		ON e.emp_no = s.emp_no
	WHERE e.emp_no = p_emp_no;
END$$

DELIMITER ;

CALL emp_salaries(10001);

-- --------------------------------------------
-- Stored procedures with IN and OUT parameters
-- --------------------------------------------

USE employees;
DROP PROCEDURE IF EXISTS employees.avg_emp_salaries_out;

DELIMITER $$
USE employees $$
CREATE PROCEDURE avg_emp_salaries_out(
				IN p_in_emp_no INT, 
                
                OUT p_out_emp_no INT,
                OUT p_first_name VARCHAR(255),
                OUT p_last_name VARCHAR(255),
				OUT p_avg_emp_sal DECIMAL(10,2)
) 
BEGIN
	SELECT 
		e.emp_no, 
        e.first_name, 
        e.last_name, 
        AVG(s.salary)
    INTO 
		p_out_emp_no,
        p_first_name,
        p_last_name,
        p_avg_emp_sal		
    FROM 
		employees e
    JOIN 
		salaries s
			ON e.emp_no = s.emp_no
	WHERE e.emp_no = p_in_emp_no;
END$$

DELIMITER ;

SET @p_avg_emp_sal = 0;
CALL avg_emp_salaries_out(10001, @p_out_emp_no, @p_first_name, @p_last_name, @p_avg_emp_sal);
SELECT @p_out_emp_no, @p_first_name, @p_last_name, @p_avg_emp_sal;


