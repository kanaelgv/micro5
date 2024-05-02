#выбираем начальный образ для сборки
FROM node:8-alpine as node

#выбираем рабочую папку внутри контейнера
WORKDIR /usr/src/app

#копируем список зависимостей
COPY package.json ./

#устанавливаем зависимости
RUN npm install

#копируем файлы с проектом в контейнер
COPY . .

#запускаем сборку
RUN ["sh", "-c", "npm run build" ]

################ second stage ################

#выбираем образ для запуска
FROM nginx

#копируем результат сборки
COPY --chown=1001:0 --from=node /usr/src/app/dist/ /usr/share/nginx/html/

#запускаем nginx
CMD ["/bin/sh" , "-c" , "nginx -g 'daemon off;'"]
