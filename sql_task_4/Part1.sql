-- Задание 1: DML

-- вставка двух новых сотрудников в таблицу employees
INSERT INTO employees(firstname, lastname,department, salary)
VALUES
('John', 'Doe', 'IT', 75000),
('Arseniy', 'Kuskov', 'IT', 35000);

-- выбор всех сотрудников из employees
SELECT * FROM employees;

-- выбор только firstname и lastname
SELECT firstname, lastname FROM employees;

-- удаление сотрудника чье lastname 'Prince'
WITH delete_info AS 
(
    DELETE FROM employeeprojects -- сначала удаляем проекты работника
    WHERE employeeid IN 
	(
        SELECT employeeid FROM employees
        WHERE lastname = 'Prince'
    )
    RETURNING employeeid
)
DELETE FROM employees -- потом удаляем самого работника
WHERE employeeid IN (SELECT employeeid FROM delete_info);

-- вывод
SELECT * FROM employees;