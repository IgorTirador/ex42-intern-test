# ex42-intern-test
Был создан Docker с установкой с нуля Redmine
Собрать можно следующим образом из папки task-01:
```
docker build . -t redmine
```
Запустить
```
docker run --d  -rm -p 80:80 redmine
```
Второй задачей было разбить установку на три контейнера - БД, сервер приложений (Redmine+puma), фронтенд (nginx) при помощи приложен Docker-compose
Запустить и проверить можно из папки task-02
```
docker-compose up
```

Был был подключен Travis CI для сборки docker образа Redmine, его тестирования и публикации на docker hub.
Образ на Docker hub [тут](https://hub.docker.com/repository/docker/igortirador/redmine)  
Также был использован alphine для уменьшения образа
Билд лог прикладываю [тут](https://travis-ci.com/github/IgorTirador/ex42-intern-test/jobs/507863619)
