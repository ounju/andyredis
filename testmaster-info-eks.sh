export REDISCLI_AUTH=$(kubectl get secret --namespace default andyredis -o jsonpath="{.data.redis-password}" | base64 --decode)
env | grep REDISCLI_AUTH
while [ true ]
do
  redis-cli -h a9c51f164208f11ea906b06b9971f375-1360734662.ap-northeast-2.elb.amazonaws.com -p 6379 info
  echo 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
  sleep 10
done
