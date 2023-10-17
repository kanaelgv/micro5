#выбираем образ для сборки java
FROM openjdk:8-alpine as build

#выбираем рабочую папку внутри контейнера
WORKDIR /usr/src/app

#копируем файлы с проектом в контейнер
COPY . .

#устанавливаем заивисмоти и собираем java
RUN chmod 777 mvnw && \
./mvnw dependency:resolve && \
./mvnw install

#открываем порт
EXPOSE 8083

#выбираем образ для запуска java
FROM openjdk:8-alpine 

#выбираем рабочую папку внутри контейнера
WORKDIR /app

#копируем результат сборки
COPY --from=build /usr/src/app/target/users-api*.jar /app/users-api.jar

#запускаем 
CMD ["java", "-jar", "/app/users-api.jar"]
