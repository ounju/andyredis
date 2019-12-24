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
terraform import module.efs.aws_efs_file_system.efs fs-24d39545

efs_mount_target_ids =
terraform import 'module.efs.aws_efs_mount_target.efs[0]' fsmt-873697e6
terraform import 'module.efs.aws_efs_mount_target.efs[*]' fsmt-893697e8
terraform import 'module.efs.aws_efs_mount_target.efs[*]' fsmt-853697e4

import_command-1 =
terraform import -var-file=YOUR module.eks-domain.aws_route53_record.validation Z1PY2EID2YMYG4__13ee5909fa252a2f26d196cc3c1814a4.andy.opsnow.io._CNAME

nat_ip = [
  "13.124.93.39",
]
private_subnet_cidr = [
  "10.107.88.0/24",
  "10.107.89.0/24",
  "10.107.80.0/24",
]
private_subnet_ids = [
  "subnet-0c876a8d59f744f45",
  "subnet-0bf75eddcc8b11bcb",
  "subnet-067e9581ebae1b108",
]
public_subnet_cidr = [
  "10.107.85.0/24",
  "10.107.86.0/24",
  "10.107.87.0/24",
]
public_subnet_ids = [
  "subnet-094873823c3336129",
  "subnet-04c320708477d5828",
  "subnet-067a447863dac8ebc",
]
record_set = *.andy.opsnow.io
sg-node = node security group id : sg-062d0d647748e180e
target_group_arn = arn:aws:elasticloadbalancing:ap-northeast-2:759871273906:targetgroup/SEOUL-SRE-ANDY-EKS-ALB/8a732982d3cb9281
vpc_cidr = 10.107.0.0/16
vpc_id = vpc-017655fb3c8b0a6dd

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

node 4대를 모두 중지 시켰을때 정상화 되는데 걸린 시간 : 11분  
master 서비스  
2019년 12월 24일 화요일 17시 15분 53초 KST ^^^^^  
2019년 12월 24일 화요일 17시 25분 47초 KST ^^^^^ NOREPLICAS Not enough good replicas to write.  
2019년 12월 24일 화요일 17시 26분 17초 KST ^^^^^ OK  

replica 서비스  
2019년 12월 24일 화요일 17시 15분 54초 KST ^^^^^  
2019년 12월 24일 화요일 17시 26분 12초 KST ^^^^^ 33333  
