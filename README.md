# andyredis
redis cluster on k8s

## Master 1대, Slaver 2대로 구성
install.sh

## Sentinel 구성
installsentinel.sh

## 참고) Sentinel 명령
```shell script
redis-cli -h 127.0.0.1 -p 26379 -a redispassword ROLE
# sentinel 서버에서 reids master 정보 조회
redis-cli -h localhost -p 30000 -a redispassword SENTINEL get-master-addr-by-name mymaster
```
```text
센티널 명령은 사용자가 사용할 수도 있지만, 많은 명령이 센티널 내부적으로 사용된다.
Sentinel Data Structure : 센티널 Data Structure 설명
INFO SENTINEL : 센티널에 대한 전반적인 정보를 조회한다.
ROLE : 마스터들의 이름을 조회한다.
SENTINEL MASTERS : 마스터들의 자세한 상태 정보를 조회한다.
SENTINEL MASTER : 지정한 마스터의 자세한 상태 정보를 조회한다.
SENTINEL SLAVES : 슬레이브의 상태 정보를 조회한다.
SENTINEL REPLICAS : 복제노드의 상태 정보를 조회한다.
SENTINEL SENTINELS : 센티널의 상태 정보를 조회한다.
SENTINEL RESET : 지정한 마스터의 상태 정보를 초기화(RESET)한다.
위에서 설명한 INFO 명령에서 다운된 복제 개수도 포한되는데, 제거할 때 이명령을 사용한다.   RESET 명령 사용 직후에는 0이 되는데 곧 정상 정보로 채워진다.
SENTINEL MONITOR : 지정한 마스터에 대한 모니터링을 시작한다.
SENTINEL REMOVE : 지정한 마스터를 모니터링 대상에서 제거한다.   더 이상 모니터링하지 않는다.
SENTINEL FAILOVER : 명령으로 강제 장애조치를 진행한다.
SENTINEL CKQUORUM : 쿼럼값이 올바른지 체크한다.
SENTINEL SIMULATE-FAILURE : 장애조치 중간에 리더를 다운시키는 시뮬레이션을 설정한다.
SENTINEL SET : 센티널 설정값을 변경한다.
SENTINEL FLUSHCONFIG : 센티널 설정(configuration)파일을 다시 쓴다.
SENTINEL INFO-CACHE : INFO 명령으로 가져온 정보를 저장한다.
SENTINEL PENDING-SCRIPTS : 현재 대기 또는 실행중인 스크립트 정보를 조회한다.
SENTINEL NOTIFICATION : 알림기능에 대한 설명.
SENTINEL ELECTION : 센티널 리더를 선출하는 방법과 장애조치 설명
```


```shell script
cd /Users/ounju-kim/valve-eks/example/eks-fast-track
terraform init
terraform plan
terraform apply
```

