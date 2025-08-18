-- Часть 2: JOIN

-- Задача 1. Получите список заказов вместе с именем клиента, который сделал заказ
SELECT customers.first_name, customers.last_name, orders.item, orders.amount
FROM customers
INNER JOIN orders on customers.customer_id = orders.customer_id;

-- Задача 2. Выведите список доставок со статусом и именем клиента
SELECT shippings.status, customers.first_name, customers.last_name
FROM shippings
INNER JOIN customers on customers.customer_id = shippings.customer;