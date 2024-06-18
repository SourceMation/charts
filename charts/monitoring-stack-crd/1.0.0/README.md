# Useful links / Przydatne linki
- https://istio.io
- https://www.jaegertracing.io
- https://ranchermanager.docs.rancher.com/integrations-in-rancher/monitoring-and-alerting
- https://github.com/rancher/charts

# Installation / Instalacja
## Preparation / Przygotowanie
```bash

export CHART_NAMESPACE=<operator namespace>
export CHART_VERSION=<chart version>
export APP_NAMESPACE=<namespace where monitoring-stack-app will be installed>
kubectl create ns ${CHART_NAMESPACE}
```
## Installation via helm / Instalacja przy użyciu helm
``` bash
helm -n ${CHART_NAMESPACE} upgrade --install monitoring-stack-crd \
--set "base.global.istioNamespace=${APP_NAMESPACE}" \
--set "eck-operator.installCRDs=false" \
--set "eck-operator.createClusterScopedResources=true" \
--set "eck-operator.webhook.enabled=false" \
--set "eck-operator.config.validateStorageClass=false" \
--repo https://sourcemation.github.io/charts/ monitoring-stack-crd
```
