export REDISCLI_AUTH=$(kubectl get secret --namespace default andyredis -o jsonpath="{.data.redis-password}" | base64 --decode)
while [ true ]
do
  printf "`date` ^^ `redis-cli -p 6380 set bbb 333333333`\n"
  sleep 1
  printf "`date` ^^ `redis-cli -p 6380 get bbb`\n"
  sleep 1
done
