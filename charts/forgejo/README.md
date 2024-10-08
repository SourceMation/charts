## General

### Are you looking for more information?

1. Documentation: https://codeberg.org/forgejo-contrib/forgejo-helm
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

export CHART_NAMESPACE=forgejo-namespace
export CHART_URL=forgejo.apps.example.com

kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace ${CHART_NAMESPACE}


```

### Go go helm

``` bash

cat << EOF > /tmp/values.yaml
forgejo:
  ingress:
    enabled: true
    hosts:
      - host: "${CHART_URL}"
        paths:
        - path: "/"
          pathType: "Prefix"
EOF

cd charts/charts/forgejo/
helm upgrade --install forgejo -n ${CHART_NAMESPACE} -f /tmp/values.yaml .


```

### Validation and Testing

```bash

kubectl -n ${CHART_NAMESPACE} get po


```

## CLI removing

```bash

helm -n ${CHART_NAMESPACE} uninstall forgejo


```

