# Useful links / Przydatne linki
- https://kyverno.io/
- https://kyverno.io/docs/installation/methods/
- https://kyverno.github.io/kyverno/

# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export CHART_NAMESPACE=kyverno
export CHART_VERSION=3.0.7
kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace=${CHART_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm
```bash
helm upgrade --install kyverno \
 -n ${CHART_NAMESPACE} \
 -f https://raw.githubusercontent.com/sourcemation/charts/main/charts/kyverno/${CHART_VERSION}/values \
 --repo https://kyverno.github.io/kyverno/  kyverno --version ${CHART_VERSION}
```
