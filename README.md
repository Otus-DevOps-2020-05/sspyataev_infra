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

testapp_IP = 130.193.39.248
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
