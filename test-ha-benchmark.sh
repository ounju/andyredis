export REDISCLI_AUTH=redispassword
echo "^^^^^^^^^^^^^^^^^ master 6379 port ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
redis-benchmark -h ae05ebb89278211eaa36b064838137cd-1539341590.ap-northeast-2.elb.amazonaws.com -p 6379  -e -q -a redispassword
echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
