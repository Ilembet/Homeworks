# Домашнее задание к занятию "`Система мониторинга Zabbix. Часть 2`" - `Илембетов Василь`

---

### Задание 1

```


```
Скриншот-1 к заданию 1:
![Скриншот-1](https://github.com/Ilembet/Zabbix/blob/85017bbada8bf832398ad9862128343f367d6a34/zabbix2/img/%D0%97%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5%201.png)


---


### Задание 2-3

```


```

Скриншот-2 к заданию 2-3:
![Скриншот-1](https://github.com/Ilembet/Zabbix/blob/00d94fb7408b48e61c7d51552a6618fc1252ee24/zabbix2/img/%D0%97%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5%202-3.png)

---

### Задание 4

```
```

Скриншот-3 к заданию 4:
![Скриншот-1](https://github.com/Ilembet/Zabbix/blob/00d94fb7408b48e61c7d51552a6618fc1252ee24/zabbix2/img/%D0%97%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5%204.png)


---

### Задание 5

```
```
Скриншот-4 к заданию 5:
![Скриншот-1](https://github.com/Ilembet/Zabbix/blob/00d94fb7408b48e61c7d51552a6618fc1252ee24/zabbix2/img/%D0%B7%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5%205.png)


---

### Задание 6

```
Код скрипта:


#!/bin/bash
case $1 in
    1)
        echo "Ваши ФИО"
        ;;
    2)
        date '+%Y-%m-%d %H:%M:%S'
        ;;
    *)
        echo "Неверный параметр. Используйте 1 или 2."
        ;;
esac


```

Скриншот-5 к заданию 6:
![Скриншот-1](https://github.com/Ilembet/Zabbix/blob/00d94fb7408b48e61c7d51552a6618fc1252ee24/zabbix2/img/%D0%B7%D0%B0%D0%B4%D0%B0%D1%87%D0%B0%206.png)


---

### Задание 7

```
Скрипт my_script.py

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

```

Скриншот-6 к заданию 7:
![Скриншот-1](https://github.com/Ilembet/Zabbix/blob/00d94fb7408b48e61c7d51552a6618fc1252ee24/zabbix2/img/%D0%97%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5%207.png)


---

### Задание 8

```


```

Скриншот-7 к заданию 8:
![Скриншот-1](https://github.com/Ilembet/Zabbix/blob/b4e30d998cf630cb93da737520d54471104352ac/zabbix2/img/%D0%97%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5%208.png)

Скриншот-8 к заданию 8:
![Скриншот-1](https://github.com/Ilembet/Zabbix/blob/00d94fb7408b48e61c7d51552a6618fc1252ee24/zabbix2/img/%D0%B7%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5%208-1.png)


---

### Задание 9

```
Приложил в файлы Vagrantfile

```

![Файл-1](https://github.com/Ilembet/Zabbix/blob/6da8a594d621e92573280cca1bcfcbd1d7b5b25d/zabbix2/Vagrantfile)
