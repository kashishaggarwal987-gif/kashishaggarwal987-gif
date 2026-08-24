/* =========================================================
   30 SQL QUERIES PRACTICE PROJECT
   Database: sql_practice
   Tables: Department, Company, Employee
   ========================================================= */


/* =========================================================
   DATABASE SETUP
   ========================================================= */

CREATE DATABASE IF NOT EXISTS sql_practice;

USE sql_practice;


/* =========================================================
   QUERY 1: DROP TABLES IF THEY ALREADY EXIST
   ========================================================= */

DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS company;


/* =========================================================
   QUERY 2: CREATE TABLES
   ========================================================= */

CREATE TABLE department (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE company (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    revenue INT
);

CREATE TABLE employee (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    city VARCHAR(150) NOT NULL,
    department_id INT NOT NULL,
    salary INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES department(id)
);


/* =========================================================
   QUERY 3: INSERT DATA INTO DEPARTMENT
   Department data must be inserted before Employee because
   employee.department_id is a foreign key.
   ========================================================= */

INSERT INTO department (name)
VALUES
('IT'),
('Management'),
('IT'),
('Support');


/* =========================================================
   QUERY 4: INSERT DATA INTO COMPANY
   ========================================================= */

INSERT INTO company (name, revenue)
VALUES
('IBM', 2000000),
('GOOGLE', 9000000),
('Apple', 10000000);


/* =========================================================
   QUERY 5: INSERT DATA INTO EMPLOYEE
   ========================================================= */

INSERT INTO employee (name, city, department_id, salary)
VALUES
('David', 'London', 3, 80000),
('Emily', 'London', 3, 70000),
('Peter', 'Paris', 3, 60000),
('Ava', 'Paris', 3, 50000),
('Penny', 'London', 2, 110000),
('Jim', 'London', 2, 90000),
('Amy', 'Rome', 4, 30000),
('Cloe', 'London', 3, 110000);


/* =========================================================
   QUERY 6: DISPLAY ALL DEPARTMENTS
   ========================================================= */

SELECT *
FROM department;


/* =========================================================
   QUERY 7: DISPLAY ALL EMPLOYEES
   ========================================================= */

SELECT *
FROM employee;


/* =========================================================
   QUERY 8: DISPLAY ALL COMPANIES
   ========================================================= */

SELECT *
FROM company;


/* =========================================================
   QUERY 9: DISPLAY COMPANY NAMES
   ========================================================= */

SELECT name
FROM company;


/* =========================================================
   QUERY 10: DISPLAY EMPLOYEE NAME AND CITY
   ========================================================= */

SELECT name, city
FROM employee;


/* =========================================================
   QUERY 11: COMPANIES WITH REVENUE GREATER THAN 5,000,000
   ========================================================= */

SELECT *
FROM company
WHERE revenue > 5000000;


/* =========================================================
   QUERY 12: COMPANIES WITH REVENUE LESS THAN 5,000,000
   ========================================================= */

SELECT *
FROM company
WHERE revenue < 5000000;


/* =========================================================
   QUERY 13: REVENUE BELOW 5,000,000 WITHOUT USING <
   ========================================================= */

SELECT *
FROM company
WHERE NOT revenue >= 5000000;


/* =========================================================
   QUERY 14: EMPLOYEES WITH SALARY BETWEEN
   50,000 AND 70,000
   ========================================================= */

SELECT *
FROM employee
WHERE salary BETWEEN 50000 AND 70000;


/* =========================================================
   QUERY 15: SAME SALARY FILTER WITHOUT BETWEEN
   ========================================================= */

SELECT *
FROM employee
WHERE salary >= 50000
  AND salary <= 70000;


/* =========================================================
   QUERY 16: EMPLOYEES WITH SALARY = 80,000
   ========================================================= */

SELECT *
FROM employee
WHERE salary = 80000;


/* =========================================================
   QUERY 17: EMPLOYEES WITH SALARY NOT EQUAL TO 80,000
   ========================================================= */

SELECT *
FROM employee
WHERE salary <> 80000;


/* =========================================================
   QUERY 18: EMPLOYEES EARNING ABOVE 70,000
   OR WORKING IN IT
   ========================================================= */

SELECT name
FROM employee
WHERE salary > 70000
   OR department_id IN (
       SELECT id
       FROM department
       WHERE name = 'IT'
   );


/* =========================================================
   QUERY 19: EMPLOYEES WHO WORK IN A CITY STARTING WITH L
   ========================================================= */

SELECT *
FROM employee
WHERE city LIKE 'L%';


/* =========================================================
   QUERY 20: CITY STARTS WITH L OR ENDS WITH S
   ========================================================= */

SELECT *
FROM employee
WHERE city LIKE 'L%'
   OR city LIKE '%s';


/* =========================================================
   QUERY 21: EMPLOYEES WHOSE CITY CONTAINS O
   ========================================================= */

SELECT *
FROM employee
WHERE city LIKE '%o%';


/* =========================================================
   QUERY 22: DISPLAY UNIQUE DEPARTMENT NAMES
   ========================================================= */

SELECT DISTINCT name
FROM department;


/* =========================================================
   QUERY 23: EMPLOYEE NAMES WITH THEIR DEPARTMENT
   ========================================================= */

SELECT
    emp.name AS employee_name,
    dep.id AS department_id,
    dep.name AS department_name
FROM employee AS emp
JOIN department AS dep
    ON emp.department_id = dep.id
ORDER BY emp.name, dep.id;


/* =========================================================
   QUERY 24: EVERY COMPANY WITH EVERY DEPARTMENT
   ========================================================= */

SELECT
    com.name AS company_name,
    dep.name AS department_name
FROM company AS com
CROSS JOIN department AS dep
ORDER BY com.name;


/* =========================================================
   QUERY 25: EVERY COMPANY WITH DEPARTMENTS
   EXCEPT SUPPORT
   ========================================================= */

SELECT
    com.name AS company_name,
    dep.name AS department_name
FROM company AS com
CROSS JOIN department AS dep
WHERE dep.name <> 'Support'
ORDER BY com.name;


/* =========================================================
   QUERY 26: DEPARTMENTS IN WHICH EMPLOYEES DO NOT WORK
   ========================================================= */

SELECT
    emp.name AS employee_name,
    dep.name AS department_name
FROM employee AS emp
CROSS JOIN department AS dep
WHERE emp.department_id <> dep.id;


/* =========================================================
   QUERY 27: COMPANY NAME WITH OTHER COMPANY NAMES
   SELF JOIN
   ========================================================= */

SELECT
    com1.name AS company_1,
    com2.name AS company_2
FROM company AS com1
JOIN company AS com2
    ON com1.name <> com2.name
ORDER BY com1.name, com2.name;


/* =========================================================
   QUERY 28: EMPLOYEES WITH SALARY LESS THAN 80,000
   ========================================================= */

SELECT name
FROM employee
WHERE salary < 80000;


/* =========================================================
   QUERY 29: RENAME COMPANY NAME OUTPUT COLUMN TO COMPANY
   ========================================================= */

SELECT name AS Company
FROM company;


/* =========================================================
   QUERY 30: EMPLOYEES WORKING IN THE SAME DEPARTMENT
   AS PETER
   ========================================================= */

SELECT *
FROM employee
WHERE department_id IN (
    SELECT department_id
    FROM employee
    WHERE name = 'Peter'
)
AND name <> 'Peter';


/* =========================================================
   UPDATE PRACTICE
   Change Department ID 1 to Management
   ========================================================= */

UPDATE department
SET name = 'Management'
WHERE id = 1;

SELECT *
FROM department;


/* =========================================================
   DELETE PRACTICE
   Safe Update Mode Fix
   ========================================================= */

SET SQL_SAFE_UPDATES = 0;

DELETE FROM employee
WHERE salary > 100000;

SELECT *
FROM employee;

SET SQL_SAFE_UPDATES = 1;


/* =========================================================
   END OF SQL PRACTICE PROJECT
   ========================================================= */