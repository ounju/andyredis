FROM node:10
WORKDIR /usr/src/app
COPY . .
RUN apt update; apt install vim -y; apt install redis-tools -y; npm install ioredis
EXPOSE 3000
#ENTRYPOINT [ "/usr/local/bin/node", "redisweb.js" ]
