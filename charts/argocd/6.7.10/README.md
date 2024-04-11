# Useful links / Przydatne linki
- https://argo-cd.readthedocs.io/en/stable/operator-manual/installation/
- https://github.com/argoproj/argo-helm/tree/main/charts/argo-cd
- https://github.com/argoproj/argo-cd

# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export ARGOCD_NAMESPACE=argocd
export CHART_VERSION=6.7.10
export DOMAIN_ADDRESS=examaple.com

kubectl create ns ${ARGOCD_NAMESPACE}
kubectl config set-context --current --namespace=${ARGOCD_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm
```bash
helm upgrade --install argocd \
 -n ${ARGOCD_NAMESPACE} \
 -f https://raw.githubusercontent.com/linuxpolska/charts/main/charts/argocd/6.7.10/values \
 --set "global.domain=${DOMAIN_ADDRESS}" \
 --repo https://argoproj.github.io/argo-helm argo-cd --version ${CHART_VERSION} 
```
