-- List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no as "Employee Number",
        e.last_name as "Last Name",
        e.first_name as "First Name",
        e.sex as "Employee Number",
        s.salary as "Salary"
FROM employees as e
LEFT JOIN salaries as s ON
e.emp_no = s.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT e.first_name as "First Name",
        e.last_name as "Last Name",
        e.hire_date as "Hire Date"
FROM employees as e
WHERE hire_date >= '1986-01-01'
    AND hire_date <= '1986-12-31';

-- List the manager of each department along with their department number, 
-- department name, employee number, last name, and first name.
SELECT d.dept_name as "Department Name", 
		d.dept_no as "Department Number", 
		e.emp_no as "Employee Number", 
		e.last_name as "Last Name", 
		e.first_name as "First Name"
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no
INNER JOIN employees as e
ON dm.emp_no = e.emp_no;

-- List the department number for each employee along with that employee’s employee number, 
-- last name, first name, and department name.
SELECT d.dept_no as "Department Number", 
		e.emp_no as "Employee Number",
		e.first_name as "First Name",
		e.last_name as "Last Name", 
		d.dept_name as "Department Name"
FROM departments as d
INNER JOIN dept_emp as de
ON d.dept_no = de.dept_no
INNER JOIN employees as e
ON de.emp_no = e.emp_no;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name as "First Name", last_name as "Last Name", sex as "Sex"
FROM employees
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name.
SELECT emp_no as "Employee Number", last_name as "Last Name", first_name as "First Name" 
FROM employees
WHERE emp_no in 
	(
	SELECT emp_no
	FROM dept_emp
	WHERE dept_no IN 
		(
		SELECT dept_no
		FROM departments
		WHERE dept_name = 'Sales'
		)
	);
	
-- List each employee in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.
SELECT d.dept_no as "Department Number", 
		e.emp_no as "Employee Number",
		e.first_name as "First Name",
		e.last_name as "Last Name", 
		d.dept_name as "Department Name"
FROM departments as d
INNER JOIN dept_emp as de
ON d.dept_no = de.dept_no
INNER JOIN employees as e
ON de.emp_no = e.emp_no
WHERE e.emp_no in 
	(
	SELECT emp_no
	FROM dept_emp as de
	WHERE de.dept_no IN 
		(
		SELECT dept_no
		FROM departments as d
		WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'
		)
	);
-- No employees work in both Sales *and* Development. 
	
-- List the frequency counts, in descending order, of all the employee last names 
-- (that is, how many employees share each last name).
SELECT last_name as "Last Name", COUNT(last_name) as "Frequency of Last Name"
FROM employees
GROUP BY last_name 
ORDER BY COUNT(last_name) DESC;

-- verified output of above code 
SELECT COUNT(DISTINCT last_name)
FROM employees;