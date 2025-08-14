-- Часть 3: GROUP BY

-- Задача 1. Подсчитайте количество клиентов в каждой стране
SELECT country, COUNT(country) as count
FROM customers
GROUP BY country;

-- Задача 2. Посчитайте общее количество заказов и среднюю сумму по каждому товару
SELECT item, COUNT(item) as count, ROUND(AVG(amount), 2) as avg_amount -- округляю так как у меня в таблице результат выглядел так: 315.0000000000...
from orders
GROUP BY item;