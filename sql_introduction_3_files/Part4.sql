-- Часть 4: ORDER BY

-- Задача 1. Выведите список клиентов, отсортированный по возрасту по убыванию
SELECT first_name, age
FROM customers
ORDER BY age desc;