```text

Apply complete! Resources: 57 added, 0 changed, 0 destroyed.

Outputs:

account_id = 759871273906
caller_arn = arn:aws:iam::759871273906:user/ounju.kim
caller_user = AIDA3B263POZESW27THNY
config = #

# kube config
aws eks update-kubeconfig --name seoul-sre-andy-eks --alias seoul-sre-andy-eks

# or
mkdir -p ~/.kube && cp .output/kube_config.yaml ~/.kube/config

# files
cat .output/aws_auth.yaml
cat .output/kube_config.yaml

# get
kubectl get node -o wide
kubectl get all --all-namespaces

#

efs_id = 
terraform import module.efs.aws_efs_file_system.efs fs-7e3a781f

efs_mount_target_ids = 
terraform import 'module.efs.aws_efs_mount_target.efs[0]' fsmt-d9b013b8
terraform import 'module.efs.aws_efs_mount_target.efs[*]' fsmt-d4b013b5
terraform import 'module.efs.aws_efs_mount_target.efs[*]' fsmt-d7b013b6

import_command-1 = 
terraform import -var-file=YOUR module.eks-domain.aws_route53_record.validation Z1PY2EID2YMYG4__13ee5909fa252a2f26d196cc3c1814a4.andy.opsnow.io._CNAME

nat_ip = [
  "15.165.133.46",
]
private_subnet_cidr = [
  "10.107.88.0/24",
  "10.107.89.0/24",
  "10.107.80.0/24",
]
private_subnet_ids = [
  "subnet-0d6d77906d3381924",
  "subnet-0bfc5b1552996c7f8",
  "subnet-092cc85a06ec6f17a",
]
public_subnet_cidr = [
  "10.107.85.0/24",
  "10.107.86.0/24",
  "10.107.87.0/24",
]
public_subnet_ids = [
  "subnet-0a6ce764471b78881",
  "subnet-0996a464409054067",
  "subnet-0daae417f2cb31ac9",
]
record_set = *.andy.opsnow.io
sg-node = node security group id : sg-0ef18489ac5d923d9
target_group_arn = arn:aws:elasticloadbalancing:ap-northeast-2:759871273906:targetgroup/SEOUL-SRE-ANDY-EKS-ALB/bbe022e37bffc833
vpc_cidr = 10.107.0.0/16
vpc_id = vpc-0fc036da847981b4b



```
```text
toolbox 설치하지 않으면 에러 발생함.
$ ./install-sentinel-eks.sh
redis install start
Error: release andyredis failed: namespaces "default" is forbidden: User "system:serviceaccount:kube-system:default" cannot get resource "namespaces" in API group "" in the namespace "default"
redis install OK
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
helm list
Error: configmaps is forbidden: User "system:serviceaccount:kube-system:default" cannot list resource "configmaps" in API group "" in the namespace "kube-system"
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
```
# Statefulset 동작 방식 확인
Pod 최초 생성시 master-0 -> slave-0 -> slave-1 -> slave-2 순서로 Pod가 Running 됨.  
Pod 4개를 동시에 삭제해도 위 순서데로 Running 됨.  
slave-1, slave-2 pod를 동시에 삭제하면 slave-1 -> slave-2 순서로 Running 됨.  
slave-0, slave-2 pod를 동시에 삭제하면 slave-0 -> slave-2 순서로 Running 됨.  
master-0, slave-1 pod를 동시에 삭제하면 master-0 -> slave-1 순서로 Running 됨.  
master-0, slave-1, slave-2 pod를 동시에 삭제하면 master-0 -> slave-1 -> slave-2 순서로 Running 됨.  
결론 : 항상 순서대로 pod가 Running 됨.  

