-- Задание 2: DDL

-- созданем таблицу Departments
CREATE TABLE IF NOT EXISTS departments 
(
    departmentid SERIAL PRIMARY KEY,
    departmentname varchar(50) UNIQUE NOT NULL,
    Location varchar(50)
);

-- добавляем столбец Email в таблицу Employees
ALTER TABLE employees ADD COLUMN IF NOT EXISTS email varchar(100);

-- заполнение столбца 'временными' уникальными значениями
UPDATE employees SET email = 
	'employee.' 
    || EXTRACT(EPOCH FROM NOW()) -- число секунд с 1970 года
    || '.' 
    || employeeid 
    || '@innowise.com'
WHERE email IS NULL;

-- добавляем ограничение UNIQUE
ALTER TABLE employees ADD CONSTRAINT unique_email UNIQUE (email);

-- переименоваем столбец Location в Departments
ALTER TABLE departments RENAME COLUMN Location TO OfficeLocation;