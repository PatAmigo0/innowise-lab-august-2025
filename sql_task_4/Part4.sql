-- Задание 4: DML/DCL

-- увеличение зарплаты всех сотрудников HR
UPDATE employees
SET salary = salary * 1.1
WHERE department = 'HR';

-- изменение департаментов у работников с з/п выше 70000
UPDATE employees
SET department = 'Senior IT'
WHERE salary > 70000;

-- удаление всех сотрудников, у которых нет ни одного проекта
DELETE FROM employees
WHERE NOT EXISTS
(
	SELECT employeeid FROM employeeprojects
	WHERE employeeprojects.employeeid = employees.employeeid
);

-- создаем новый проект и добавляем туда 2 сущ. сотрудника
BEGIN;
	-- создание нового проекта
	WITH new_project AS 
	(
	    INSERT INTO projects(projectname)
	    VALUES ('GPT-6')
	    RETURNING projectid
	)
	
	-- вставка через select
	INSERT INTO employeeprojects(employeeid, projectid, hoursworked)
	SELECT emp_id, projectid, hours 
	FROM new_project
	CROSS JOIN -- декартово произведение
	(
		VALUES 
			(2, 0), 
			(3, 0)
	) 
	AS employees(emp_id, hours);
COMMIT;