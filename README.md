# andyredis
redis cluster on k8s

## Master 1대, Slaver 2대로 구성
install.sh


## Sentinel 구성
installsentinel.sh

## 참고) Sentinel 명령
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