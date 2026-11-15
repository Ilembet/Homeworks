-- Сервер книг (pg-books): вертикальный шард, только таблица books.
CREATE TABLE books (
    book_id  BIGINT        PRIMARY KEY,
    title    VARCHAR(200)  NOT NULL,
    author   VARCHAR(150)  NOT NULL,
    isbn     VARCHAR(20)   UNIQUE,
    price    NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    store_id BIGINT        NOT NULL   -- ссылка на stores на другом сервере, FK между серверами невозможен
);
CREATE INDEX idx_books_store_id ON books (store_id);
