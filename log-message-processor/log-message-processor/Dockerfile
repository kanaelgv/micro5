#выбираем начальный образ для сборки
FROM python:3.6-alpine

#выбираем рабочую папку внутри контейнера
WORKDIR /usr/src/app

#устанавливаем запчасти для alpine
RUN apk add --no-cache build-base

#копируем файл с зависимостями
COPY requirements.txt .

#ставим зависимости
RUN pip3 install -r requirements.txt

#копируем файл
COPY main.py .

#запускаем файл
CMD ["python3","-u","main.py"]

