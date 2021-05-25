# ex42-intern-test
Был создан Dockerfile с установкой Redmine с нуля.
Собрать можно следующим образом из папки task-01:
```
docker build . -t redmine
```
Запустить можно следующей командой:
```
docker run --rm -p 80:80 redmine
```
Для проверки перейти на http://localhost, дефолтные логин и пароль - admin/admin

Второй задачей было разбить установку на три контейнера - БД, сервер приложений (Redmine+puma), фронтенд (nginx) при помощи приложения Docker-compose.
Запустить и проверить можно из папки task-02:
```
docker-compose up --build
```
Для проверки перейти на http://localhost, дефолтные логин и пароль - admin/admin

Был подключен Travis CI для сборки docker образа Redmine, его тестирования и публикации на docker hub.
Образ на Docker hub [тут](https://hub.docker.com/repository/docker/igortirador/redmine).
Также был использован alpine для уменьшения образа.
Билд лог прикладываю [тут](https://travis-ci.com/github/IgorTirador/ex42-intern-test/builds)
