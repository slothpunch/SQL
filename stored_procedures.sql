
/*
A stored routine can be devided into two: stored procedures and functions (user-defined functions)
Users can call, reference, or invloke the routine.

A stored procedure is a groupd SQL statements stored on the database server
and can be used by several different users in a netowrk 
reduce network traffic and imporve the performance.
 
*/

USE employees;

DROP PROCEDURE IF EXISTS TEST;

DELIMITER $$
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



