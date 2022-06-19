# Подключение к ВМ за бастионом

## Подключение к someinternalhost одной командой 

### Вариант №1: Можно указывать все необходимые параметры при каждом подключении:

`ssh -i ~/.ssh/appuser <internal-host> -o "ProxyCommand ssh appuser@<bastion> -W %h:%p"`

-W Requests that standard input and output on the client be forwarded to host on port over the secure channel. -o Can be used to give options in the format used in the configuration file. -i Selects a file from which the identity (private key) for public key authentication is read.


### Вариант №2: Добавить информацию о бастионе и внутреннем узле в ~/.ssh/config:

Для начала оформим **ssh-config**

`touch ~/.ssh/config`

`chmod 600 ~/.ssh/config`

В **~/.ssh/config** вносим:

 `Host %bastion_name%`

&nbsp;&nbsp;&nbsp;&nbsp; `Hostname %hostname or address%`

&nbsp;&nbsp;&nbsp;&nbsp; `User %user%`

&nbsp;&nbsp;&nbsp;&nbsp; `IdentityFile %identity_file%`

Проверяем подключение к бастиону по желанию

`ssh bastion_name`

Если все хорошо - дальше подключаемся к машине за бастионом, для этого редактируем **ssh-config**

`Host %behind_bastion_name%`

 &nbsp;&nbsp;&nbsp;&nbsp;`Hostname %behind_bastion_hostname%`
  
  &nbsp;&nbsp;&nbsp;&nbsp;`User %behind_bastion_user%`
  
 &nbsp;&nbsp;&nbsp;&nbsp;`ProxyCommand ssh -W %h:%p %bastion_name%`
  
 &nbsp;&nbsp;&nbsp;&nbsp;`IdentityFile %identity file behind_bastion машины%`
 
 Можно использовать один ключ на несколько машин, а можно свой на каждую
 
 Проверяем `ssh behind_bastion_name`
 
 Далее в настройках подключения к bastion_name – добавляем **ControlMaster**, **ControlPath** и **ControlPersist**:
 
  `ControlPath ~/.ssh/cm-%r@%h:%p`
  `ControlMaster auto`
  `ControlPersist 1m`
  Кратко – ControlMaster указывает ssh использовать уже имеющееся TCP соединение, если оно есть. ControlPath – путь к файлу сокета, а ControlPersist – поддерживать вторую открытую сессию, даже если первая сессия уже завершена.

  



