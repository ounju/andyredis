echo "kubectl run andy-redis-test3 --rm -it --restart='Never' --image andy/redistest -- bash"
#kubectl run andy-redis-test --rm -it --restart='Never' --image docker-registry.devops.svc.cluster.local:5000/redistest -- bash
#kubectl run andy-redis-test --rm -it --restart='Never' --image node:10 -- bash
kubectl run andy-redis-test3 --rm -it --restart='Never' --image ounju/redistest -- bash
