-- SQL запрос для того, чтобы узнать, кто лучше всего работал в прошлый месяц

SELECT
	sd.employee_id AS employee_id,
    sd.employee_name AS employee_name,
    td.table_number AS table_number,
    COUNT(*) AS reservations_processed,
	SUM(COUNT(*)) OVER (PARTITION BY employee_id) AS total_reservations_processed
FROM main_data_warehouse.reservation_fact rf
INNER JOIN
    main_data_warehouse.staff_dim AS sd ON rf.employee_key = sd.employee_key
INNER JOIN
    main_data_warehouse.table_dim AS td ON rf.table_key = td.table_key
INNER JOIN
  	main_data_warehouse.date_dim AS dd ON rf.date_key = dd.date_key
WHERE
    dd.date_year = EXTRACT(YEAR FROM CURRENT_DATE)
    AND dd.date_month = EXTRACT(MONTH FROM CURRENT_DATE) - 1 -- т.е за прошлый месяц
GROUP BY employee_id, employee_name, table_number
ORDER BY total_reservations_processed DESC;