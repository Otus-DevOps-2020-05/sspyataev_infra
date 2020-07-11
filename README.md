# sspyataev_infra
sspyataev Infra repository

## ДЗ 5 урок

### Самостоятельное задание
>Исследовать способ подключения к someinternalhost в одну
>команду из вашего рабочего устройства, проверить
>работоспособность найденного решения и внести его в
>README.md в вашем репозитории

`ssh -i ~/.ssh/appuser -A -tt appuser@130.193.49.196 ssh 10.130.0.3`
или
`ssh -J appuser@130.193.49.196 appuser@10.130.0.3`

#### Дополнительное задание:
>Предложить вариант решения для подключения из консоли при
>помощи команды вида ssh someinternalhost из локальной
>консоли рабочего устройства, чтобы подключение выполнялось по
>алиасу someinternalhost и внести его в README.md в вашем
>репозитории

```sh
$ cat ~/.ssh/config
Host bastion
User appuser
Port 22
HostName 130.193.49.196

Host someinternalhost
User appuser
Port 22
HostName 10.130.0.3
ProxyJump bastion

ssh someinternalhost
```

### Задание
конфигурационный файл для подключения к VPN - cloud-bastion.ovpn

>Опишите в README.md и получившуюся конфигурацию и данные
>для подключения в следующем формате (важно для проверки!):

bastion_IP = 130.193.49.196
someinternalhost_IP = 10.130.0.3

## ДЗ 6 урок

testapp_IP = 84.201.175.91
testapp_port = 9292

#### Самостоятельная работа:
install_ruby.sh

install_mongodb.sh

deploy.sh

#### Дополнительное задание:
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=startup_script

## ДЗ 7 урок
Было сделано:
* Изучена документация и работа packer
* Написан ubuntu16.json для packer для создания образа ВМ.
* Написан variables.json, в который вынесена часть параметров из ubuntu16.json. При создании образа параметризированные значения считываются из файла.
* Написан immutable.json, который дополняет ubuntu16.json. В результате packer создаёт образ ВМ, после запуска которого приложение сразу доступно на http://<publicIp>:9292
* Написан скрипт create-reddit-vm.sh, который автоматизирует процесс создания ВМ с уже запущенным приложением reddit. Достаточно выполнить config-scripts/create-reddit-vm.sh и результат проверить на http://<publicIp>:9292

## ДЗ 8 урок
Было сделано:
* Изучена документация terraform для yandex provider
* Определаны input переменные для приватного ключа (connection_private_key_path), для задания зоны в resource с default значением (rzone)
* Отформатированы все файлы через `terraform fmt`
* Создан файл terraform.tfvars.example с примерами переменных
* Написан файл lb.tf для создания load balancer, через output переменные выведен ip адрес lb для подключения
* Дополнен main.tf для возможности создавать n аппов с приложение, через переменную app_count. Проверена работоспособность LB с несколькими аппами. Проверена работоспособность LB при выключении сервиса на одном из аппов.

## ДЗ 9 урок
Было сделано:
* Разбит main.tf сначала по отдельным файлам, а затем на модули
* Созданы prod и stage в проекте
* Проверена корректность конфигурации модулей для каждой среды
* В рамках самостоятельной работы почищена папка terraform, все файлы перенесены в prod и stage, параметризованы модули и отформатированы все файлы
* Создан Yandex Object Storage, в который вынесен terraform.tfstate
* Проверена корректная работа terraform со стейтом в YOS.
