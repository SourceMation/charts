
# Elastic stack installation

The chart is under active development

## Requirements

### Generic

1. Open traffic from k8s to following services

```bash
helm.elastic.co:TCP/443
download.elastic.co:TCP/443
docker.elastic.co:TCP/443
epr.elastic.co:TCP/443
docker.elastic.codocker-auth.elastic.cod2iks1dkcwqcbx.cloudfront.net:TCP/443
quay.io:TCP/443
geoip.elastic.co:TCP/443
```

2. Install kube-vip or any solution with support external ip in a service (optional)
3. Minimum three worker nodes with 12x vCPU, 32GB RAM
4. Storage class supported block storage and RWO access with 650GiB of available space

## Elastic operator - install

```bash 

export ECK_VER=2.11.1

helm -n lp-operators upgrade --install --create-namespace \
--set "installCRDs=false" \
--set "createClusterScopedResources=true" \
--set "webhook.enabled=false" \
--set "config.validateStorageClass=false" \
--repo https://helm.elastic.co \
--version ${ECK_VER} \
elastic-operator eck-operator

helm -n lp-operators upgrade --install --create-namespace \
--repo https://helm.elastic.co \
--version ${ECK_VER} \
elastic-operator-crds eck-operator-crds


```

## Elastic stack - install

```bash


export ELASTIC_VER=1.2.2
export CLUSTER_NAME=elk
export K8S_NAMESPACE=elastic-tst
export ELASTICSEARCH_URL=elastic-tst.apps.example.com
export REPO_URL=repo-tst.apps.example.com
export KB_URL=kibana-tst.apps.example.com
export APM_URL=apm-tst.apps.example.com
export FLEET_URL=fleet-tst.apps.example.com



helm -n ${K8S_NAMESPACE} upgrade --install --create-namespace \
--set "elasticsearch.params.ingress.hostname=${ELASTICSEARCH_URL}" \
--set "packageRegistry.params.ingress.hostname=${REPO_URL}" \
--set "kibana.params.ingress.hostname=${KB_URL}" \
--set "agentServices.params.roles.apm.ingress.hostname=${APM_URL}" \
--set "agentFleet.params.ingress.hostname=${FLEET_URL}" \
--repo https://sourcemation.github.io/charts/ \
--version ${ELASTIC_VER} \
${CLUSTER_NAME} elastic


```

## Add license to Elastic (optional)

1. Create licence file in location /tmp/elastic-license.json

2. Run following commands

```bash

kubectl create secret generic eck-license --from-file=elastic-license.json -n ${K8S_NAMESPACE} 
kubectl label secret eck-license "license.k8s.elastic.co/scope"=operator -n ${K8S_NAMESPACE}

```


## Elastic - remove


```bash


helm -n ${K8S_NAMESPACE} uninstall ${CLUSTER_NAME}

helm -n lp-operators uninstall elastic-operator-crds
helm -n lp-operators uninstall elastic-operator

```


## For developers


```bash 

git clone git@github.com:SourceMation/charts.git

cd charts/charts/elastic/${ELASTIC_VER}

kubectl config set-context --current --namespace ${K8S_NAMESPACE}

helm -n ${K8S_NAMESPACE} upgrade --install --create-namespace ${CLUSTER_NAME} . \
--set "elasticsearch.params.ingress.hostname=${ELASTICSEARCH_URL}" \
--set "packageRegistry.params.ingress.hostname=${REPO_URL}" \
--set "kibana.params.ingress.hostname=${KB_URL}" \
--set "agentServices.params.roles.apm.ingress.hostname=${APM_URL}" \
--set "agentFleet.params.ingress.hostname=${FLEET_URL}"

```
