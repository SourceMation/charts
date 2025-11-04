# For developers / Dla deweloperow

## Installing from repo / Instalacja z repo

```bash
export RELEASE_NAME=elk-operator
export CHART_NAME=elastic-operator
export RELEASE_NAMESPACE=lp-system

git clone git@github.com:Sourcemation/charts.git
cd charts/charts/${CHART_NAME}

helm -n ${RELEASE_NAMESPACE} upgrade --install \
--create-namespace \ 
${RELEASE_NAME} .
```

#kubectl get crd -o name | grep -i istio | xargs kubectl delete
#kubectl get crd -o name | grep -i jaeger | xargs kubectl delete
#kubectl get crd -o name | grep -i opentelemetry | xargs kubectl delete
#kubectl get validatingwebhookconfiguration -o name | grep -i istio | xargs kubectl delete
#kubectl get mutatingwebhookconfiguration -o name | grep -i istio | xargs kubectl delete
