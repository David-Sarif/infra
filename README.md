Подключение к ВМ за бастионом

Для начала оформим ssh-config

`touch ~/.ssh/config`

`chmod 600 ~/.ssh/config`

В ~/.ssh/config вносим:

1 Host %имя хоста%

&nbsp;&nbsp;&nbsp;&nbsp;2 Hostname %адрес%

&nbsp;&nbsp;&nbsp;&nbsp;3 User %user%

&nbsp;&nbsp;&nbsp;&nbsp;4 IdentityFile %identity_file%