```yaml
redis-master-0

Controlled By:  StatefulSet/andyredis-master
andyredis:
    Mounts:
        /data from redis-data (rw)
        /health from health (rw)
        /opt/bitnami/redis/etc/ from redis-tmp-conf (rw)
        /opt/bitnami/redis/mounted-etc from config (rw)
        /var/run/secrets/kubernetes.io/serviceaccount from default-token-85z8c (ro)
sentinel:
    Mounts:
      /data from redis-data (rw)
      /health from health (rw)
      /opt/bitnami/redis-sentinel/etc/ from sentinel-tmp-conf (rw)
      /opt/bitnami/redis-sentinel/mounted-etc from config (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-85z8c (ro)
Volumes:
  redis-data:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  redis-data-andyredis-master-0
    ReadOnly:   false
  health:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      andyredis-health
    Optional:  false
  config:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      andyredis
    Optional:  false
  redis-tmp-conf:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:
    SizeLimit:  <unset>
  sentinel-tmp-conf:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:
    SizeLimit:  <unset>
  default-token-85z8c:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-85z8c
    Optional:    false
```
```yaml
redis-slave-0

Controlled By:  StatefulSet/andyredis-slave
  andyredis:
    Environment:
      REDIS_REPLICATION_MODE:    slave
      REDIS_MASTER_HOST:         andyredis-master-0.andyredis-headless.default.svc.cluster.local
    Mounts:
      /data from redis-data (rw)
      /health from health (rw)
      /opt/bitnami/redis/etc from redis-tmp-conf (rw)
      /opt/bitnami/redis/mounted-etc from config (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-85z8c (ro)
  sentinel:
    Command:
      redis-server /opt/bitnami/redis-sentinel/etc/sentinel.conf --sentinel
    Mounts:
      /data from redis-data (rw)
      /health from health (rw)
      /opt/bitnami/redis-sentinel/etc from sentinel-tmp-conf (rw)
      /opt/bitnami/redis-sentinel/mounted-etc from config (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-85z8c (ro)
Volumes:
  redis-data:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  redis-data-andyredis-slave-0
    ReadOnly:   false
  health:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      andyredis-health
    Optional:  false
  config:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      andyredis
    Optional:  false
  sentinel-tmp-conf:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:
    SizeLimit:  <unset>
  redis-tmp-conf:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:
    SizeLimit:  <unset>
  default-token-85z8c:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-85z8c
    Optional:    false
```
```yaml
Name:           andyredis-slave-1
Controlled By:  StatefulSet/andyredis-slave
Containers:
  andyredis:
    Mounts:
      /data from redis-data (rw)
      /health from health (rw)
      /opt/bitnami/redis/etc from redis-tmp-conf (rw)
      /opt/bitnami/redis/mounted-etc from config (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-85z8c (ro)
  sentinel:
    Command:
      redis-server /opt/bitnami/redis-sentinel/etc/sentinel.conf --sentinel
Volumes:
  redis-data:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  redis-data-andyredis-slave-1
    ReadOnly:   false
  health:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      andyredis-health
    Optional:  false
  config:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      andyredis
    Optional:  false
  sentinel-tmp-conf:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:
    SizeLimit:  <unset>
  redis-tmp-conf:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:
    SizeLimit:  <unset>
  default-token-85z8c:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-85z8c
    Optional:    false
```
```yaml
Name:               andyredis-master
Selector:           app=redis,release=andyredis,role=master
  Containers:
   andyredis:
    Mounts:
      /data from redis-data (rw)
      /health from health (rw)
      /opt/bitnami/redis/etc/ from redis-tmp-conf (rw)
      /opt/bitnami/redis/mounted-etc from config (rw)
   sentinel:
    Mounts:
      /data from redis-data (rw)
      /health from health (rw)
      /opt/bitnami/redis-sentinel/etc/ from sentinel-tmp-conf (rw)
      /opt/bitnami/redis-sentinel/mounted-etc from config (rw)
  Volumes:
   health:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      andyredis-health
    Optional:  false
   config:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      andyredis
    Optional:  false
   redis-tmp-conf:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:
    SizeLimit:  <unset>
   sentinel-tmp-conf:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:
    SizeLimit:  <unset>
Volume Claims:
  Name:          redis-data
  StorageClass:
  Labels:        app=redis
                 component=master
                 heritage=Tiller
                 release=andyredis
  Annotations:   <none>
  Capacity:      8Gi
  Access Modes:  [ReadWriteOnce]
```
```yaml
Name:               andyredis-slave
  Containers:
   andyredis:
    Mounts:
      /data from redis-data (rw)
      /health from health (rw)
      /opt/bitnami/redis/etc from redis-tmp-conf (rw)
      /opt/bitnami/redis/mounted-etc from config (rw)
   sentinel:
    Mounts:
      /data from redis-data (rw)
      /health from health (rw)
      /opt/bitnami/redis-sentinel/etc from sentinel-tmp-conf (rw)
      /opt/bitnami/redis-sentinel/mounted-etc from config (rw)
  Volumes:
   health:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      andyredis-health
    Optional:  false
   config:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      andyredis
    Optional:  false
   sentinel-tmp-conf:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:
    SizeLimit:  <unset>
   redis-tmp-conf:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:
    SizeLimit:  <unset>
Volume Claims:
  Name:          redis-data
  StorageClass:
  Labels:        app=redis
                 component=slave
                 heritage=Tiller
                 release=andyredis
  Annotations:   <none>
  Capacity:      8Gi
  Access Modes:  [ReadWriteOnce]
```
```shell script
$ k get all
NAME                     READY   STATUS    RESTARTS   AGE
pod/andyredis-master-0   3/3     Running   0          132m
pod/andyredis-slave-0    3/3     Running   0          134m
pod/andyredis-slave-1    3/3     Running   2          132m
pod/andyredis-slave-2    3/3     Running   0          131m

NAME                         TYPE           CLUSTER-IP      EXTERNAL-IP                                                                    PORT(S)              AGE
service/andyredis            ClusterIP      172.20.115.68   <none>                                                                         6379/TCP,26379/TCP   154m
service/andyredis-headless   ClusterIP      None            <none>                                                                         6379/TCP,26379/TCP   154m
service/andyredis-metrics    LoadBalancer   172.20.160.29   aa077ef74215811ea888e06b5fd6fb27-1581408134.ap-northeast-2.elb.amazonaws.com   9121:32198/TCP       154m
service/kubernetes           ClusterIP      172.20.0.1      <none>                                                                         443/TCP              3h24m

NAME                                READY   AGE
statefulset.apps/andyredis-master   1/1     154m
statefulset.apps/andyredis-slave    3/3     154m

$ k get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                                   STORAGECLASS   REASON   AGE
pvc-a07e2154-2158-11ea-be9d-02344e80bf5e   8Gi        RWO            Delete           Bound    default/redis-data-andyredis-slave-0    gp2                     155m
pvc-a0859861-2158-11ea-be9d-02344e80bf5e   8Gi        RWO            Delete           Bound    default/redis-data-andyredis-master-0   gp2                     155m
pvc-c3674d1f-2158-11ea-be9d-02344e80bf5e   8Gi        RWO            Delete           Bound    default/redis-data-andyredis-slave-1    gp2                     154m
pvc-d0bdc631-2158-11ea-be9d-02344e80bf5e   8Gi        RWO            Delete           Bound    default/redis-data-andyredis-slave-2    gp2                     152m

$ k get pvc
NAME                            STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
redis-data-andyredis-master-0   Bound    pvc-a0859861-2158-11ea-be9d-02344e80bf5e   8Gi        RWO            gp2            155m
redis-data-andyredis-slave-0    Bound    pvc-a07e2154-2158-11ea-be9d-02344e80bf5e   8Gi        RWO            gp2            155m
redis-data-andyredis-slave-1    Bound    pvc-c3674d1f-2158-11ea-be9d-02344e80bf5e   8Gi        RWO            gp2            154m
redis-data-andyredis-slave-2    Bound    pvc-d0bdc631-2158-11ea-be9d-02344e80bf5e   8Gi        RWO            gp2            153m
```

