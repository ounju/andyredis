export REDISCLI_AUTH=$(kubectl get secret --namespace default andyredis -o jsonpath="{.data.redis-password}" | base64 --decode)
while [ true ]
do
  redis-cli -p 6380 get aaa
  echo `date`
  sleep 1
done
