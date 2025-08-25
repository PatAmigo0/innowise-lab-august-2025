-- Задание 5: Функции и представления

-- созданем функцию CalculateAnnualBonus
CREATE OR REPLACE FUNCTION CalculateAnnualBonus -- начало функции
(
    employee_id INT, 
    employee_salary DECIMAL
) RETURNS DECIMAL LANGUAGE plpgsql AS $$
BEGIN
    RETURN employee_salary * 0.10; -- бонус 10% от зарплаты
END; 
$$; -- конец функции

-- использование функции в select
SELECT 
    employeeid, firstname, lastname, salary,
    CalculateAnnualBonus(employeeid, salary) as annualbonus
FROM employees;

-- созданем представление IT_Department_View
CREATE OR REPLACE VIEW IT_Department_View as
SELECT 
    employeeid, firstname, lastname, salary
FROM employees
WHERE department = 'IT';

-- выбор данных из представления
SELECT * FROM IT_Department_View;