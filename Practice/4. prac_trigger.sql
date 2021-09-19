USE employees;

DROP TRIGGER IF EXISTS employees.before_salaries_insert;

DELIMITER $$
USE employees $$

CREATE TRIGGER employees.before_salaries_insert
BEFORE INSERT ON employees.salaries
FOR EACH ROW
BEGIN 
	IF NEW.salary < 0 THEN
		SET NEW.salary = 0;
	END IF;
END $$

DELIMITER ;

INSERT INTO employees.salaries VALUES(
	'10001',
    -74563,
    '1999-01-01',
    '9999-01-01'
);

SELECT *
FROM salaries
WHERE emp_no = 10001;

DELETE FROM employees.salaries
WHERE emp_no = 10001 AND salary = 0;

DROP TRIGGER IF EXISTS employees.tri_aft_ins_salary;

DELIMITER $$
USE employees $$

CREATE TRIGGER employees.tri_aft_ins_dep_mng
AFTER INSERT ON employees.dept_manager
FOR EACH ROW
BEGIN
		DECLARE v_curr_salary INT DEFAULT 0; # v - variable
SELECT 
    MAX(salary)
INTO v_curr_salary FROM
    salaries
WHERE
    emp_no = NEW.emp_no;
        
	IF v_curr_salary IS NOT NULL THEN
	UPDATE 
		salaries
	SET 
		to_date = SYSDATE()
	WHERE
		emp_no = NEW.emp_no AND to_date = NEW.to_date;
		
        INSERT INTO salaries
        VALUES(
			NEW.emp_no,
            v_curr_salary + 20000,
            NEW.from_date,
            NEW.to_date
		);
	END IF;
    
END $$

DELIMITER ;

COMMIT;

INSERT INTO employees.employees
VALUES (
	'111535',
    '1995-01-01',
    'fcc',
    'dupp',
    'M',
    '9999-01-01'
);

INSERT INTO employees.dept_manager
VALUES (
	'111535',
    'd008',
    CURDATE(),
    '9999-01-01'
);

ROLLBACK;

SELECT *
FROM employees
WHERE emp_no = 111534;
-- WHERE emp_no = 10001;

SELECT *
FROM salaries
WHERE emp_no = 111535;

SELECT *
FROM dept_manager
WHERE emp_no = 111535;
