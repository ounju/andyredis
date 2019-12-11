while [ true ]
do
  printf "`date` ^^ `kubectl get all`\n"
  sleep 1
done
