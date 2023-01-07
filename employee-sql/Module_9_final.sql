CREATE TABLE departments (
  dept_no VARCHAR(4) PRIMARY KEY,
  dept_name VARCHAR(40) NOT NULL
);


select * from departments

CREATE TABLE dept_emp (
	CREA INTEGER,
	dept_no VARCHAR(4) NOT NULL,
	CONSTRAINT dept_emp_pkey PRIMARY KEY (CREA, dept_no)
);


select * from dept_emp

CREATE TABLE dept_manager (
   dept_no VARCHAR(4),
   emp_no int,
   CONSTRAINT dept_manager_pkey PRIMARY KEY (dept_no, emp_no)
);

select * from dept_manager



CREATE TABLE employees (
   emp_no int PRIMARY KEY,
   emp_title VARCHAR(6),
   birth_date VARCHAR(10),
   first_name VARCHAR(255),
   last_name VARCHAR(255),
   sex CHAR(1),
   hire_date VARCHAR(10)
);

ALTER TABLE employees
ALTER COLUMN 
birth_date TYPE DATE using to_date(birth_date, 'MM/DD/YYYY');

ALTER TABLE employees
ALTER COLUMN
hire_date TYPE DATE using to_date(hire_date, 'MM/DD/YYYY');

select * from employees

SET datestyle = 'MDY';

show datestyle;

CREATE TABLE salaries (
	emp_no INTEGER PRIMARY KEY,
  	salary INTEGER
);

select * from salaries

CREATE TABLE titles (
	title_id VARCHAR(10) PRIMARY KEY,
	title CHAR(40) NOT NULL
);

select * from titles

select date_part('year', birth_date) from employees

--List the employee number, last name, first name, sex, and salary of each employee.
CREATE TABLE employees_with_salary
as select * from employees
JOIN salaries USING (emp_no)

SELECT emp_no, last_name, first_name, sex, salary FROM employees_with_salary

--List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT first_name, last_name, hire_date FROM employees
WHERE extract(year FROM hire_date) = 1986;

--List the manager of each department along with their department number, department name, employee number, last name, and first name.
CREATE TABLE dept_manager_department_employees
as SELECT employees.emp_no AS employee_number, departments.dept_no AS department_number, departments.dept_name AS department_name, employees.first_name AS employee_first_name, employees.last_name AS employee_last_name
FROM dept_manager
JOIN departments ON dept_manager.dept_no = departments.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no;

select * from dept_manager_department_employees

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
CREATE TABLE dept_number_employee_employee_number
as SELECT employees.emp_no AS employee_number, employees.last_name AS last_name, employees.first_name AS first_name, departments.dept_no AS department_number, departments.dept_name AS department_name
FROM employees
JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
JOIN departments ON dept_manager.dept_no = departments.dept_no;

select * from dept_number_employee_employee_number

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name.
CREATE TABLE question_6
as SELECT employees.emp_no AS employee_number, employees.last_name AS last_name, employees.first_name AS first_name, departments.dept_name AS department_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.crea
JOIN departments ON dept_emp.dept_no = departments.dept_no;

select * from question_6
WHERE department_name = 'Sales';


--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT * FROM question_6
WHERE department_name IN ('Sales', 'Development');

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;


