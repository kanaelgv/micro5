FROM golang:1.9-alpine

RUN apk --no-cache add curl git && \
curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
WORKDIR /go/src/app

COPY . . 
RUN dep ensure && \
go build -o auth-api

EXPOSE 8081

CMD /go/src/app/auth-api
