# Useful links / Przydatne linki
- https://github.com/cyberark/conjur
- https://github.com/cyberark/conjur-oss-helm-chart/tree/master/conjur-oss
- https://github.com/cyberark/conjur-oss-helm-chart/releases

# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export CHART_NAMESPACE=conjur
export CHART_VERSION=2.0.7
export CHART_DATA_KEY="$(docker run --rm cyberark/conjur data-key generate)"
# kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace=${CHART_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm
```bash
helm upgrade --install conjur \
   --set dataKey="$CHART_DATA_KEY" \
   https://github.com/cyberark/conjur-oss-helm-chart/releases/download/v${CHART_VERSION}/conjur-oss-${CHART_VERSION}.tgz 
```
