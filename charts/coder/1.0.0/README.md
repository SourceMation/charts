# Useful links / Przydatne linki
- https://github.com/SourceMation/charts/blob/main/charts/coder/current/README.md

# CLI Installation / CLI Instalacja

## Preparation / Przygotowanie

```bash

export STACK_NAME=coder
export CHART_VERSION=1.0.0
export K8S_NAMESPACE=lp-app
export CODER_URL=coder.apps.example.com

```

## Create file with values / Przygotuj plik z parametrami do przekazania

```bash

```


## Installation via helm / Instalacja przy użyciu helm

``` bash

helm -n ${K8S_NAMESPACE} upgrade --install ${STACK_NAME} \
--set "coder.coder.ingress.host=${CODER_URL}" \
--repo https://sourcemation.github.io/charts/ ${STACK_NAME} \
--version ${CHART_VERSION}

```



# For developers

```bash


cd charts/coder/${CHART_VERSION}


cat <<EOF> /tmp/coder.yaml
coder:
  coder:
    ingress:
      host: "coder.apps.example.com"
EOF


helm -n ${K8S_NAMESPACE} upgrade --install --create-namespace coder . \
-f /tmp/coder.yaml

```
