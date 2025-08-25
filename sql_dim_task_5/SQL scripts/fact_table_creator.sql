DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'day_part') THEN
        CREATE TYPE day_part AS ENUM 
		(
            'Morning', 
            'Afternoon', 
            'Evening', 
            'Night'
        );
    END IF;
END $$;

-- создаем схему для хранилища данных
CREATE SCHEMA IF NOT EXISTS main_data_warehouse;

-- таблица измерение для отслеж
CREATE TABLE IF NOT EXISTS main_data_warehouse.customer_dim 
(
	-- ключ для fact table
    customer_key serial PRIMARY KEY,

	-- id в системе
    customer_id int NOT NULL,

	-- информация о клиенте
    customer_name varchar(256) NOT NULL,
    contact_phone varchar(20) NOT NULL,

	-- для слежки
    start_date date NOT NULL DEFAULT CURRENT_DATE,
    end_date date,
    is_current boolean NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS main_data_warehouse.table_dim 
(
	-- ключ для fact table
    table_key serial PRIMARY KEY,

	-- id в системе
    table_id int NOT NULL,

	-- информация о столе
    table_number varchar(256) NOT NULL UNIQUE,
    capacity int NOT NULL CHECK (capacity > 0),
    status table_status NOT NULL,

	-- для слежки
    start_date date NOT NULL DEFAULT CURRENT_DATE,
    end_date date,
    is_current boolean NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS main_data_warehouse.staff_dim 
(
	-- ключ для fact table
    employee_key serial PRIMARY KEY,

	-- id в системе
    employee_id int NOT NULL,

	-- информация о работнике
    employee_name varchar(256) NOT NULL,

	-- для слежки
    start_date date NOT NULL DEFAULT CURRENT_DATE,
    end_date date,
    is_current boolean NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS main_data_warehouse.date_dim 
(
	-- ключ для fact table
    date_key int PRIMARY KEY, 

	-- информация о дате
    full_date date NOT NULL,
	
	date_year int NOT NULL,
	date_month int NOT NULL,
    day_of_week int NOT NULL, -- 1-7
	
    is_weekend boolean NOT NULL,
    is_holiday boolean NOT NULL
);

CREATE TABLE IF NOT EXISTS main_data_warehouse.time_dim 
(
	-- ключ для fact table
    time_key int PRIMARY KEY,

	-- информация о времени
    full_time time NOT NULL,
	
	part_of_day day_part NOT NULL, -- enum 'Morning', 'Afternoon', 'Evening', 'Night'
	hour_of_day int NOT NULL -- 0-23
);

CREATE TABLE IF NOT EXISTS main_data_warehouse.reservation_fact 
(
    fact_table_key serial PRIMARY KEY,

	-- ключи fact table
    customer_key int NOT NULL REFERENCES main_data_warehouse.customer_dim(customer_key),
    table_key int NOT NULL REFERENCES main_data_warehouse.table_dim(table_key),
    employee_key int NOT NULL REFERENCES main_data_warehouse.staff_dim(employee_key),
    date_key int NOT NULL REFERENCES main_data_warehouse.date_dim(date_key),
    time_key int NOT NULL REFERENCES main_data_warehouse.time_dim(time_key),

	-- информация о брони
    amount_of_people int NOT NULL CHECK (amount_of_people > 0),
    duration_minutes int NOT NULL,
    deposit_amount numeric(10, 2) DEFAULT 0
);

-- дополнительно индексы для повышения скорости запросов
create index IF NOT EXISTS index_customer_dim 
	on main_data_warehouse.reservation_fact(customer_key);
	
create index IF NOT EXISTS index_table_dim 
	on main_data_warehouse.reservation_fact(table_key);
	
create index IF NOT EXISTS index_staff_dim 
	on main_data_warehouse.reservation_fact(employee_key);
	
create index IF NOT EXISTS index_date_dim 
	on main_data_warehouse.reservation_fact(date_key);
	
create index IF NOT EXISTS index_time_dim 
	on main_data_warehouse.reservation_fact(time_key);