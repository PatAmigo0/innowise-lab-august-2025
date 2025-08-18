-- Часть 1: WHERE

-- Задача 1. Найдите всех клиентов из страны 'USA', которым больше 25 лет.
SELECT first_name, last_name, age, country
FROM customers
WHERE country = 'USA' and age > 25;

-- Задача 2. Выведите все заказы, у которых сумма (amount) больше 1000.
SELECT order_id, item, amount, customer_id
FROM orders
WHERE amount > 1000;