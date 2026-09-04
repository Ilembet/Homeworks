#!/usr/bin/env python3
import sys
import os
import re
import datetime

def main():
    # Проверяем, что передан хотя бы один аргумент
    if len(sys.argv) < 2:
        print("Использование: script.py [1|2|-ping <адрес>|-simple print <текст>]")
        return

    param = sys.argv[1]

    # === НОВАЯ ФУНКЦИОНАЛЬНОСТЬ (из задания) ===
    if param == "1":
        # Возвращаем ФИО
        print("Ваши ФИО")
        return

    elif param == "2":
        # Возвращаем текущую дату
        print(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'))
        return

    # === СТАРАЯ ФУНКЦИОНАЛЬНОСТЬ (из лекции) ===
    elif param == "-ping":
        # Проверяем, что передан адрес для ping
        if len(sys.argv) < 3:
            print("Ошибка: не указан адрес для ping")
            return

        # Выполняем ping
        result = os.popen("ping -c 1 " + sys.argv[2]).read()
        # Ищем время ответа
        result = re.findall(r"time=(.*) ms", result)

        if result:
            print(result[0])  # Выводим время ответа
        else:
            print("Ping не удался или время не найдено")

    elif param == "-simple":
        # Проверяем, что передан текст для вывода
        if len(sys.argv) < 4 or sys.argv[2] != "print":
            print("Ошибка: используйте -simple print <текст>")
            return

        # Выводим переданный текст
        print(sys.argv[3])

    else:
        # Неизвестная команда
        print(f"unknown input: {param}")

if __name__ == "__main__":
    main()