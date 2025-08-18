-- Часть 7 (Опционально)

SELECT 
	CONCAT(customers.first_name, ' ', customers.last_name) as full_name, -- объединяем две строки в одну добавляя пробел
	customers.country,
    COUNT(orders.item) as total_olders, -- считаем заказы для каждой группы
	SUM(orders.amount) as total_sum -- считаем сумму заказов для каждой группы
FROM orders
INNER JOIN customers on customers.customer_id = orders.customer_id -- соединяем таблицы
GROUP BY customers.customer_id -- группируем для каждого уникального покупателя
HAVING COUNT(item) >= 2 -- отсеиваем лишнее
ORDER BY total_sum desc; -- сортируем по убыванию для total_sum чтобы было красиво