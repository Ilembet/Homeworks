-- Роутер (pg-router): единая точка входа для приложения.
-- Своих данных не хранит: все таблицы ссылаются на шарды через postgres_fdw.
CREATE EXTENSION postgres_fdw;

-- Подключения к шардам
CREATE SERVER users_shard_1 FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host 'pg-users-1', port '5432', dbname 'shop');
CREATE SERVER users_shard_2 FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host 'pg-users-2', port '5432', dbname 'shop');
CREATE SERVER books_server  FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host 'pg-books',   port '5432', dbname 'shop');
CREATE SERVER stores_server FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host 'pg-stores',  port '5432', dbname 'shop');

CREATE USER MAPPING FOR postgres SERVER users_shard_1 OPTIONS (user 'postgres', password 'postgres');
CREATE USER MAPPING FOR postgres SERVER users_shard_2 OPTIONS (user 'postgres', password 'postgres');
CREATE USER MAPPING FOR postgres SERVER books_server  OPTIONS (user 'postgres', password 'postgres');
CREATE USER MAPPING FOR postgres SERVER stores_server OPTIONS (user 'postgres', password 'postgres');

-- Горизонтальный шардинг: users делится по hash(user_id) на два шарда
CREATE TABLE users (
    user_id    BIGINT       NOT NULL,
    name       VARCHAR(100) NOT NULL,
    email      VARCHAR(150) NOT NULL,
    city       VARCHAR(100),
    created_at TIMESTAMP    NOT NULL DEFAULT now()
) PARTITION BY HASH (user_id);

CREATE FOREIGN TABLE users_shard_1
    PARTITION OF users FOR VALUES WITH (MODULUS 2, REMAINDER 0)
    SERVER users_shard_1 OPTIONS (schema_name 'public', table_name 'users');

CREATE FOREIGN TABLE users_shard_2
    PARTITION OF users FOR VALUES WITH (MODULUS 2, REMAINDER 1)
    SERVER users_shard_2 OPTIONS (schema_name 'public', table_name 'users');

-- Вертикальный шардинг: books и stores целиком лежат на своих серверах
CREATE FOREIGN TABLE books (
    book_id  BIGINT        NOT NULL,
    title    VARCHAR(200)  NOT NULL,
    author   VARCHAR(150)  NOT NULL,
    isbn     VARCHAR(20),
    price    NUMERIC(10,2) NOT NULL,
    store_id BIGINT        NOT NULL
) SERVER books_server OPTIONS (schema_name 'public', table_name 'books');

CREATE FOREIGN TABLE stores (
    store_id BIGINT       NOT NULL,
    name     VARCHAR(150) NOT NULL,
    city     VARCHAR(100) NOT NULL,
    address  VARCHAR(200) NOT NULL
) SERVER stores_server OPTIONS (schema_name 'public', table_name 'stores');
