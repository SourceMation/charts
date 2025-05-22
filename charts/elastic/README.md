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
kubectl create secret generic eck-license --from-file=elastic-license.json -n ${RELEASE_NAMESPACE} 
kubectl label secret eck-license "license.k8s.elastic.co/scope"=operator -n ${RELEASE_NAMESPACE}
```

## Known Issues

lack of known issues



## CLI installation

### Preparation

```bash
export RELEASE_NAME=elk
export CHART_NAME=elastic
export RELEASE_NAMESPACE=elastic-tst
export CHART_VER=1.4.0

export ELASTICSEARCH_URL=elastic-tst.apps.example.com
export REPO_URL=repo-tst.apps.example.com
export KB_URL=kibana-tst.apps.example.com
export APM_URL=apm-tst.apps.example.com
export FLEET_URL=fleet-tst.apps.example.com


kubectl create ns ${RELEASE_NAMESPACE}
kubectl config set-context --current --namespace ${RELEASE_NAMESPACE}
```

### Go go helm

``` bash
helm -n ${RELEASE_NAMESPACE} upgrade --install ${RELEASE_NAME} \
--set "elasticsearch.params.ingress.hostname=${ELASTICSEARCH_URL}" \
--set "packageRegistry.params.ingress.hostname=${REPO_URL}" \
--set "kibana.params.ingress.hostname=${KB_URL}" \
--set "agentServices.params.roles.apm.ingress.hostname=${APM_URL}" \
--set "agentFleet.params.ingress.hostname=${FLEET_URL}" \
${CHART_NAME} --repo https://charts.sourcemation.com/ \
--version ${CHART_VER}
```

## CLI removing

```bash
helm -n ${RELEASE_NAMESPACE} uninstall ${RELEASE_NAME}
```
