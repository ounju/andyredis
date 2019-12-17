export REDISCLI_AUTH=$(kubectl get secret --namespace default andyredis -o jsonpath="{.data.redis-password}" | base64 --decode)
while [ true ]
do
  printf "`date` ^^ `redis-cli -h a9c51f164208f11ea906b06b9971f375-1360734662.ap-northeast-2.elb.amazonaws.com -p 6379 set bbb 2222222`\n"
  sleep 1
  printf "`date` ^^ `redis-cli -h a9c51f164208f11ea906b06b9971f375-1360734662.ap-northeast-2.elb.amazonaws.com -p 6379 get bbb`\n"
  sleep 1
done
