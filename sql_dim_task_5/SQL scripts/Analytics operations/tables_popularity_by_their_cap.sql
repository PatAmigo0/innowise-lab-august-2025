-- SQL запрос для того, чтобы узнать какие столы (по вместимости) пользуются большей популярностью

SELECT 
	td.capacity AS cap,
    COUNT(*) AS total_reservations,
    SUM(rf.amount_of_people) AS total_people_served
FROM main_data_warehouse.reservation_fact AS rf
INNER JOIN 
	main_data_warehouse.table_dim AS td ON rf.table_key = td.table_key
WHERE td.is_current = TRUE -- ТОЛЬКО АКТУАЛЬНЫЕ СТОЛЫ!
GROUP BY cap
ORDER BY cap ASC;