## For developers


```bash
export RELEASE_NAME=elk
export CHART_NAME=elastic
export RELEASE_NAMESPACE=elastic-tst                  
export CHART_VER=1.4.0

export ELASTICSEARCH_URL=elastic-tst.apps.example.com
export REPO_URL=repo-tst.apps.example.com
export KB_URL=kibana-tst.apps.example.com
export APM_URL=apm-tst.apps.example.com
export FLEET_URL=fleet-tst.apps.example.com
export ENT_URL=esearch-tst.apps.example.com                         

git clone git@github.com:SourceMation/charts.git
cd charts/charts/${CHART_NAME}

kubectl create ns ${RELEASE_NAMESPACE}
kubectl config set-context --current --namespace ${RELEASE_NAMESPACE}

helm -n ${RELEASE_NAMESPACE} upgrade --install ${RELEASE_NAME} . \
--set "elasticsearch.params.ingress.hostname=${ELASTICSEARCH_URL}" \
--set "packageRegistry.params.ingress.hostname=${REPO_URL}" \
--set "kibana.params.ingress.hostname=${KB_URL}" \
--set "agentServices.params.roles.apm.ingress.hostname=${APM_URL}" \
--set "agentFleet.params.ingress.hostname=${FLEET_URL}"
```
