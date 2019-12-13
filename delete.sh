echo 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
helm list
echo 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
echo 'delete andygrafana start'
helm delete andygrafana --purge
echo 'delete andygrafana OK'
helm delete andyprometheus --purge
echo 'delete andyprometheus OK'
#helm delete andyredisexporter --purge
#echo 'delete andyredisexporter OK'
helm delete andyredis --purge
echo 'delete andyredis OK'
echo 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
while [ true ]
do
  echo 'kubectl get all'
  kubectl get all
  linecount=$(kubectl get all | grep pod | wc -l)
  echo 'linecount : ' $linecount
  echo 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
  if [ $linecount -eq 0 ]
  then
    break
  fi
  sleep 5
done
