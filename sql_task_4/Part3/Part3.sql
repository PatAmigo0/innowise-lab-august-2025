-- Задание 3: DCL

-- cозданем нового пользователя
CREATE ROLE hr_user WITH LOGIN PASSWORD '1234';

-- предоставляем право выбирать (select) из таблицы employees
GRANT SELECT ON employees TO hr_user;

-- предоставляем право вставлять значения в таблицу employees
GRANT INSERT ON employees TO hr_user;

-- предоставляем право обновлять таблицу employees
GRANT UPDATE ON employees TO hr_user;