while [ true ]
do
  echo "`date` ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
  //redis-cli -p 26379 -h andyredis -a redispassword SENTINEL get-master-addr-by-name mymaster
  node test.js
  sleep 1
done
