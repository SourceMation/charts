# Useful links / Przydatne linki
- https://istio.io
- https://www.jaegertracing.io
- https://github.com/rancher/charts

# Installation / Instalacja
## Preparation / Przygotowanie
```bash

export CHART_NAMESPACE=<desired namespace>
export CHART_VERSION=<chart version>
export ELASTICSEARCH_URL=elastic-tst.apps.example.com
export REPO_URL=repo-tst.apps.example.com
export KB_URL=kibana-tst.apps.example.com
export APM_URL=apm-tst.apps.example.com
export FLEET_URL=fleet-tst.apps.example.com
export COLLECTOR_ADDRESS=jaeger-collector.example.com
export JAEGER_INGRESS_ADDRESS=jaeger.example.com

kubectl create ns ${CHART_NAMESPACE}
kubectl create ns istio-system
```

## Create file with values / Przygotuj plik z parametrami do przekazania

```bash
cat << EOF > /tmp/jaeger.yaml
jaeger:
  agent:
    extraEnv:
      - name: REPORTER_GRPC_HOST_PORT
        value: ${COLLECTOR_ADDRESS}:14250
```


## Installation via helm / Instalacja przy użyciu helm
``` bash
helm -n ${CHART_NAMESPACE} upgrade --install obs-stack-v1-app \
 --set "elastic.eckElasticsearch.params.ingress.hostname=${ELASTICSEARCH_URL}" \
 --set "elastic.eckPackageRegistry.params.ingress.hostname=repo-${REPO_URL}" \
 --set "elastic.eckKibana.params.ingress.hostname=${KB_URL}" \
 --set "elastic.eckApm.params.ingress.hostname=${APM_URL}" \
 --set "elastic.eckFleet.params.ingress.hostname=${FLEET_URL}" \
 --set "istiod.meshConfig.defaultConfig.tracing.zipkin.address=${COLLECTOR_ADDRESS}:9411" \
 --set "jaeger.query.ingress.hosts[0]=${JAEGER_INGRESS_ADDRESS}" \
 -f /tmp/jaeger.yaml \
 --repo https://sourcemation.github.io/charts/ obs-stack-v1-app
```
