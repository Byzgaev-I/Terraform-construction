# Домашнее задание "`«Управляющие конструкции в коде Terraform»`"   

---

### Задание 1

1) Изучите проект.
2) Заполните файл personal.auto.tfvars.
3) Инициализируйте проект, выполните код. Он выполнится, даже если доступа к preview нет.

Приложите скриншот входящих правил «Группы безопасности» в ЛК Yandex Cloud или скриншот отказа в предоставлении доступа к preview-версии.

### Выполнения задания 1

Изучил проект, заполнил personal.auto.tfvars, выполнил: 
 ```sh

terraform plan 
terraform apply 

```
 В результате в YC создана группа сеть develop с подсетью develop и группой безопасности example_dynamic:

 ![image.jpg](https://github.com/Byzgaev-I/Terraform-construction/blob/main/1.png) 
