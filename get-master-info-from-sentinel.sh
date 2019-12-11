export REDISCLI_AUTH=$(kubectl get secret --namespace default andyredis -o jsonpath="{.data.redis-password}" | base64 --decode)
while [ true ]
do
  redis-cli -p 26379 SENTINEL get-master-addr-by-name mymaster
  sleep 1
done

#센티넬에 접속해서 마스터 서버 아이피를 조회하는 명령어
#values.yaml 파일 > sentinel > masterSet 에 설정된 이름 확인
#redis-cli -h 10.1.1.150 -p 26379 -a $REDIS_PASSWORD SENTINEL get-master-addr-by-name mymaster
#1) "10.1.1.148"
#2) "6379"
