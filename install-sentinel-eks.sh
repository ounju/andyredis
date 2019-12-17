echo 'redis install start'
helm install -f andyredissentinel-values.yaml --name andyredis stable/redis > andyredis.log
echo 'redis install OK'
#helm install andyredisexporter stable/prometheus-redis-exporter --set redisAddress=redis://andyredis-master.default.svc.cluster.local:6379 --set serviceMonitor.enabled=false > andyredisexporter.log
#echo 'andyredisexporter install OK'
helm install -f andyprometheus-values.yaml --name andyprometheus stable/prometheus > andyprometheus.log
echo 'prometheus install OK'
helm install -f andygrafana-values.yaml --name andygrafana stable/grafana > andygrafana.log
echo 'grafana install OK'
echo 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
echo 'helm list'
helm list
echo 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
while [ true ]
do
  echo 'kubectl get po'
  kubectl get po
  linecount=$(kubectl get po | grep andy | grep Running | wc -l)
  echo 'linecount : ' $linecount
  echo 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
  if [ $linecount -eq 11 ]
  then
    break
  fi
  sleep 5
done
export POD_NAME=$(kubectl get pods --namespace default -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
env | grep POD_NAME
#kubectl --namespace default port-forward $POD_NAME 9090
echo 'http://localhost:9090/'
#curl http://localhost:9090/
echo grafana password :
kubectl get secret --namespace default andygrafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
export POD_NAME_GRAFANA=$(kubectl get pods --namespace default -l "app=grafana,release=andygrafana" -o jsonpath="{.items[0].metadata.name}")
env | grep POD_NAME_GRAFANA
#kubectl --namespace default port-forward $POD_NAME_GRAFANA 3000
echo 'http://localhost:3000/'
#curl http://localhost:3000/
echo 'data source : '
echo 'http://andyprometheus-server.default.svc.cluster.local'
#export POD_NAME_REDIS_EXPORTER=$(kubectl get pods --namespace default -l "app=prometheus-redis-exporter,release=andyredisexporter" -o jsonpath="{.items[0].metadata.name}")
#env | grep POD_NAME_REDIS_EXPORTER
#kubectl port-forward $POD_NAME_REDIS_EXPORTER 9121
#echo 'http://localhost:9121/'
#curl http://localhost:9121/
export REDIS_PASSWORD=$(kubectl get secret --namespace default andyredis -o jsonpath="{.data.redis-password}" | base64 --decode)
env | grep REDIS_PASSWORD
export REDISCLI_AUTH=$(kubectl get secret --namespace default andyredis -o jsonpath="{.data.redis-password}" | base64 --decode)
env | grep REDISCLI_AUTH
echo 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
redis-cli set aaa 1111111111111111
#redis-cli -r 10000 -i 1 get aaa
redis-cli get aaa
