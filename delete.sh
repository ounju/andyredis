helm list
echo 'delete andygrafana start'
helm delete andygrafana --purge
echo 'delete andygrafana OK'
helm delete andyprometheus --purge
echo 'delete andyprometheus OK'
#helm delete andyredisexporter --purge
#echo 'delete andyredisexporter OK'
helm delete andyredis --purge
echo 'delete andyredis OK'
while [ true ]
do
  echo 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
  echo 'kubectl get all'
  kubectl get all
  linecount=$(kubectl get all | grep pod | wc -l)
  echo 'linecount : ' $linecount
  if [ $linecount -eq 0 ]
  then
    break
  fi
  sleep 5
done
#echo 'ps -ef | grep kubectl'
#ps -ef | grep kubectl
#pscount=$(ps -ef | grep kubectl | wc -l)
#echo 'pscount : ' $pscount
#if [ $pscount -gt 0 ]
#then
#  ps -ef | grep kubectl | kill -9 $(awk '{print $2}')
#fi
#sleep 2
#echo 'ps -ef | grep kubectl'
#ps -ef | grep kubectl
