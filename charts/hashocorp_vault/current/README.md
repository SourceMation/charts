# Useful links / Przydatne linki
- https://github.com/hashicorp/vault-helm
- git clone https://github.com/hashicorp/vault-helm.git

# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export CHART_VERSION=0.27.0
export CHART_NAMESPACE=hashicorp-vault
export INGRESS_HOST=vault.example.com
kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace=${CHART_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm
```bash
helm upgrade --install vault \
-n ${CHART_NAMESPACE} \
--set server.ingress.hosts[0].host="${INGRESS_HOST}" \
-f  https://raw.githubusercontent.com/sourcemation/charts/main/charts/hashocorp_vault/${CHART_VERSION}/values \
vault \
--repo https://helm.releases.hashicorp.com --version ${CHART_VERSION}
```


## Init and unseal

```bash
kubectl --namespace ${CHART_NAMESPACE} exec -ti vault-0 -- vault operator init
kubectl --namespace ${CHART_NAMESPACE} exec -ti vault-0 -- vault operator unseal # repeat 3 times for first 3 keys /powtórzyć 3 razy dla 3 pierwszych kluczy
```
