## General

### Are you looking for more information?

1. Documentation: https://istio.io/latest/docs/
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

export CHART_URL=istiod.apps.example.com

kubectl create ns istio-system
kubectl config set-context --current --namespace istio-system

```

### Go go helm

``` bash

cat << EOF > /tmp/values.yaml
global:
  istioNamespace: istio-system
jaeger:
  query:
    ingress:
      enabled: true
      hosts:
        - "${CHART_URL}"
EOF

helm install vaix -n istio-system -f /tmp/values.yaml .

```

### Validation and Testing

```bash

kubectl -n istio-system get po

```

## CLI removing

```bash

helm -n istio-system uninstall vaix


```

