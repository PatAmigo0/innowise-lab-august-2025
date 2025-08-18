-- Часть 5: SUBQUERIES

-- Задача 1. Найдите всех клиентов, которые сделали заказ с максимальной суммой
SELECT customers.first_name, customers.last_name, orders.amount
FROM customers
INNER JOIN orders on orders.customer_id = customers.customer_id
WHERE orders.amount = (SELECT MAX(amount) FROM orders);