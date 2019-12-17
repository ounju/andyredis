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
#### slave는 내려가도 서비스 영향도 없음
#### 서버 1대(master 1) 내리면 서비스 정상화 까지 1분정도 걸림
#### 서버 2대(master 1, slave 1) 동시에 내리면 서비스 정상화 까지 3분정도 걸림
#### 서버 3대(master 1, slave 2) 동시에 내리면 서비스 정상화 까지 2분 40초정도 걸림
#### 서버 4대(master 1, slave 3) 동시에 내리면 서비스 정상화 까지 30초정도 걸림
#### 성능 테스트 SET은 26000 TPS, GET은 37000 TPS 정도의 성능을 보임
```text
내부 IP 사용
Number of parallel connections (default 50)
Total number of requests (default 100000)
Data size of SET/GET value in bytes (default 2)
Use random keys for SET/GET/INCR, random values for SADD
  Using this option the benchmark will expand the string __rand_int__
  inside an argument with a 12 digits number in the specified range
  from 0 to keyspacelen-1. The substitution changes every time a command
  is executed. Default tests use this to hit random keys in the
  specified range.

$ redis-benchmark -h 10.101.28.122 -p 6379 -e -q -a redispassword
PING_INLINE: 38358.27 requests per second
PING_BULK: 34686.09 requests per second
SET: 26816.84 requests per second
GET: 37160.91 requests per second
INCR: 26795.28 requests per second
LPUSH: 26364.36 requests per second
RPUSH: 25169.90 requests per second
LPOP: 27322.40 requests per second
RPOP: 27307.48 requests per second
SADD: 33967.39 requests per second
SPOP: 36603.22 requests per second
LPUSH (needed to benchmark LRANGE): 26068.82 requests per second
LRANGE_100 (first 100 elements): 20458.27 requests per second
LRANGE_300 (first 300 elements): 9421.52 requests per second
LRANGE_500 (first 450 elements): 6891.80 requests per second
LRANGE_600 (first 600 elements): 5584.72 requests per second
MSET (10 keys): 16268.10 requests per second
```

