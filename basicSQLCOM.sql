#part 1,Q1
USE employees;
SELECT *
FROM titles;

#part1 Q2
SELECT emp_no, to_date
FROM titles;
#part1 Q3
SELECT first_name, last_name, gender
FROM employees
WHERE gender='f';
#part4 Q4
SELECT *
FROM employees
WHERE (hire_date>"1990-10-10" AND gender='m') OR gender='f';

#part1 Q5
SELECT DISTINCT salary AS sal,emp_no AS employeeNumber
FROM salaries;

#part1 Q6
SELECT concat(first_name, last_name) AS names
FROM employees
WHERE gender='F';
#part1 Q7
SELECT distinct emp_no,
CASE WHEN salary <= 50000 then "UNDERPAID"
WHEN salary >= 80000 then "OVERPAID"
ELSE "PAID"
END AS salarystatus
FROM salaries;

#part1 Q8
SELECT DISTINCT emp_no
FROM salaries
LIMIT 5;

#part1 Q9
SELECT emp_no, salary
FROM salaries
ORDER BY rand() limit 5;

#part1 Q10
SELECT emp_no,birth_date
FROM employees
WHERE birth_date IS NULL;

#part1 Q11
SELECT COALESCE (birth_date, 0)
FROM employees;

#part1 Q11
SELECT emp_no,salary
FROM salaries
WHERE salary  IN (40000,50000) AND 
(emp_no LIKE '%78%' OR emp_no LIKE '%83');

#part 2 Q1
SELECT emp_no, salary
FROM salaries
WHERE salary>50000
ORDER BY salary desc;

#part2 Q2
SELECT emp_no,from_date,salary
FROM salaries
ORDER BY emp_no, salary desc;

#part2 Q3
SELECT first_name,last_name,gender
FROM employees
ORDER BY substring(first_name,2,4) ;

#part 2 Q4
SELECT emp_no, from_date, salary
FROM (
SELECT emp_no, from_date, salary,
CASE WHEN salary IS NULL THEN 0 ELSE 1 END AS is_null
FROM salaries
) x
ORDER BY is_null desc, salary;

#part 2  Q5
SELECT first_name, gender,hire_date,
CASE WHEN gender = 'F' then first_name
else hire_date end as ordered
FROM employees
ORDER BY ORDERED;

#part 2 Q6
SELECT first_name, last_name, DATEDIFF(hire_date, birth_date)/365 AS
age_hire
FROM employees
WHERE gender = 'M' ;

#part 2 Q7
SELECT first_name, DATEDIFF(hire_date, birth_date)/365 AS
age_hire
FROM employees
WHERE (DATEDIFF(hire_date, birth_date)/365)>28;

#part3 Q1
SELECT emp_no as emp_and_dept_no, hire_date
FROM employees
where hire_date= "1990-10-1"
UNION ALL
SELECT dept_no, from_date
FROM dept_manager;

#part3 Q2
SELECT DISTINCT E.emp_no,first_name,salary
FROM employees E, salaries S
WHERE E.emp_no=S.emp_no;

#part 3 Q3
SELECT emp_no
FROM employees
WHERE emp_no NOT IN (SELECT emp_no 
FROM dept_manager);
#part 3 Q4
SELECT count(emp_no) as total_emp, sum(salary) as total_salary, 
avg(salary) as avg_salary
FROM salaries;

USE employees;
#part 4 4.1
INSERT INTO employees (emp_no,birth_date,first_name,last_name,gender,hire_date)
VALUES( '1234213564','1967-3-3','mike','crock','f','1989-10-10');
SELECT *
FROM employees
WHERE emp_no=1234213564;

#part 4 4.2
USE employees;
CREATE TABLE new_table (try INTEGER DEFAULT 0);
INSERT INTO new_table (try)  VALUES(default);
SELECT*
FROM new_table;

#part 4 4.3
CREATE TABLE new_table2 (std_id INTEGER DEFAULT 0, std_name VARCHAR(10),GPA INTEGER DEFAULT 4);

INSERT INTO new_table2 (std_id, std_name,GPA) VALUES (null, 'TSU_TIGERS',DEFAULT);

SELECT*
FROM new_table2;
#part 4 4.4
INSERT INTO new_table2 (std_id, std_name,GPA)
SELECT emp_no,first_name, datediff(hire_date,birth_date)
FROM employees
WHERE emp_no=1234213564;

SELECT*
FROM new_table2;

#part 4 4.5
CREATE TABLE new_table3
AS
SELECT *
FROM new_table2
WHERE 1 = 0;

SELECT *
FROM new_table3;

#part 4 4.6
UPDATE new_table2
SET GPA = GPA*0.9
WHERE GPA = 4;

#part 4 4.7
UPDATE salaries
SET salary = salary* 1.10
WHERE emp_no IN (SELECT emp_no FROM dept_emp WHERE dept_no=d007);

#part 4 4.8
DELETE FROM new_table2 WHERE GPA = 4;

#part 4 4.9
DELETE FROM  employees
WHERE NOT EXISTS (
SELECT * FROM salaries
WHERE employees.emp_no = salaries.emp_no);

#part 4 4.10
DELETE FROM departments
WHERE dept_no NOT IN
(SELECT min (dept_no) FROM departments GROUP BY dept_name);

#part 4 4.11
DELETE FROM employees
WHERE emp_no IN (
 SELECT *
 FROM titles 
 GROUP BY emp_no
 HAVING COUNT(*)>=3)