pv 설정
```yaml
Name:              pvc-a0859861-2158-11ea-be9d-02344e80bf5e
StorageClass:      gp2
Status:            Bound
Claim:             default/redis-data-andyredis-master-0
Reclaim Policy:    Delete
Access Modes:      RWO
VolumeMode:        Filesystem
Capacity:          8Gi
Node Affinity:
  Required Terms:
    Term 0:        failure-domain.beta.kubernetes.io/zone in [ap-northeast-2a]
                   failure-domain.beta.kubernetes.io/region in [ap-northeast-2]
Message:
Source:
    Type:       AWSElasticBlockStore (a Persistent Disk resource in AWS)
    VolumeID:   aws://ap-northeast-2a/vol-098cf4ef8fa9d8e2c
    FSType:     ext4
    Partition:  0
    ReadOnly:   false
```
pv 설정
```yaml
Name:              pvc-a07e2154-2158-11ea-be9d-02344e80bf5e
StorageClass:      gp2
Claim:             default/redis-data-andyredis-slave-0
Reclaim Policy:    Delete
Access Modes:      RWO
VolumeMode:        Filesystem
Capacity:          8Gi
Node Affinity:
  Required Terms:
    Term 0:        failure-domain.beta.kubernetes.io/zone in [ap-northeast-2a]
                   failure-domain.beta.kubernetes.io/region in [ap-northeast-2]
Message:
Source:
    Type:       AWSElasticBlockStore (a Persistent Disk resource in AWS)
    VolumeID:   aws://ap-northeast-2a/vol-0b5a6d171a16ca25a
    FSType:     ext4
    Partition:  0
    ReadOnly:   false
```
pvc
```yaml
Name:          redis-data-andyredis-master-0
StorageClass:  gp2
Status:        Bound
Volume:        pvc-a0859861-2158-11ea-be9d-02344e80bf5e
Labels:        app=redis
               release=andyredis
               role=master
Capacity:      8Gi
Access Modes:  RWO
VolumeMode:    Filesystem
Mounted By:    andyredis-master-0
```
pvc
```yaml
Name:          redis-data-andyredis-slave-0
StorageClass:  gp2
Status:        Bound
Volume:        pvc-a07e2154-2158-11ea-be9d-02344e80bf5e
Labels:        app=redis
               release=andyredis
               role=slave
Capacity:      8Gi
Access Modes:  RWO
VolumeMode:    Filesystem
Mounted By:    andyredis-slave-0
```
Pod 별로 redis data 저장을 위한 PV가 별도로 생성됨.
PV 정보는 다음과 같습니다. (4개가 생성됨)
```yaml
StorageClass:      gp2
Reclaim Policy:    Delete
Access Modes:      RWO
VolumeMode:        Filesystem
Capacity:          8Gi
Source:
    Type:       AWSElasticBlockStore (a Persistent Disk resource in AWS)
    FSType:     ext4
    Partition:  0
    ReadOnly:   false
```
m4.large 인스턴스는 기본적으로 8G gp2 타입 디스크가 할당되고, Redis 구성 설정에 EBS에 PV가 생성되도록 되어 있음.  
helm delete 명령어를 사용해 redis cluster를 삭제해도 PV, PVC 정보는 남아있음.  
주의) Terraform을 이용해 K8s cluster를 삭제해도 EBS는 삭제되지 않음 -> 별도 수작업으로 삭제해 주어야 함. 
redis master/slave pod를 다시 설치하면 PVC 이름을 이용해 PV와 연결하므로 동일한 PV를 다시 마운트해서 사용함, 그래서 redis data가 지워지지 않음.

