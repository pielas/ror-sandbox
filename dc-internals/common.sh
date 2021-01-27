source ./conf/env_configuration

export ELASTICSEARCH_VERSION
export KIBANA_VERSION

if [ -z "$CUSTOM_ROR_ELASTICSEARCH_LOCATION" ]
then
  export ELASTICSEARCH_LOCATION=https://api.beshu.tech/download/es?esVersion=$ELASTICSEARCH_VERSION
else
  export ELASTICSEARCH_LOCATION=$CUSTOM_ROR_ELASTICSEARCH_LOCATION
fi


if [ -z "$CUSTOM_ROR_KIBANA_LOCATION" ]
then
  export KIBANA_LOCATION=https://api.beshu.tech/download/trial?esVersion=$ELASTICSEARCH_VERSION
else
  export KIBANA_LOCATION=$CUSTOM_ROR_KIBANA_LOCATION
fi

export COMPOSE_FILE=./dc-internals/docker-compose.yml
export COMPOSE_PROJECT_NAME=ror-sandbox
