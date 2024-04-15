# Useful links
- https://www.jaegertracing.io
- https://github.com/jaegertracing/jaeger
- https://github.com/jaegertracing/helm-charts
- https://jaegertracing.github.io/helm-charts

# Installation
## Preparation
```bash


export CHART_NAMESPACE=jaeger
export CHART_VERSION=2.0.1
export INGRESS_ADDRESS=jaeger.example.com

kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace=${CHART_NAMESPACE}

```
## Installation via helm
``` bash
helm upgrade --install jaeger \
 -n ${CHART_NAMESPACE}
 --set "query.ingress.hosts[0]=${INGRESS_ADDRESS}" \ 
 -f https://raw.githubusercontent.com/sourcemation/charts/main/charts/jaeger/${CHART_VERSION}/values \
 jaeger \ 
 --repo https://jaegertracing.github.io/helm-charts --version ${CHART_VERSION}
```
