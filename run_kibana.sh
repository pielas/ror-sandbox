. ./common.sh

echo Kibana version: $ELASTICSEARCH_VERSION
echo ROR kibana plugin location: $KIBANA_LOCATION

docker-compose build kibana
docker-compose up kibana 
