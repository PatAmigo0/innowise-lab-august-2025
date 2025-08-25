-- SQL запрос для того, чтобы узнать кто из клиентов больше тратится :)

SELECT 
	cd.customer_id AS customer_id,
	cd.customer_name AS customer_name,
	SUM(rf.deposit_amount) AS total_deposited
FROM main_data_warehouse.reservation_fact AS rf  
INNER JOIN main_data_warehouse.customer_dim AS cd ON rf.customer_key = cd.customer_key
GROUP BY cd.customer_id, cd.customer_name
ORDER BY total_deposited DESC;