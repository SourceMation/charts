# For developers / Dla deweloperow 
 
## Installing from repo / Instalacja z repo 
 
```bash 
git clone git@github.com:SourceMation/charts.git
cd charts/elastic-operator/

export CHART_NAMESPACE=lp-system 
 
helm -n ${CHART_NAMESPACE} upgrade --install \
--create-namespace \ 
elastic-operator .  
``` 

#kubectl get crd -o name | grep -i istio | xargs kubectl delete
#kubectl get crd -o name | grep -i jaeger | xargs kubectl delete
#kubectl get crd -o name | grep -i opentelemetry | xargs kubectl delete
#kubectl get validatingwebhookconfiguration -o name | grep -i istio | xargs kubectl delete
#kubectl get mutatingwebhookconfiguration -o name | grep -i istio | xargs kubectl delete
