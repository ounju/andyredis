docker build -t andy/redistest .

docker run --rm -it -p 3000:3000 andy/redistest /bin/bash
kubectl run nginx --image nginx --port=80
kubectl run --namespace default andyredistest --rm --tty -i --restart='Never' \
    --env REDIS_PASSWORD=$REDIS_PASSWORD --port=3000 --image andy/redistest -- bash

kubectl run --namespace default andyredistest --rm --tty -i --restart='Never' \
    --env REDIS_PASSWORD=$REDIS_PASSWORD \
   --image docker.io/bitnami/redis:5.0.7-debian-9-r12 -- bash

kubectl run --namespace default andyredistest --rm --tty -i --restart='Never' --port=3000 --image node:10 -- bash

npm install redis
apt update
apt install vim -y
npm install ioredis
apt install redis-tools -y
redis-cli -p 6379 -h andyredis -a redispassword info

## Sentinel 적용한 아키에서 Master 서버 장애 발생 시 정상화 때까지 1분 10초 정도 소요됨!!!

```text
Fri Dec 13 06:29:08 UTC 2019 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
1) "10.1.3.37"
2) "6379"
OK
4444444445555
Fri Dec 13 06:29:11 UTC 2019 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
1) "10.1.3.37"
2) "6379"
[ioredis] Unhandled error event: Error: connect ETIMEDOUT
    at Socket.<anonymous> (/usr/src/app/node_modules/ioredis/built/redis/index.js:282:31)
    at Object.onceWrapper (events.js:286:20)
    at Socket.emit (events.js:198:13)
    at Socket._onTimeout (net.js:443:8)
    at ontimeout (timers.js:436:11)
    at tryOnTimeout (timers.js:300:5)
    at listOnTimeout (timers.js:263:5)
    at Timer.processTimers (timers.js:223:10)
[ioredis] Unhandled error event: Error: connect EHOSTUNREACH 10.1.3.37:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (net.js:1107:14)
[ioredis] Unhandled error event: Error: connect EHOSTUNREACH 10.1.3.37:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (net.js:1107:14)
[ioredis] Unhandled error event: Error: connect EHOSTUNREACH 10.1.3.37:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (net.js:1107:14)
[ioredis] Unhandled error event: Error: connect EHOSTUNREACH 10.1.3.37:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (net.js:1107:14)
[ioredis] Unhandled error event: Error: connect EHOSTUNREACH 10.1.3.37:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (net.js:1107:14)
[ioredis] Unhandled error event: Error: connect EHOSTUNREACH 10.1.3.37:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (net.js:1107:14)
[ioredis] Unhandled error event: Error: connect EHOSTUNREACH 10.1.3.37:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (net.js:1107:14)
[ioredis] Unhandled error event: Error: connect EHOSTUNREACH 10.1.3.37:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (net.js:1107:14)
...
[ioredis] Unhandled error event: Error: connect EHOSTUNREACH 10.1.3.37:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (net.js:1107:14)
[ioredis] Unhandled error event: Error: connect EHOSTUNREACH 10.1.3.37:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (net.js:1107:14)
[ioredis] Unhandled error event: Error: connect EHOSTUNREACH 10.1.3.37:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (net.js:1107:14)
[ioredis] Unhandled error event: Error: connect EHOSTUNREACH 10.1.3.37:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (net.js:1107:14)
OK
4444444445555
Fri Dec 13 06:30:16 UTC 2019 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
1) "10.1.3.29"
2) "6379"
OK
4444444445555
```
