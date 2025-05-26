SELECT department_id, count(\*) 
    FROM employees 
    GROUP BY department_id;

SELECT d.department_name, avg(e.salary)
FROM employees e
    JOIN departments d on d.department_id = e.department_id
GROUP BY
    department_name;