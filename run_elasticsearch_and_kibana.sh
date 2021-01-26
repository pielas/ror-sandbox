. ./dc-internals/common.sh

echo Elasticsearch version: $ELASTICSEARCH_VERSION
echo ROR plugin location: $ELASTICSEARCH_LOCATION
echo Kibana version: $ELASTICSEARCH_VERSION
echo ROR kibana plugin location: $KIBANA_LOCATION

docker-compose build elasticsearch kibana
docker-compose up elasticsearch kibana
