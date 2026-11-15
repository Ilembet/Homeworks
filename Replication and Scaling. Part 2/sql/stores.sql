-- Сервер магазинов (pg-stores): вертикальный шард, только таблица stores.
CREATE TABLE stores (
    store_id BIGINT       PRIMARY KEY,
    name     VARCHAR(150) NOT NULL,
    city     VARCHAR(100) NOT NULL,
    address  VARCHAR(200) NOT NULL
);
