## ReadonlyREST development sandbox

Development sandbox was created to ease up experiments and debugging of ROR elasticsearch and kibana plugin. When I created it I wanted to make it easy to recreate environment as close as possible to customer's environment. 

I wanted to make it easy to:
* Set up specific version of elasticsearch and kibana with ROR plugin.
* Set up elasticsearch and kibana along with ROR plugin from custom location.
* Set up elasticsearch for remote debugging.
* Set up kibana connected to elasticsearch from `eshome` executed in IDE.

### Architecture
Whole sandbox is based on docker and uses docker compose to orchestrate containers. There are 3 services configured in docker-compose.yml:
* elasticsearch - could be used as standalone elasticsearch instance with ability to connect remote debugger to it.
* kibana - configured to connect to elasticsearch instance from this sandbox.
* kibana-oss - oss version of kibana designated to work with elasticsearch from `eshome`. 

> :warning: Each service has been intended to run from dedicated script which configures environment variables used in docker-compose.yml, builds proper image and runs it. If you want to use docker-compose directly check section "Using docker-compose manually" 

#### Exposed ports
By default services from sandbox expose these ports:
* `9200` - elasticsearch REST
* `8888` - elasticsearch remote debug 
* `5601` - kibana

## Configuration
For most purposes it should be enough to change only files under `conf` directory to adapt sandbox to specific needs. This directory contains configuration files mapped directly to container and `env_configuration`. If you want to change some service configuration file you have to add it's mapping to `docker-compose.yml`. Here's description of each file:
* `conf/`
  * `elasticsearch/`
    * `elasticsearch.yml` - minimal single Elasticsearch server configuration file 
    * `jvm.options` - default file with added remote debugging on port 8888
    * `readonlyrest.yml` - sample ROR configuration file which allows kibana to access it.
  * `kibana/`
    * `kibana.yml` - minimal kibana configuration file with debug logs enabled
  * `kibana-oss/`
    * `kibana.yml` - minimal kibana configuration file with debug logs enabled
  * `env_configuration` - file which is used to configure sandbox

### env_configuration file 
This contains environment variables used to configure sandbox. Here's description of each variable:
* `ELASTICSEARCH_VERSION` - version of elasticsearch and kibana server to use. Currently it's not possible to run different version of elasticsearch and kibana.
* `CUSTOM_ROR_ELASTICSEARCH_LOCATION` - specifies custom URL for elasticsearch ROR plugin. For example could be used to run elastic with file from S3. When empty, ROR will be downloaded from `https://api.beshu.tech/download/es?esVersion=$ELASTICSEARCH_VERSION`
* `CUSTOM_ROR_KIBANA_LOCATION` - specifies custom URL for kibana ROR plugin. For example could be used to run kibana with file from S3. When empty, ROR will be downloaded from `https://api.beshu.tech/download/trial?esVersion=$ELASTICSEARCH_VERSION`


## Starting services

> :warning: Each service has been intended to run from dedicated script which configures environment variables used in docker-compose.yml, builds proper image and runs it. If you want to use docker-compose directly check section "Using docker-compose manually" 

There are few dedicated scripts to run services, prepare env for custom use and clean env from data. Scripts which are used to run services are starting in terminal attached mode. It's done this way to make it less likely that you will forgot to reload service after config change or service would be left running in background.

Each script was intended to be executed from root sandbox directory. Using it from other directories will fuck up hardcoded paths. Here's a list of all scripts:

* `run_elasticsearch.sh` - will build and run elasticsearch service in terminal attached mode
* `run_kibana.sh` - will build and run kibana service in terminal attached mode
* `run_kibana_for_eshome.sh` - will build and run kibana service dedicated to use with `eshome` in terminal attached mode
* `prepare_dc_for_custom_use.sh` - will prepare sandbox to use docker-compose manually. Remember to use it with `source ./prepare_dc_for_custom_use.sh`
* `clean.sh` - will bring down and remove all containers. Elasticsearch data will be removed by this command.
* `clean_all.sh` - will do exactly what command above additionally will remove volumes with kibana cache.

### Using docker-compose manually
If you want to have more control over how services are executed you can use script which will configure all env variables required by docker-compose, so it will be possible to execute docker-compose directly without using dedicated scripts. It's less convenient than using scripts because you have remember to execute prepare script after each change to `env_configuration` file, so it's possible that you will run app with old settings.

Here's how to use it:
1. Go to sandbox directory using `cd`
1. Execute `source ./prepare_dc_for_custom_use.sh`
1. You are now should be able to execute for example `docker-compose up -d elasticsearch`
1. After each change to `env_configuration` repeat step 2.

## Use cases
