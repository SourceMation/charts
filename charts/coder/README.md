## General

### Are you looking for more information?

1. Based on: https://github.com/coder/coder.git
2. Documentation: https://coder.com/docs
3. Chart Source: https://github.com/SourceMation/charts.git


## Before Installation

* The installation of cert-manager is required according to the instructions provided in the README file of the latest version: https://github.com/SourceMation/charts/tree/main/charts/cert-manager

* The installation of cloudnative-pg operator is required according to the instructions provided in the README file of the latest version: https://github.com/SourceMation/charts/tree/main/charts/cnpg-operator

* An ingress controller must be installed within the cluster.

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
export RELEASE_NAME=coder
export CHART_NAME=coder
export CHART_VERSION=0.1.0
export RELEASE_NAMESPACE=coder-namespace
export CHART_URL=coder.apps.example.com
export CERT_ISSUER_NAME=default-selfsigned-ca
export CERT_ISSUER_KIND=ClusterIssuer
export CERT_SECRET_NAME=coder-tls-cert


cat <<EOF> /tmp/values.yaml
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
kubectl create ns ${RELEASE_NAMESPACE}
kubectl config set-context --current --namespace ${RELEASE_NAMESPACE}
```

### Go go helm

``` bash
helm -n ${RELEASE_NAMESPACE} upgrade --install ${RELEASE_NAME} \
-f /tmp/values.yaml \
${CHART_NAME} --repo https://sourcemation.github.io/charts/ \
--version ${CHART_VERSION}
```

### Validation and Testing

```bash
kubectl -n ${RELEASE_NAMESPACE} get po
```

## CLI removing

```bash
helm -n ${RELEASE_NAMESPACE} uninstall ${RELEASE_NAME}
kubectl -n ${RELEASE_NAMESPACE} delete cert ${CERT_SECRET_NAME}
```