Redis는 데이터를 파일 또는 DB에 저장 가능하나 DB로 저장하게 되면 별도 DB가 필요하고 관리 포인트가 늘어날 거 같음.  
파일 저장 방식을 택한다면 속도 측면에서 별도의 EBS SSD를 마운트 하여 사용하는 방식에 대한 검토가 필요해 보임.  
S3도 선택지 중 하나일 수 있으나 속도 측면에서 좋은 선택은 아닌거 같음.  

# Redis HA helm chart를 이용한 HA 구성 테스트
## 1) master node 1대 중지했을때 서비스 장애 시간은 20초, 시스템 정상화 5분 걸림
참고 사항) 내부적으로 sentinel 서버에 의해 master 서버가 바뀔때 6380 port (slave 접속용 포트)를 통해 write 가능한 경우가 잠깐 생김
## 2) node 2대(master 1대, slave 1대) 중지, slave 서버를 통한 read 서비스는 장애 시간 20초, write 서비스 장애 시간은 5분, 시스템 정상화 5분 걸림
참고 사항) 내부적으로 sentinel 서버에 의해 master 서버가 바뀔때 6380 port (slave 접속용 포트)를 통해 write 가능한 경우가 잠깐 생김
## 3) node 3대 모두 중지, read/write 서비스 장애 시간 6분, 시스템 정상화 11분 걸림
참고 사항) redis-client를 사용하여 테스트 중인데... 에러 메시지 없이 조용히 지나감.  
4분 정도 지나면 node 1대가 구동됨.  
3대의 node 중 2대만 정상화 되어도 서비스는 정상화 됨.  
## PV가 유지되어 이전에 저장한 cache data 가 삭제되지 않음을 확인함

