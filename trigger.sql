USE employees;

COMMIT;

# Before INSERT
DELIMITER $$

CREATE TRIGGER before_salaries_insert # Activated whenever a new salary record is inserted
BEFORE INSERT ON employees.salaries
FOR EACH ROW
BEGIN
	IF NEW.salary < 0 THEN
		SET NEW.salary = 0;
	END IF;
END $$

DELIMITER ;

SELECT *
FROM employees.salaries
WHERE emp_no = '10001';

INSERT INTO employees.salaries VALUES(
	'10001',
    -987231,
    '2010-06-22',
    '9999-01-01'
);

-- Before UPDATE
DELIMITER $$

CREATE TRIGGER before_salaries_update
BEFORE UPDATE ON employees.salaries
FOR EACH ROW
BEGIN
	IF NEW.salary < 0 THEN
		SET NEW.salary = OLD.salary;
	END IF;
END$$

DELIMITER ;

UPDATE employees.salaries
SET
	salary = 98765
WHERE
	emp_no = '10001'
		AND from_date = '2010-06-22';

SELECT *
FROM employees.salaries
WHERE emp_no = '10001';

UPDATE employees.salaries
SET 
	salary = -50000
WHERE
	emp_no = '10001'
		AND from_date = '2010-06-22';

SELECT SYSDATE(); -- 2021-09-01 14:52:02

SELECT DATE_FORMAT(SYSDATE(), '%Y-%M-%D') AS today; -- 2021-September-1st
SELECT DATE_FORMAT(SYSDATE(), '%y-%m-%d') AS today; -- 21-09-01

DELIMITER $$

CREATE TRIGGER trig_ins_dep_mng -- trigger for inserting department managers
AFTER INSERT ON employees.dept_manager -- activated whenever a new data is inserted into dept_manager
FOR EACH ROW -- check the status of data on all rows
BEGIN
	DECLARE v_curr_salary INT;

SELECT 
    MAX(salary)
INTO v_curr_salary FROM
    salaries
WHERE
    emp_no = NEW.emp_no;
    
    IF v_curr_salary IS NOT NULL THEN
		UPDATE salaries
        SET
			to_date = SYSDATE()
		WHERE
			emp_no = NEW.emp_no AND to_date = NEW.to_date;
	
		INSERT INTO salaries
			VALUES(NEW.emp_no, v_curr_salary + 20000, NEW.from_date, NEW.to_date);
	END IF;
END$$

DELIMITER ;

COMMIT;
-- indefinite term contract (9999-01-01)
INSERT INTO employees.dept_manager VALUES('111534', 'd009', DATE_FORMAT(SYSDATE(), '%Y-%m-%d'), '9999-01-01');

SELECT *
FROM employees.salaries
WHERE emp_no = '111534'
ORDER BY 2 DESC;

SELECT *
FROM dept_manager;

COMMIT;

DELETE FROM employees.dept_manager
WHERE 
	emp_no = '111534' AND
	dept_no = 'd009' AND
    from_date =  DATE_FORMAT(SYSDATE(), '%Y-%m-%d') AND
    to_date = '9999-01-01';







