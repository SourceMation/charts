## Generic

Based on: https://github.com/elastic/cloud-on-k8s.git
Doc: https://www.elastic.co/guide/en/cloud-on-k8s/current/index.html
Source: https://github.com/SourceMation/charts.git

## Requirements

1. Open traffic from k8s to following services (airgap envs)

```bash
helm.elastic.co:TCP/443
download.elastic.co:TCP/443
docker.elastic.co:TCP/443
epr.elastic.co:TCP/443
docker.elastic.codocker-auth.elastic.cod2iks1dkcwqcbx.cloudfront.net:TCP/443
quay.io:TCP/443
geoip.elastic.co:TCP/443

```

2. Minimum three worker nodes with 12x vCPU, 32GB RAM
3. Storage class supported block storage and RWO access with 650GiB of available space

## Before Installation

1. Install chart via Apps: Elastic - Operators (1/3)
2. Install kube-vip or any solution with support external ip in a service


## After Installation

no action required

## Before Upgrade

no action required

## After Upgrade

no action required

## Tips and Tricks

### Add license to Elastic

1. Create licence file in location /tmp/elastic-license.json

2. Run following commands

```bash

export CHART_NAMESPACE=elastic-tst
kubectl create secret generic eck-license --from-file=elastic-license.json -n ${CHART_NAMESPACE} 
kubectl label secret eck-license "license.k8s.elastic.co/scope"=operator -n ${CHART_NAMESPACE}

```

## Known Issues

lack of known issues




## CLI installation

### Preparation

```bash

export CHART_VER=1.5.0
export CHART_RELEASE_NAME=elk
export CHART_NAMESPACE=elastic-tst

export ELASTICSEARCH_URL=elastic-tst.apps.example.com
export REPO_URL=repo-tst.apps.example.com
export KB_URL=kibana-tst.apps.example.com
export APM_URL=apm-tst.apps.example.com
export FLEET_URL=fleet-tst.apps.example.com
export ENT_URL=esearch-tst.apps.example.com


kubectl create ns ${CHART_NAMESPACE}

kubectl config set-context --current --namespace ${CHART_NAMESPACE}

```

### Go go helm

``` bash

helm -n ${CHART_NAMESPACE} upgrade --install --create-namespace \
--set "elasticsearch.params.ingress.hostname=${ELASTICSEARCH_URL}" \
--set "packageRegistry.params.ingress.hostname=${REPO_URL}" \
--set "kibana.params.ingress.hostname=${KB_URL}" \
--set "agentServices.params.roles.apm.ingress.hostname=${APM_URL}" \
--set "agentFleet.params.ingress.hostname=${FLEET_URL}" \
--set "enterpriseSearch.params.ingress.hostname=${ENT_URL}" \
--repo https://sourcemation.github.io/charts/ \
--version ${CHART_VER} \
${CHART_RELEASE_NAME} elastic


```

## CLI removing

```bash

helm -n ${CHART_NAMESPACE} uninstall ${CHART_RELEASE_NAME}

```
