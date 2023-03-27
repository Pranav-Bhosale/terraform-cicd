value=$(sudo lsof -n -i :80 )

if [ -z $value ]
then
  sudo MICRONAUT_SERVER_PORT=80 nohup java -jar esop-0.1-all.jar  > /dev/null &
  exit
else
  sudo kill -9 $value
  sudo MICRONAUT_SERVER_PORT=80 nohup java -jar esop-0.1-all.jar > /dev/null &
  exit
fi