## 성능 테스트
### 테스트 조건
```text
100000 requests  
50 parallel clients  
3 bytes payload  
```
### 테스트 결과
set : 8300 TPS  
get : 8700 TPS  
```text
PING_INLINE: 8048.94 requests per second
PING_BULK: 8895.21 requests per second
SET: 8370.30 requests per second
GET: 8788.12 requests per second
INCR: 8443.09 requests per second
LPUSH: 8602.15 requests per second
RPUSH: 8386.45 requests per second
LPOP: 8654.26 requests per second
RPOP: 8513.54 requests per second
SADD: 8624.41 requests per second
HSET: 8399.13 requests per second
SPOP: 8196.05 requests per second
LPUSH (needed to benchmark LRANGE): 7705.94 requests per second
LRANGE_100 (first 100 elements): 7867.82 requests per second
LRANGE_300 (first 300 elements): 6947.34 requests per second
LRANGE_500 (first 450 elements): 5878.55 requests per second
LRANGE_600 (first 600 elements): 4793.17 requests per second
MSET (10 keys): 8678.30 requests per second
```  
# helm upgrade 테스트
helm upgrade 명령어를 이용하여 설정을 변경해 가면서 상태를 확인했습니다.
## replica 갯수 설정을 3개에서 4개로 늘림
추가로 pod 가 생성되어야 하는데 affinity 설정에의해 동일한 node에 2개의 redis 용 pod가 실행될수 없어서 pending 상태에 
빠짐. 서비스 영향도는 없음. K8s cluster 설정에서 min 3, max 10으로 설정되어 있어서 node 수가 현재 3개에서 4개로 늘어날 거라 예상했는데... 아님.  
## replica 갯수 설정을 3개에서 1개로 줄임
redis pod 갯수가 1개로 줄어듦.
Redis client에서 set 실행 하면 "NOREPLICAS Not enough good replicas to write." 에러 발생 -> master 서버만 있고 slave 서버가 없어서 set 기능 동작안함. get 기능은 정상 동작함.  
## redis docker image version 변경
pod/redis-ha-server-2 -> 1 -> 0 번 순서로 새로운 pod가 생성됨(pod IP가 변경됨을 확인)  
redis 서버가 1대씩 교체될때 write 서비스 순단 현상 발생(2초 정도, read 서비스는 정상 동작함)  
HA Proxy에서 redis master 서버가 변경된 정보를 인지하는데 2초 정도 걸리는거 같음.  

# 카오스 몽키 테스트
## kubectl delete 명령어 이용해 work node 3개 삭제
Work node 용 EC2는 삭제되지 않음. K8s 설정에서만 삭제됨.
그러나 이로 인해 모든 pod가 pending 상태로 빠짐.
자동으로 복구되지 않음.
Helm tiller 도 삭제됨 -> Helm을 이용해 stable/redis-ha 차트를 재 설치 하려고 했으나 불가능함.    
AWS consloe에서 work node 용 EC2 3개를 삭제함(EC2가 새로 생성되면서 K8s node 정보가 신규생성될거라는 기대로...)  
EC2 3개 신규 생성됨. K8s node 정보가 신규 3개 생기나 서비스는 정상화 되지 않음.  
Redis Pod 상태가 CrashLoopBackOff 상태로 빠짐. -> 정상화 안됨.  
valve-tools 이용해 helm init 수행 하면 helm 정상 동작함.  
Helm 이용해 redis-ha 다시 설치해야함 -> CLB 주소가 바뀜 -> 고정된 주소를 갖도록 설정 필요!!!
## kubectl delete 명령어 이용해 PVC, PV 컴포넌트 삭제
Terminating 상태로 빠짐, 계속 Terminating 상태로 남아있음, AWS console에서 확인해 보면 정상으로 보임.  


