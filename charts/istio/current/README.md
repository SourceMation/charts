# Useful links
- https://istio.io
- https://github.com/istio/istio
- https://istio.io/latest/docs/setup/platform-setup/prerequisites/ - Important - Kernel Module Requirements on Cluster Nodes

# Loading modules into the kernel

edit the following as needed
``` bash
cat <<EOF > /etc/modules
<MODULE1>
<MODULE2>
[...]
EOF
```
# Installation
## Preparation
``` bash

export CHART_NAMESPACE=istio-system
export JAEGER_COLLECTOR_ADDRESS=jaeger.example.com
export CHART_VERSION=1.21.0
kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace=${CHART_NAMESPACE}

```
## Installation via helm
``` bash

helm upgrade --install -n ${CHART_NAMESPACE} base --set defaultRevision=default --repo https://istio-release.storage.googleapis.com/charts base --version ${CHART_VERSION}


helm upgrade --install istiod \ 
-n ${CHART_NAMESPACE} \
--set "meshConfig.defaultConfig.tracking.zipkin.address=${JAEGER_COLLECTOR_ADDRESS}:9411" \
-f https://raw.githubusercontent.com/sourcemation/charts/main/charts/istio/${CHART_VERSION}/values \
--repo https://istio-release.storage.googleapis.com/charts base --version ${CHART_VERSION}
```
