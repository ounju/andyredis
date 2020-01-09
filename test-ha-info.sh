export REDISCLI_AUTH=redispassword
export REDIS_CLB="ab13f2381302911ea8cdd0a42cce4d45-1012291763.ap-northeast-2.elb.amazonaws.com"
echo "^^^^^^^^^^^^^^^^^ master 6379 port ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
# test-ha-info-master.log
redis-cli -h $REDIS_CLB -p 6379 info > test-ha-info-master.log
echo "^^^^^^^^^^^^^^^^^ replica 6380 port ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
# test-ha-info-slave.log
redis-cli -h $REDIS_CLB -p 6380 info > test-ha-info-slave.log
echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
