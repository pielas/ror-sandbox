. ./common.sh

echo Elasticsearch version: $ELASTICSEARCH_VERSION
echo ROR plugin location: $ELASTICSEARCH_LOCATION

docker-compose build elasticsearch
docker-compose up elasticsearch 
