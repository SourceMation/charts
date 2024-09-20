# Useful links / Przydatne linki
- https://github.com/SourceMation/charts/blob/main/charts/elastic/current/README.md

# CLI Installation / CLI Instalacja

## Preparation / Przygotowanie

```bash

export CHART_VERSION=1.3.0
export CLUSTER_NAME=elk
export K8S_NAMESPACE=lp-app
export ELASTICSEARCH_URL=elastic-tst.apps.example.com
export REPO_URL=repo-tst.apps.example.com
export KB_URL=kibana-tst.apps.example.com
export APM_URL=apm-tst.apps.example.com
export FLEET_URL=fleet-tst.apps.example.com
export ENT_URL=esearch-tst.apps.example.com

```

## Create file with values / Przygotuj plik z parametrami do przekazania

```bash

```


## Installation via helm / Instalacja przy użyciu helm

``` bash

helm -n ${K8S_NAMESPACE} upgrade --install monitoring-stack-app \
--set "elastic.elasticsearch.params.ingress.hostname=${ELASTICSEARCH_URL}" \
--set "elastic.packageRegistry.params.ingress.hostname=${REPO_URL}" \
--set "elastic.kibana.params.ingress.hostname=${KB_URL}" \
--set "elastic.agentServices.params.roles.apm.ingress.hostname=${APM_URL}" \
--set "elastic.agentFleet.params.ingress.hostname=${FLEET_URL}" \
--set "elastic.enterpriseSearch.params.ingress.hostname=${ENT_URL}" \
--repo https://sourcemation.github.io/charts/ monitoring-stack-app

```



# For developers

```bash


cd charts/monitoring-stack-app/${CHART_VERSION}


cat <<EOF> /tmp/monitoring-stack-app.yaml
global:              
  elasticApp:  
    enabled: true
elastic:
  elasticsearch:
    params:
      ingress:
        hostname: ${ELASTICSEARCH_URL}
  packageRegistry:
    params:
      ingress:
        hostname: ${REPO_URL}
  kibana:
    params:
      ingress:
        hostname: ${KB_URL}
  agentServices:
    params:
      roles:
        apm:
          ingress:
            hostname: ${APM_URL}
  agentFleet:
    params:
      ingress:
        hostname: ${FLEET_URL}
  enterpriseSearch:
    params:
      ingress:
        hostname: ${ENT_URL}

EOF


helm -n ${K8S_NAMESPACE} upgrade --install --create-namespace monitoring-stack-app . \
-f /tmp/monitoring-stack-app.yaml

```