# Affinity 설정
```text
Affinity 설정 확인
stable/redis-ha helm chart 설정은 다음과 같습니다.

values.yaml 파일에 다음과 같이 설정함  
## Whether the Redis server pods should be forced to run on separate nodes.
## This is accomplished by setting their AntiAffinity with requiredDuringSchedulingIgnoredDuringExecution as opposed to preferred.
## Ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#inter-pod-affinity-and-anti-affinity-beta-feature
##
hardAntiAffinity: true

Helm chart 내 templates yaml 파일(redis-ha-statefulset.yaml)에 다음과 같이 설정되어 있음  
        podAntiAffinity:
    {{- if .Values.hardAntiAffinity }}
          requiredDuringSchedulingIgnoredDuringExecution:
            - labelSelector:
                matchLabels:
                  app: {{ template "redis-ha.name" . }}
                  release: {{ .Release.Name }}
                  {{ template "redis-ha.fullname" . }}: replica
              topologyKey: kubernetes.io/hostname

5) hardAntiAffinity 값을 false 로 설정하고 replica 갯수를 늘려주면 동일한 node에 redis pod가 2개이상 구동됨.

6) redis pod가 항상 동일한 node에서 구동되는거는 아님.
     work node 갯수를 5개로 하고 replica 갯수를 1개로 줄였다가 5개로 늘리니 다른 node에 구동되는 pod가 있음을 확인함.

7) replica 수를 3에서 4로 늘리면 4번 pod만 추가되는게 아님.
     4번 pod가 추가되고, 3번 -> 2번 -> 1번 pod 순서로 재시작 됨.
     replica 수가 줄어들어도 전체 pod가 역순으로 재시작 됨.

8) PVC 설정에서 디스크 크기를 변경하면 에러 발생하면서 변경 안됨.
     운영 환경 설정 시 디스크 크기를 신중하게 선택해야 할거 같음.

Pending 상태일때 오류 메시지
Warning  FailedScheduling  36s (x6 over 2m1s)  default-scheduler  0/5 nodes are available: 5 node(s) didn't match pod affinity/anti-affinity, 5 node(s) didn't satisfy existing pods anti-affinity rules.

```
### 추가 확인 사항
* 쿠버네티스 설정에서 PV 삭제하면 AWS 볼륨이 삭제되는지 확인  
"kubectl delete pv {PV이름}" 명령어를 사용하여 삭제 시도하면 deleted 로그는 뜨는데 명령어 실행은 끝나지 않음.  
Bound -> Terminating 상태로 변경되며 삭제되지 않음.  
계속해서 Terminating 상태로 남아있음.  
AWS 콘솔에서 EBS 볼륨 확인해 보면 in-use 상태로 남아있음.
PVC를 동일한 방법으로 삭제해도 PV와 동일한 결과 얻음.  
"helm delete" 명령어를 이용해 chart를 삭제하면 Terminating 상태에 있던 PVC 가 삭제되고 PV 및 AWS 콘솔상 BES 볼륨도 삭제됨.  
PVC 를 삭제하면 PV 및 AWS 콘솔상 BES 볼륨도 삭제됨.  
결론: PV 가 다른 리소스에 의해 사용되고 있으면 삭제되지 않고 Terminating 상태로 남아있음  

* PVC 사이즈 설정을 줄이면 에러 발생하는데 늘리면 어떻게 되는지 확인  
persistentVolume size 를 4Gi -> 8Gi 로 늘려도 에러 발생함.
```text
UPGRADE FAILED
Error: StatefulSet.apps "andyredis-ha-server" is invalid: spec: Forbidden: updates to statefulset spec for fields other than 'replicas', 'template', and 'updateStrategy' are forbidden
Error: UPGRADE FAILED: StatefulSet.apps "andyredis-ha-server" is invalid: spec: Forbidden: updates to statefulset spec for fields other than 'replicas', 'template', and 'updateStrategy' are forbidden
```
'replicas', 'template'및 'updateStrategy'이외의 필드에 대한 statefulset 스펙 업데이트는 금지됩니다.  

* 다른 존에 Pod가 뜨면 기존에 연결된 PV와 연결이 안될거 같음, 확인 필요  
work node 가 a,b,c zone 에 각각 1대씩 생성되는줄 알았는데... 아님.  
a zone 에 2대의 work node 생성됨을 확인함.  
replica 를 10으로 설정하면 a zone 5대, c zone 5대로 생성되는거를 확인함 -> 나름의 규칙이 있는거 같음.  
pod 10개를 동시에 삭제하고 이전 상태와 비교해 보니  
pod 10개가 새로 생성되면서 node 가 변경되는 pod가 존재함을 확인함.  
node 는 변경되나 동일한 zone에 있는 다른 node로 변경됨을 확인함.







