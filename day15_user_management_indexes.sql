-- DAY 15 USER MANAGEMENT, INDEXES:

/*
Challenge 1: USER MANAGEMENT
In this challenge you need to create a user, a role and add privileges.
Your tasks are the following:
Create the user mia with password 'mia123'
Create  the role analyst_emp;
Grant SELECT on all tables in the public schema to that role.
Grant INSERT and UPDATE on the employees table to that role.
Add the permission to create databases to that role.
Assign that role to mia and test the privileges with that user
*/

-- Create the user mia with password 'mia123'
CREATE USER mia
WITH PASSWORD 'mia123';

--Create  the role analyst_emp
CREATE ROLE analyst_emp;

--Grant SELECT on all tables in the public schema to that role.
GRANT SELECT
ON ALL TABLES IN SCHEMA public
TO analyst_emp;

--Grant INSERT and UPDATE on the employees table to that role.
GRANT INSERT, UPDATE
ON employees
TO analyst_emp;

--Add the permission to create databases to that role.
ALTER ROLE analyst_emp CREATEDB;

--Assign that role to mia and test the privileges with that user.
GRANT analyst_emp
TO mia;

/*
Challenge 2: INDEXES
Execute the following query:
SELECT * FROM flights f2
WHERE flight_no < (SELECT MAX(flight_no)
				  FROM flights f1
				   WHERE f1.departure_airport=f2.departure_airport
				   )
This query has a very bad performance.
Test indexes on different columns and compare their performance.
Also considder an index on multiple columns.
On which column(s) would you place an index to get the best performance in the query?
*/


SELECT * FROM flights f2
WHERE flight_no < (SELECT MAX(flight_no)
				FROM flights f1
				WHERE f1.departure_airport=f2.departure_airport
				);


DROP INDEX index_flight_no;
CREATE INDEX index_flight_no
ON flights
(
	flight_no	
);


DROP INDEX index_departure_airport;
CREATE INDEX index_departure_airport
ON flights
(
	departure_airport
);

--Complete in 00:575!!!
CREATE INDEX index_flight_no_departure_airport
ON flights
(
	flight_no,
	departure_airport
);