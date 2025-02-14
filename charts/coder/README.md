## General

### Are you looking for more information?

1. Based on: https://github.com/coder/coder.git
2. Documentation: https://coder.com/docs
3. Chart Source: https://github.com/SourceMation/charts.git


## Before Installation

Installation of [**cert-manager**](https://github.com/SourceMation/charts/tree/main/charts/cert-manager) and [**cnpg-operator**](https://github.com/SourceMation/charts/tree/main/charts/cnpg-operator) is required.  
Follow the instructions in the README file of the latest versions.


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
export CHART_NAME=coder
export CHART_VERSION=1.0.0
export CHART_NAMESPACE=coder-namespace
export CHART_URL=coder.apps.example.com
export CERT_ISSUER_NAME=default-selfsigned-ca
export CERT_ISSUER_KIND=ClusterIssuer
export CERT_SECRET_NAME=coder-tls-cert


cat <<EOF> /tmp/coder-values.yaml
coder:
  coder:
    ingress:
      host: "${CHART_URL}"
      tls:
        issuerName: "${CERT_ISSUER_NAME}"
        issuerKind: "${CERT_ISSUER_KIND}"
        secretName: "${CERT_SECRET_NAME}"
EOF
```

```bash
kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace ${CHART_NAMESPACE}
```

### Go go helm

``` bash
helm -n ${CHART_NAMESPACE} upgrade --install ${CHART_NAME} \
--values /tmp/coder-values.yaml \
--repo https://sourcemation.github.io/charts/ ${CHART_NAME} \
--version ${CHART_VERSION}
```

### Validation and Testing

```bash
kubectl -n ${CHART_NAMESPACE} get po
```

## CLI removing

```bash
helm -n ${CHART_NAMESPACE} uninstall ${CHART_NAME}
kubectl -n ${CHART_NAMESPACE} delete cert ${CERT_SECRET_NAME}
```
