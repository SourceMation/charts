# For developers
 
## Installing from repo
 
```bash
export RELEASE_NAME=example-app
export CHART_NAME=example-chart
export RELEASE_NAMESPACE=example-namespace

git clone git@github.com:Sourcemation/charts.git
cd charts/charts/${CHART_NAME}/


kubectl create ns ${RELEASE_NAMESPACE}
kubectl config set-context --current --namespace ${RELEASE_NAMESPACE}


cat << EOF > /tmp/values.yaml
example-app:
  ingress:
    host: 
    - url: app.example.com
EOF


helm -n ${RELEASE_NAMESPACE} upgrade --install ${RELEASE_NAME} . \
-f /tmp/values.yaml
```

## Cleaning

```bash
helm uninstall -n ${RELEASE_NAMESPACE} ${RELEASE_NAME}
kubectl delete apiservice v1beta1.webhook.example-chart.io
kubectl get crd -o name | grep -i ${CHART_NAME} | xargs kubectl delete
```


## Testing

```bash
kubectl -n ${RELEASE_NAMESPACE} get po,deploy,svc,sts,cm,secret
helm -n ${RELEASE_NAMESPACE} test ${RELEASE_NAME}
```
