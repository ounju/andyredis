# andyredis
redis cluster on k8s

## Master 1대, Slaver 2대로 구성
install.sh


## Sentinel 구성
installsentinel.sh

## 참고) Sentinel 명령
```shell script
redis-cli -h 127.0.0.1 -p 26379 -a redispassword ROLE
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
aws eks update-kubeconfig --name seoul-dev-fasttrack-eks --alias seoul-dev-fasttrack-eks

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
terraform import module.efs.aws_efs_file_system.efs fs-32084f53

efs_mount_target_ids =
terraform import 'module.efs.aws_efs_mount_target.efs[0]' fsmt-ef11b78e
terraform import 'module.efs.aws_efs_mount_target.efs[*]' fsmt-f111b790
terraform import 'module.efs.aws_efs_mount_target.efs[*]' fsmt-ee11b78f

import_command-1 =
terraform import -var-file=YOUR module.eks-domain.aws_route53_record.validation Z1PY2EID2YMYG4__a1c4daf8f58186f137a4367538c30c86.fasttrack.opsnow.io._CNAME

nat_ip = [
  "15.164.254.136",
]
private_subnet_cidr = [
  "10.101.28.0/24",
  "10.101.29.0/24",
  "10.101.30.0/24",
]
private_subnet_ids = [
  "subnet-0b91046a077823c93",
  "subnet-07c749a11d607605c",
  "subnet-0f81c0234ac797498",
]
public_subnet_cidr = [
  "10.101.25.0/24",
  "10.101.26.0/24",
  "10.101.27.0/24",
]
public_subnet_ids = [
  "subnet-0bdbbdd7d415af80f",
  "subnet-049490a3e77aeba65",
  "subnet-0b0b8bb8bc898e895",
]
record_set = *.fasttrack.opsnow.io
sg-node = node security group id : sg-0a684efe744948995
target_group_arn = arn:aws:elasticloadbalancing:ap-northeast-2:759871273906:targetgroup/SEOUL-DEV-FASTTRACK-EKS-ALB/00fa6382ff809c5e
vpc_cidr = 10.101.0.0/16
vpc_id = vpc-08a1ddab3ce3d9e04
```