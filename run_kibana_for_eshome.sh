. ./dc-internals/common.sh

echo $'Kibana version: \e[33m'$KIBANA_VERSION$'\e[0m'
echo ROR kibana plugin location: $KIBANA_LOCATION
echo ''

docker-compose build kibana-oss
docker-compose up kibana-oss 
