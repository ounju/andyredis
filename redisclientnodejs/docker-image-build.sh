#docker build -t docker-registry.devops.svc.cluster.local:5000/redistest .
#nohup kubectl port-forward service/docker-registry 5000:5000 -n devops &
#docker image push docker-registry.devops.svc.cluster.local:5000/redistest
# sudo vi /etc/hosts
# 127.0.0.1    docker-registry.devops.svc.cluster.local
docker build -t ounju/redistest .
docker image push ounju/redistest
