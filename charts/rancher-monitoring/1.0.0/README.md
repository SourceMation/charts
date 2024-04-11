# Useful links
- https://github.com/rancher/charts #search for rancher-monitoring and rancher-monitoring-crd in packeages and charts
- https://ranchermanager.docs.rancher.com/integrations-in-rancher/monitoring-and-alerting

# Installation
## Preparation
``` bash
export CHART_NAMESPACE=cattle-monitoring-system
export CLUSTER_NAME=<cluster name> 
export RANCHER_URL=<rancher_url>
export CHART_VERSION=102.0.0+up40.1.2

kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace=${CHART_NAMESPACE}
```

## Installation via helm
``` bash
helm upgrade --install rancher-monitoring-crd \
 --set "global.cattle.clusterName=${CLUSTER_NAME}" \
 --set "global.cattle.url=url=${RANCHER_URL}" \
 --repo https://charts.rancher.io rancher-monitoring-crd --version ${CHART_VERSION} \

helm install rancher-monitoring --repo https://charts.rancher.io rancher-monitoring --version ${CHART_VERSION}
```
