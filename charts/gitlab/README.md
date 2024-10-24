## General

### Are you looking for more information?

1. Based on: https://gitlab.com/gitlab-org/gitlab.git
2. Documentation: https://charts.gitlab.io/
3. Chart Source: https://github.com/SourceMation/charts.git


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
export CHART_NAME=gitlab
export CHART_NAMESPACE=gitlab-namespace
export CHART_VERSION=1.0.0
export URL_DOMAIN="apps.example.com"
export URL_SUFFIX="prod"
export CERT_SECRET_NAME="gitlab-server-tls"

kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace ${CHART_NAMESPACE}

```

### Go go helm

``` bash
helm -n ${CHART_NAMESPACE} upgrade --install ${CHART_NAME} \
--set "gitlab.global.hosts.domain=${URL_DOMAIN}" \
--set "gitlab.global.hosts.hostSuffix=${URL_SUFFIX}" \
--set "gitlab.global.ingress.tls.secretName=${CERT_SECRET_NAME}" \
--set "gitlab.gitlab-runner.certsSecretName=${CERT_SECRET_NAME}" \
--repo https://sourcemation.github.io/charts/ ${CHART_NAME} \
--version ${CHART_VERSION}

```

### Validation and Testing

```bash
kubectl -n ${CHART_NAMESPACE} get po,pvc,ingress

```

## CLI removing

```bash
helm -n ${CHART_NAMESPACE} uninstall gitlab
kubectl delete $(kubectl get secret -o name|grep -e 'gitlab')
kubectl delete $(kubectl get pvc -o name|grep -e 'gitlab')

```
