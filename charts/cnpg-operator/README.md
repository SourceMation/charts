## General

### Are you looking for more information?

1. Based on: https://github.com/cloudnative-pg/cloudnative-pg.git
2. Documentation: https://cloudnative-pg.io/docs/
3. Chart Source: https://github.com/cloudnative-pg/charts.git


## Before Installation


> **Note:**
> no action required


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
#### Error: Unable to continue with install: ConfigMap "cnpg-controller-manager-config" in namespace "lp-system" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "aaaa": current value is "bbbb"

Reason: Helm is trying to install a release named 'aaaa', but there’s already a resource (ConfigMap cnpg-controller-manager-config) in the lp-system namespace that belongs to another Helm release called 'bbbb'.

Soloution:

1. Use the same release name as before (bbbb)

```bash
helm upgrade --install bbbb -n lp-system ...
```

2. Delete the old Helm release (if you don’t need it)

```bash
helm uninstall bbbb -n lp-system
```


## CLI installation

### Preparation

```bash

export CHART_NAMESPACE=lp-system
export CHART_VERSION=0.2.2

kubectl create ns ${CHART_NAMESPACE}

kubectl config set-context --current --namespace ${CHART_NAMESPACE}

```

### Go go helm

``` bash
cat << EOF > /tmp/values.yaml

EOF


helm -n ${CHART_NAMESPACE} upgrade --install cnpg-operator \
--repo https://charts.sourcemation.com/ \
cnpg-operator \
-f /tmp/values.yaml \
--version ${CHART_VERSION}

```

### Validation and Testing

```bash

kubectl -n ${CHART_NAMESPACE} get po
helm -n ${CHART_NAMESPACE} test cnpg-operator

```

## CLI removing

```bash

helm -n ${CHART_NAMESPACE} uninstall cnpg-operator


```

