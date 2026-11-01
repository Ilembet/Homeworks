-- Домашнее задание 12-1. Модель данных по отчёту заказчика (hw-12-1.xlsx)
-- СУБД: PostgreSQL

-- 1. Регионы (из колонки «Адрес филиала»)
CREATE TABLE regions (
    region_id   SERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL UNIQUE
);

-- 2. Города, каждый город относится к одному региону
CREATE TABLE cities (
    city_id     SERIAL PRIMARY KEY,
    region_id   INTEGER      NOT NULL REFERENCES regions (region_id),
    name        VARCHAR(100) NOT NULL,
    UNIQUE (region_id, name)
);

-- 3. Филиалы: адрес без региона и города, они берутся через city_id
CREATE TABLE branches (
    branch_id   SERIAL PRIMARY KEY,
    city_id     INTEGER      NOT NULL REFERENCES cities (city_id),
    street      VARCHAR(150) NOT NULL,
    house       VARCHAR(20)  NOT NULL          -- текст, т.к. бывает «135/2»
);

-- 4. Типы подразделений: Отдел, Группа, Департамент
CREATE TABLE department_types (
    type_id     SERIAL PRIMARY KEY,
    name        VARCHAR(50)  NOT NULL UNIQUE
);

-- 5. Структурные подразделения
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    type_id       INTEGER      NOT NULL REFERENCES department_types (type_id),
    name          VARCHAR(150) NOT NULL UNIQUE
);

-- 6. Должности
CREATE TABLE positions (
    position_id SERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL UNIQUE
);

-- 7. Сотрудники
CREATE TABLE employees (
    employee_id   SERIAL PRIMARY KEY,
    last_name     VARCHAR(50)    NOT NULL,
    first_name    VARCHAR(50)    NOT NULL,
    middle_name   VARCHAR(50),                  -- отчества может не быть
    salary        NUMERIC(10, 2) NOT NULL CHECK (salary >= 0),
    hire_date     DATE           NOT NULL,
    position_id   INTEGER        NOT NULL REFERENCES positions (position_id),
    department_id INTEGER        NOT NULL REFERENCES departments (department_id),
    branch_id     INTEGER        NOT NULL REFERENCES branches (branch_id)
);

-- 8. Проекты
CREATE TABLE projects (
    project_id  SERIAL PRIMARY KEY,
    name        VARCHAR(150) NOT NULL UNIQUE
);

-- 9. Связь «многие ко многим»: сотрудник может работать на нескольких проектах,
--    на проекте может быть несколько сотрудников
CREATE TABLE employee_projects (
    employee_id INTEGER NOT NULL REFERENCES employees (employee_id),
    project_id  INTEGER NOT NULL REFERENCES projects (project_id),
    PRIMARY KEY (employee_id, project_id)
);
