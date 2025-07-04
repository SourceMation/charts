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
export RELEASE_NAME=argo
export CHART_NAME=argo-cd
export CHART_VERSION=0.1.0
export RELEASE_NAMESPACE=argocd

export CHART_URL=argo-cd.apps.example.com
export CERT_ISSUER_NAME=default-selfsigned-ca
export CERT_ISSUER_KIND=ClusterIssuer

kubectl create ns ${RELEASE_NAMESPACE}
kubectl config set-context --current --namespace ${RELEASE_NAMESPACE}

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
helm -n ${RELEASE_NAMESPACE} upgrade --install ${RELEASE_NAME} \
${CHART_NAME} --repo https://charts.sourcemation.com/ \
-f /tmp/values.yaml  \
--version ${CHART_VERSION}
```

### Validation and Testing

```bash
kubectl -n ${RELEASE_NAMESPACE} get po
kubectl get crd | grep argoproj
```

## CLI removing

```bash
helm uninstall -n ${RELEASE_NAMESPACE} ${RELEASE_NAME}
kubectl delete -n ${RELEASE_NAMESPACE} secret/argocd-redis
kubectl get crd -o name | grep -i argoproj | xargs kubectl delete
```
