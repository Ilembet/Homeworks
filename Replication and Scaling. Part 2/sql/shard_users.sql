-- Шард пользователей (выполняется на pg-users-1 и pg-users-2).
-- На обоих шардах таблица одинаковая, отличаются только строки:
-- какая строка куда попадёт, решает роутер по hash(user_id).
CREATE TABLE users (
    user_id    BIGINT       PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    email      VARCHAR(150) NOT NULL UNIQUE,
    city       VARCHAR(100),
    created_at TIMESTAMP    NOT NULL DEFAULT now()
);
