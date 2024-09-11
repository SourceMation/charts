## Info
This chart is based on community helm chart.

https://github.com/argoproj/argo-helm

### Add helm repository
> helm repo add argo https://argoproj.github.io/argo-hel

### Update repositories
> helm repo update

### Instalation
> export ARGOCD_NAMESPACE=argocd
> kubectl create ns ${ARGOCD_NAMESPACE}
> kubectl config set-context --current --namespace ${ARGOCD_NAMESPACE}
> helm install argocd argo/argo-cd -f dev-values.yaml -n ${ARGOCD_NAMESPACE}

### Dry run
> helm upgrade argocd argo/argo-cd -f dev-values.yaml -n ${ARGOCD_NAMESPACE} --dry-run=client |less

### Diff upgrade
Install diff plugin: 

> helm plugin install https://github.com/databus23/helm-diff


> helm diff upgrade argocd argo/argo-cd -f dev-values.yaml -n ${ARGOCD_NAMESPACE}


Output shows what changes will be applied in git-diff look like format.
