#set env vars
set -o allexport; source .env; set +o allexport;

target=$(docker-compose port pocketbase 8090)

curl http://${target}/api/admins \
  -H 'accept: */*' \
  -H 'accept-language: en-US' \
  -H 'content-type: application/json' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36' \
  --data-raw '{"email":"'$EMAIL'","password":"'$ADMIN_PASSWORD'","passwordConfirm":"'$ADMIN_PASSWORD'"}' \
  --compressed