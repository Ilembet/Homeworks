-- Проверка: все запросы идут на роутер, он сам раскладывает данные по шардам.

INSERT INTO stores (store_id, name, city, address) VALUES
  (1, 'Книжный на Абая',      'Шымкент', 'пр. Абая, 10'),
  (2, 'Книжный центр',        'Алматы',  'ул. Толе би, 25');

INSERT INTO books (book_id, title, author, isbn, price, store_id) VALUES
  (1, 'Мастер и Маргарита',   'Михаил Булгаков',  '978-5-17-090334-4', 4500.00, 1),
  (2, 'Путь Абая',            'Мухтар Ауэзов',    '978-601-03-0001-1', 5200.00, 1),
  (3, 'Чистый код',           'Роберт Мартин',    '978-5-4461-0960-9', 9800.00, 2);

INSERT INTO users (user_id, name, email, city) VALUES
  (1, 'Айгерим Сапарова',  'aigerim@example.com', 'Шымкент'),
  (2, 'Иван Петров',       'ivan@example.com',    'Алматы'),
  (3, 'Данияр Касымов',    'daniyar@example.com', 'Астана'),
  (4, 'Ольга Смирнова',    'olga@example.com',    'Шымкент'),
  (5, 'Ерлан Ахметов',     'erlan@example.com',   'Тараз'),
  (6, 'Мария Ким',         'maria@example.com',   'Алматы');

-- На какой шард попал каждый пользователь
SELECT tableoid::regclass AS shard, user_id, name, city
FROM users
ORDER BY user_id;

-- Сколько пользователей на каждом шарде
SELECT tableoid::regclass AS shard, count(*) AS users_count
FROM users
GROUP BY shard;

-- Запрос к одному пользователю идёт только на его шард (в плане один Foreign Scan)
EXPLAIN (COSTS OFF) SELECT * FROM users WHERE user_id = 4;

-- Соединение таблиц с разных серверов: книги с магазинами
SELECT b.title, b.author, b.price, s.name AS store, s.city
FROM books b
JOIN stores s ON s.store_id = b.store_id
ORDER BY b.book_id;
