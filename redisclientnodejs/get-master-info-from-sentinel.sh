while [ true ]
do
  echo "`date` ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
  redis-cli -p 26379 -h andyredis -a redispassword SENTINEL get-master-addr-by-name mymaster
  sleep 1
done
