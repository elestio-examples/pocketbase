#set env vars
set -o allexport; source .env; set +o allexport;

sleep 30s;
docker-compose logs pocketbase > logs.txt
token=$(grep -oP "http://0.0.0.0:8090/_/#/pbinstal/\K[^ ]+" logs.txt)

rm -rf ./logs.txt

target=$(docker-compose port pocketbase 8090)

curl http://${target}/api/collections/_superusers/records \
  -H 'accept: */*' \
  -H 'authorization: '${token}'' \
  -H 'accept-language: en-US' \
  -H 'content-type: application/json' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36' \
  --data-raw '{"email":"'$EMAIL'","password":"'$ADMIN_PASSWORD'","passwordConfirm":"'$ADMIN_PASSWORD'"}' \
  --compressed