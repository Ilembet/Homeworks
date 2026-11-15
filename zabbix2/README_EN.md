# Homework: Zabbix Monitoring System. Part 2 — Ilembetov Vasil Razhapovich

[Русская версия](README.md)

## Objectives

- create custom templates in Zabbix, add hosts and link the template to them;
- build a custom dashboard;
- create a UserParameter in Bash;
- create a Python script, add a UserParameter for it and attach it to a template;
- write Vagrant scripts for Zabbix Agent.

---

## Task 1

![Task 1](img/%D0%97%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5%201.png)

---

## Tasks 2–3

![Tasks 2–3](img/%D0%97%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5%202-3.png)

---

## Task 4

![Task 4](img/%D0%97%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5%204.png)

---

## Task 5

![Task 5](img/%D0%B7%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5%205.png)

---

## Task 6. UserParameter in Bash

The script returns the full name for parameter `1` and the current date for parameter `2`:

```bash
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

![Task 6](img/%D0%B7%D0%B0%D0%B4%D0%B0%D1%87%D0%B0%206.png)

---

## Task 7. Python script and UserParameter

The script from the lecture is extended with parameters `1` (full name) and `2` (current date): [my_script.py](my_script.py).

![Task 7](img/%D0%97%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5%207.png)

---

## Task 8

![Task 8](img/%D0%97%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5%208.png)

![Task 8](img/%D0%B7%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5%208-1.png)

---

## Task 9. Vagrant

[Vagrantfile](Vagrantfile) brings up two VMs with Zabbix Agent: it installs the agent, configures `zabbix_agentd.conf`, copies the Python script and adds the `my.script[*]` UserParameter.
