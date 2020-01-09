#!/bin/bash
export REDISCLI_AUTH=redispassword
export REDIS_CLB="redis-dev.opsnow.io"
#export REDIS_CLB="dualstack.a61e7701f31d211eaafbb0692fc9e81b-2131643653.ap-northeast-2.elb.amazonaws.com"
while [ true ]
do
  printf "`date` ^^^^^ `redis-cli -h $REDIS_CLB -p 6379 set ddd 777777778888888`\n"
  printf "`date` ^^^^^ `redis-cli -h $REDIS_CLB -p 6379 get ddd`\n"
  sleep 1
done
