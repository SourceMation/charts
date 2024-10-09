## General

### Are you looking for more information?

1. Based on: https://github.com/SonarSource/sonarqube.git
2. Documentation: https://docs.sonarsource.com/sonarqube/latest/
3. Chart Source: https://github.com/SourceMation/charts.git


## Before Installation

The installation of cert-manager is required according to the instructions provided in the README file of the latest version: https://github.com/SourceMation/charts/tree/main/charts/cert-manager

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

export STACK_NAME=sonarqube
export CHART_VERSION=1.0.0
export CHART_NAMESPACE=sonarqube-namespace
export CHART_URL=sonarqube.apps.example.com
export CERT_SECRET_NAME=default-secret-name

kubectl create ns ${CHART_NAMESPACE}

kubectl config set-context --current --namespace ${CHART_NAMESPACE}

```

### Go go helm

``` bash

helm -n ${CHART_NAMESPACE} upgrade --install ${STACK_NAME} \
--set "sonarqube.ingress.hosts[0].name=${CHART_URL}" \
--set "sonarqube.ingress.tls[0].hosts[0]=${CHART_URL}" \
--set "sonarqube.ingress.tls[0].secretName=${CERT_SECRET_NAME}" \
--repo https://sourcemation.github.io/charts/ ${STACK_NAME} \
--version ${CHART_VERSION}

```

### Validation and Testing

```bash

kubectl -n ${CHART_NAMESPACE} get po

```

## CLI removing

```bash

helm -n ${CHART_NAMESPACE} uninstall ${STACK_NAME}

```