Purpose of this sandbox was to ease up experiments and debugging of ROR elasticsearch and kibana plugin. 

Whole sandbox is based on docker and uses docker compose to orchestrate containers. 

By default kibana service is configured to connect to elasticsearch run in sandbox.
Kibana-oss service was provided to connect to `eshome` instance. It is by default configured to connect to elasticsearch on host machine(not in sandbox) 

Elasticsearch has remote debugging enabled on port 8888.

Adapting sandbox to custom needs:
`conf` file could be used to change version of elasticsearch and kibana. It also contains CUSTOM_ROR_ELASTICSEARCH_LOCATION and CUSTOM_ROR_KIBANA_LOCATION which could be used to define custom location of plugins(for example to use own build or specific version)

Exposed ports:
9200 - elasticsearch REST
8888 - elasticsearch remote debug 
5601 - kibana

Running services in sandbox:
Please do not run services directly because docker-compose.yml is using environemnt variabled which have to be configured first. Use dedicated scripts instead.

`run_elasticsearch.sh` - will build and run elasticsearch service in terminal attached mode
`run_kibana.sh` - will build and run kibana service in terminal attached mode
`run_kibana_oss.sh` - will build and run kibana-oss service in terminal attached mode
