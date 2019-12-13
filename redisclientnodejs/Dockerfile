FROM node:10
WORKDIR /usr/src/app
RUN apt update; apt install vim -y; apt install redis-tools -y; npm install ioredis; alias ll="ls -al"
COPY . .
EXPOSE 3000
CMD [ "node", "redisweb.js" ]
