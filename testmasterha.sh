redis-cli -h 127.0.0.1 -p 6379 -a redishapassword set aaa 111
#redis-cli -h 127.0.0.1 -p 6379 -a redishapassword get aaa
#while [ true ]
#do
#  redis-cli -p 6379 get aaa
#  echo `date`
#  sleep 1
#done
