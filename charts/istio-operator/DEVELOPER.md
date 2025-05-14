# For developers
 
## Installing from repo
 
```bash 
export CHART_NAMESPACE=istio-system

cat << EOF > /tmp/values.yaml
global:
    istioNamespace: $CHART_NAMESPACE
EOF

git clone git@github.com:SourceMation/charts.git
cd charts/charts/istio-operator

helm -n ${CHART_NAMESPACE} upgrade --install \
--create-namespace \
istio-operator .
``` 
# Cleaning

```bash
helm uninstall -n ${CHART_NAMESPACE} istio-operator
kubectl get crd -o name | grep -i istio-operator | xargs kubectl delete
```


# Testing

```bash
kubectl -n ${CHART_NAMESPACE} get po

# CREATING ISTIO EXAMPLE APP
export TEST_NAMESPACE=my-example-istio

kubectl create ns ${TEST_NAMESPACE}
kubectl label namespace ${TEST_NAMESPACE} istio-injection=enabled
kubectl -n ${TEST_NAMESPACE} apply -f https://raw.githubusercontent.com/istio/istio/1.22.1/samples/bookinfo/platform/kube/bookinfo.yaml
kubectl -n ${TEST_NAMESPACE} rollout restart deploy details-v1 productpage-v1 ratings-v1 reviews-v1 reviews-v2 reviews-v3
kubectl -n ${TEST_NAMESPACE} get po
kubectl -n ${TEST_NAMESPACE} exec "$(kubectl -n ${TEST_NAMESPACE} get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>"

# GENERATE SAMPLE TRACING
kubectl -n ${TEST_NAMESPACE} exec "$(kubectl -n ${TEST_NAMESPACE} get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- /bin/bash -c 'for i in $(seq 1 100); do curl -s -o /dev/null "http://productpage:9080/productpage"; done'

# CLEANUP
kubectl delete ns ${TEST_NAMESPACE}
```
