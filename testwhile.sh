echo '11111'
while [ true ]
do
  echo 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
  echo 'helm list'
  helm list
  echo 'kubectl get po'
  kubectl get po
  linecount=$(kubectl get po | grep Running | wc -l)
  echo 'linecount : ' $linecount
  if [ $linecount -eq 9 ]
  then
    break
  fi
  sleep 5
done
echo '22222'