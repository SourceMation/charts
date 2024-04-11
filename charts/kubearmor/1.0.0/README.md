# Useful links / Przydatne linki
- https://kubearmor.io
- https://docs.kubearmor.io/kubearmor/quick-links/deployment_guide
- https://github.com/kubearmor/KubeArmor

# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export CHART_NAMESPACE=kubearmor
export CHART_VERSION=1.3.2
# kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace=${CHART_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm
```bash
helm upgrade --install kubearmor-operator --repo https://kubearmor.github.io/charts kubearmor-operator --version ${CHART_VERSION}
kubectl apply -f https://raw.githubusercontent.com/kubearmor/KubeArmor/main/pkg/KubeArmorOperator/config/samples/sample-config.yml
```
