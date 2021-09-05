-- https://www.mysqltutorial.org/mysql-index/

-- Index 
-- to improve the speed of data retrieval 
-- Primary(Unique) key is also an index which is the clustered index


-- CREATE --
-- CREATE INDEX index_name ON table_name(col_1, col2, ...)

USE employees;

SELECT 
    *
FROM
    employees
WHERE
    birth_date > '1965-01-01';

CREATE INDEX i_dob ON employees.employees(birth_date);


-- Composite Index -- more than 2 cols 
-- CREATE INDEX index_name ON table_name(col_1, col2, ...)

SELECT
	*
FROM 
	employees
WHERE
	first_name = 'Ohad'
		AND last_name ='Esposito';

CREATE INDEX i_flnames ON employees.employees(first_name, last_name);

SHOW INDEXES FROM employees;

-- DROP index --
-- DROP INDEX index_name ON table_name [algorithm_option | lock_option]; 


