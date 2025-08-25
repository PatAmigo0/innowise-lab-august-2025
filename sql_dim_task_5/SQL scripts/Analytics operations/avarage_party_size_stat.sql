-- SQL запрос для того, чтобы узнать всю статистику по брони на каждый день недели

SELECT 
	dd.day_of_week AS day_of_week,
	-- switch case
    CASE day_of_week
        WHEN 1 THEN 'Monday'
        WHEN 2 THEN 'Tuesday'
        WHEN 3 THEN 'Wednesday'
		WHEN 4 THEN 'Thursday'
		WHEN 5 THEN 'Friday'
		WHEN 6 THEN 'Saturday'
        WHEN 7 THEN 'Sunday'
    END AS day_name,
    COUNT(day_of_week) AS total_reservations,
    AVG(rf.amount_of_people)::INT AS avarage_amount_of_people
FROM main_data_warehouse.reservation_fact AS rf
INNER JOIN main_data_warehouse.date_dim AS dd ON rf.date_key = dd.date_key
GROUP BY day_of_week
ORDER BY day_of_week ASC;