-- Часть 5: SUBQUERIES

-- Задача 1. Найдите всех клиентов, которые сделали заказ с максимальной суммой
WITH max_amount as 
(
	SELECT amount
	FROM orders
	ORDER BY amount desc
	LIMIT 1
) -- нахожождение МАКСИМАЛЬНОЙ суммы (amount) среди всех товаров
SELECT customers.first_name, customers.last_name, orders.amount
FROM customers
INNER JOIN orders on orders.customer_id = customers.customer_id
WHERE orders.amount = (SELECT amount FROM max_amount);