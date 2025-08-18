-- Задание 6: DML (Optional)

-- проекты, где 'Bob Johnson' работал более 150 часов
SELECT projects.projectname FROM projects
INNER JOIN employeeprojects ON projects.projectid = employeeprojects.projectid
INNER JOIN employees ON employeeprojects.employeeid = employees.employeeid
WHERE employees.firstname = 'Bob'
	AND employees.lastname = 'Johnson'
	AND employeeprojects.hoursworked > 150;

-- увеличение бюджета для проектов департамента IT
UPDATE projects
SET budget = budget * 1.10
WHERE ProjectID IN 
(
	SELECT DISTINCT employeeprojects.ProjectID
	FROM employeeprojects
	INNER JOIN employees ON employeeprojects.employeeid = employees.employeeid
	WHERE employees.department = 'IT'
);

-- обновление EndDate по условию
UPDATE projects
SET enddate = startdate + INTERVAL '1 year'
WHERE enddate IS NULL;

-- транзакция по добавлению сотрудника и назначение его на проект
BEGIN;
	-- вставка нового сотрудника
	WITH new_employee AS 
	(
	    INSERT INTO employees(firstname, lastname, department, salary)
	    VALUES ('John', 'Smith', 'IT', 95000)
	    RETURNING employeeid
	),
	
	-- получение id проекта
	project_info AS 
	(
	    SELECT projectid FROM projects 
	    WHERE projectname = 'GPT-6'
	)
	
	-- назначение на проект
	INSERT INTO employeeprojects (employeeid, projectid, hoursworked)
	SELECT new_employee.employeeid, project_info.projectid, 0
	FROM new_employee
	CROSS JOIN project_info;
COMMIT;