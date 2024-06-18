# Useful links / Przydatne linki
- https://github.com/neuvector/neuvector
- https://github.com/neuvector/neuvector-helm
- https://kubearmor.io
- https://docs.kubearmor.io/kubearmor/quick-links/deployment_guide
- https://github.com/kubearmor/KubeArmor
- https://charts.kubewarden.io/
- https://cert-manager.io/
- https://github.com/cert-manager/cert-manager
- https://cert-manager.io/docs/installation/helm/

# Installation / Instalacja
## Preparation / Przygotowanie
```bash
export CHART_NAMESPACE=<operator namespace>
export CHART_VERSION=<chart version>
export APP_NAMESPACE=<namespace where security-stack-crd will be installed>
kubectl create ns ${CHART_NAMESPACE}

## Installation via helm / Instalacja przy użyciu helm
```bash
helm -n ${CHART_NAMESPACE} upgrade --install security-stack-crd \
--repo https://sourcemation.github.io/charts/ security-stack-crd
```
