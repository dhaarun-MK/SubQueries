CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50));
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
	salary bigint,
	address VARCHAR(50),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id));

INSERT INTO departments (department_id, department_name) 
VALUES 
(1, 'Backend Developer'),
(2, 'Frontend Developer'),
(3, 'Full Stack Developer'),
(4, 'Testing');

INSERT INTO employees (employee_id, employee_name, salary,address, department_id) 
VALUES 
(101, 'Vasim Akram', 60000,'Trichy', 1),
(102, 'Aswin', 75000,'Chennai', 2),
(103, 'Dhaarun', 85000,'Sivaganga', 3),
(104, 'Magesh', 55000,'Trichy', 4),
(105, 'Arul', 50000,'Trichy', 1),
(106, 'Balaji', 60000,'Sivaganga', 3),
(107, 'Karishma', 75000,'Pudukottai', 2),
(108, 'Sathana', 85000,'Trichy', 4);

--Single-row subqueries Using WHERE Clause
SELECT employee_name, department_id
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

--Single-row subqueries Using HAVING Clause
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) > (SELECT AVG(salary) FROM employees);

--SELECT AVG(salary) AS avg_salary FROM employees;

--Single-row subqueries Using SELECT Clause
SELECT employee_name, salary, (
		SELECT department_name 
	    FROM departments 
		WHERE department_id = employees.department_id) 
		AS department_name
FROM employees;

--Multi-row subqueries Using IN 
SELECT employee_name, salary
FROM employees
WHERE department_id IN (
	SELECT department_id 
	FROM departments 
	WHERE address = 'Sivaganga');

--Multi-row subqueries Using ANY
SELECT employee_name, salary
FROM employees
WHERE salary > ANY (SELECT salary FROM employees WHERE department_id = 2);

--Multi-row subqueries Using ALL
SELECT employee_name, salary
FROM employees
WHERE salary > ALL (SELECT salary FROM employees WHERE department_id = 2);

--Correlated subqueries: Dependent on the outer query
SELECT e1.employee_name, e1.salary
FROM employees e1
WHERE e1.salary > (SELECT AVG(e2.salary)
                   FROM employees e2
                   WHERE e2.department_id = e1.department_id);
				   




