
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
```

2. Install kube-vip or any solution with support external ip in a service (optional)
3. Minimum three worker nodes with 12x vCPU, 32GB RAM
4. Storage class supported block storage and RWO access with 650GiB of available space


# Elastic stack - install

```bash


export ECK_VER=2.11.1
export ELASTIC_VER=1.1.0
export K8S_NAMESPACE=elastic-tst
export ELASTICSEARCH_URL=elastic-tst.svc0.ipa.health.local
export REPO_URL=repo-tst.svc0.ipa.health.local
export KB_URL=kibana-tst.svc0.ipa.health.local
export APM_URL=apm-tst.svc0.ipa.health.local
export FLEET_URL=fleet-tst.svc0.ipa.health.local


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


helm -n ${K8S_NAMESPACE} upgrade --install --create-namespace \
--set "eckElasticsearch.params.ingress.hostname=${ELASTICSEARCH_URL}" \
--set "eckPackageRegistry.params.ingress.hostname=repo-${REPO_URL}" \
--set "eckKibana.params.ingress.hostname=${KB_URL}" \
--set "eckApm.params.ingress.hostname=${APM_URL}" \
--set "eckFleet.params.ingress.hostname=${FLEET_URL}" \
--repo https://sourcemation.github.io/charts/ \
--version ${ELASTIC_VER} \
elka elastic



```

# Elastic stack remove


```bash


helm -n ${K8S_NAMESPACE} uninstall elka

helm -n lp-operators uninstall elastic-operator-crds
helm -n lp-operators uninstall elastic-operator

```


# For developers


```bash 

git clone git@github.com:SourceMation/charts.git

cd charts/charts/elastic/1.1.0

kubectl config set-context --current --namespace ${K8S_NAMESPACE}

helm -n ${K8S_NAMESPACE} upgrade --install --create-namespace elka .

```
