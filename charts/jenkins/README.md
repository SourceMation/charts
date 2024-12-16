## General

### Are you looking for more information?

1. Documentation: https://charts.jenkins.io
2. Chart Source: https://github.com/SourceMation/charts.git

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

export CHART_NAMESPACE=jenkins-namespace
export CHART_URL=jenkins.apps.example.com

kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace ${CHART_NAMESPACE}

```

### Go go helm

``` bash

cat << EOF > /tmp/values.yaml
jenkins:
  params:
    ingress:
      hostName: "${CHART_URL}"
  controller:
    jenkinsUrl: "https://${CHART_URL}"
EOF

cd charts/charts/jenkins
helm -n ${CHART_NAMESPACE} upgrade --install jenkins -f /tmp/values.yaml .

```

### Validation and Testing

```bash

kubectl -n ${CHART_NAMESPACE} get po

```

## CLI removing

```bash

helm -n ${CHART_NAMESPACE} uninstall jenkins


```

## Image

A copy of the image is already in place to protect our clients against hostile
takeovers or project shutdowns, providing an additional layer of security.

