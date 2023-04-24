-- DAY 14 USER-DEFINED FUNCTIONS, TRANSACTIONS, PROCEDURES:

-- Challenge 1: USER-DEFINED FUNCTIONS
-- Create a function that takes first and last name and returns total amount of payments for customer.
CREATE FUNCTION name_search (n1 VARCHAR(20), n2 VARCHAR(20))
RETURNS NUMERIC(6,2)
LANGUAGE plpgsql

AS
$$
DECLARE
sum_of_amount NUMERIC(6,2);
BEGIN
SELECT 
SUM(amount)
INTO sum_of_amount
FROM customer c 
LEFT JOIN payment p 
ON c.customer_id = p.customer_id
WHERE n1=first_name AND n2=last_name;
RETURN sum_of_amount;
END;
$$

SELECT name_search('AMY', 'LOPEZ');

-- Challenge 2: TRANSACTION 
-- Swaping employees positions including salary.
SELECT * FROM employees
ORDER BY emp_id

BEGIN; --starts transaction

UPDATE employees
SET position_title = 'Head of Sales'
WHERE emp_id = 2;
UPDATE employees
SET position_title = 'Head of BI'
WHERE emp_id = 3; 
UPDATE employees
SET salary = 12587.00
WHERE emp_id = 2;
UPDATE employees
SET salary = 14614.00
WHERE emp_id = 3;

ROLLBACK; 	--undo everything that hasn't been commited/ends transaction (ROLLBACK TO SAVEPOINT <name>; - undo to savepoint and doesn't end transaction)
COMMIT; 	--commits transaction

SELECT * FROM employees
ORDER BY emp_id;

-- Challenge 3: PROCEDURES
-- Swaping employees positions including salary.
CREATE OR REPLACE PROCEDURE emp_swap (emp1 INT, emp2 INT)
LANGUAGE plpgsql

AS
$$

DECLARE
position_emp1 TEXT;
position_emp2 TEXT;
salary_emp1 numeric(8,2);
salary_emp2 numeric(8,2);

BEGIN

-- store values in variables
SELECT position_title 
INTO position_emp1
FROM employees
WHERE emp_id = emp1;

SELECT position_title 
INTO position_emp2
FROM employees
WHERE emp_id = emp2;

SELECT salary 
INTO salary_emp1
FROM employees
WHERE emp_id = emp1;

SELECT salary 
INTO salary_emp2
FROM employees
WHERE emp_id = emp2;

-- update of first employee
UPDATE employees
SET position_title = position_emp2
WHERE emp_id = emp1;

UPDATE employees
SET salary = salary_emp2
WHERE emp_id = emp1;

-- update of second employee
UPDATE employees
SET position_title = position_emp1
WHERE emp_id = emp2;

UPDATE employees
SET salary = salary_emp1
WHERE emp_id = emp2;

COMMIT;
END;
$$

CALL emp_swap (2, 3);

SELECT * FROM employees
ORDER BY emp_id;

/*
Functions can't modify anything and must have at least one parameter. They also have to return a result. 
Stored procedures don't need a parameter, may modify database objects, and don't have to return a result.
Stored procedures are used to connect SQL queries in a transaction and to communicate with the outside world. 
ADO.NET and other frameworks can't call a function directly, but they can call a stored procedure.
*/