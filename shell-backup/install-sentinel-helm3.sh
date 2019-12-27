echo 'redis install start'
helm install -f andyredissentinel-values.yaml andyredis stable/redis > andyredis.log
echo 'redis install OK'
echo 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
echo 'helm list'
helm list
echo 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
while [ true ]
do
  echo 'kubectl get po'
  kubectl get po
  linecount=$(kubectl get po | grep Running | wc -l)
  echo 'linecount : ' $linecount
  echo 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
  if [ $linecount -eq 4 ]
  then
    break
  fi
  sleep 5
done
export POD_NAME=$(kubectl get pods --namespace default -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
env | grep POD_NAME
echo 'http://localhost:9090/'
echo grafana password :
kubectl get secret --namespace default andygrafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
export POD_NAME_GRAFANA=$(kubectl get pods --namespace default -l "app=grafana,release=andygrafana" -o jsonpath="{.items[0].metadata.name}")
env | grep POD_NAME_GRAFANA
echo 'http://localhost:3000/'
echo 'data source : '
echo 'http://andyprometheus-server.default.svc.cluster.local'
export REDIS_PASSWORD=$(kubectl get secret --namespace default andyredis -o jsonpath="{.data.redis-password}" | base64 --decode)
env | grep REDIS_PASSWORD
export REDISCLI_AUTH=$(kubectl get secret --namespace default andyredis -o jsonpath="{.data.redis-password}" | base64 --decode)
env | grep REDISCLI_AUTH
echo 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
redis-cli set aaa 1111111111111111
#redis-cli -r 10000 -i 1 get aaa
redis-cli get aaa
