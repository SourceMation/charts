# For developers / Dla deweloperow 
 
## Installing from repo / Instalacja z repo 
 
```bash 
 
export CHART_VERSION=1.4.0 
export CHART_NAMESPACE=lp-system 
 
cd charts/elastic-operator/${CHART_VERSION} 
 
 
helm -n ${CHART_NAMESPACE} upgrade --install -n ${CHART_NAMESPACE} --create-namespace \ 
elastic-operator .  
 
``` 

#kubectl get crd -o name | grep -i istio | xargs kubectl delete
#kubectl get crd -o name | grep -i jaeger | xargs kubectl delete
#kubectl get crd -o name | grep -i opentelemetry | xargs kubectl delete
#kubectl get validatingwebhookconfiguration -o name | grep -i istio | xargs kubectl delete
#kubectl get mutatingwebhookconfiguration -o name | grep -i istio | xargs kubectl delete

