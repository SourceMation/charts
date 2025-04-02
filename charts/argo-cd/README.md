## General

### Are you looking for more information?

1. Documentation: https://argo-cd.readthedocs.io 
2. Chart Source: https://github.com/argoproj/argo-helm 

## Before Installation

The installation of cert-manager is required according to the instructions
provided in the README file of the latest version:
https://github.com/SourceMation/charts/tree/main/charts/cert-manager

## After Installation

> **Note:**
> no action required
## Before Upgrade

> **Note:**
> no action required
## After Upgrade

> **Note:**
> no action required
## Tips and Tricks

> **Note:**
> no tips and tricks
## Known Issues

> **Note:**
> Notify us: https://github.com/SourceMation/charts/issues
## CLI installation

### Preparation

```bash
export CHART_NAME=argo-cd
export CHART_VERSION=0.1.0
export CHART_NAMESPACE=lp-system

export CHART_URL=argo-cd.apps.example.com
export CERT_ISSUER_NAME=default-selfsigned-ca
export CERT_ISSUER_KIND=ClusterIssuer

kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace ${CHART_NAMESPACE}

cat << EOF > /tmp/values.yaml
argocd:
  global:
    domain: "${CHART_URL}$"
  server:
    ingress:
      enabled: true
      tls: true
    certificate:
      enabled: true
      issuer:
        group: "cert-manager.io"
        kind: "${CERT_ISSUER_KIND}"
        name: "${CERT_ISSUER_NAME}"
EOF
```

### Go go helm

``` bash
helm -n ${CHART_NAMESPACE} upgrade --install ${CHART_NAME} \
--repo https://sourcemation.github.io/charts/ ${CHART_NAME} \
--values /tmp/values.yaml  \
--version ${CHART_VERSION}
```

### Validation and Testing

```bash
kubectl -n ${CHART_NAMESPACE} get po
kubectl get crd | grep argoproj
```

## CLI removing

```bash
helm uninstall -n ${CHART_NAMESPACE} ${CHART_NAME}
kubectl delete -n ${CHART_NAMESPACE} secret/argocd-redis
```
