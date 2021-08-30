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

