## For developers


```bash
git clone git@github.com:SourceMation/charts.git
cd charts/charts/elastic-agent/${CHART_VER}

kubectl create ns ${CHART_NAMESPACE} 
kubectl config set-context --current --namespace kube-system

helm -n ${CHART_NAMESPACE} upgrade --install ${CHART_RELEASE_NAME}-agent \
--set "elasticAgent.params.fleetEnrollmentToken=${AGENT_FLEET_ENROLLMENT_TOKEN}" \
--set "elasticAgent.params.fleetUrl=${AGENT_FLEET_URL}" \
--set "additionalTrustedCASecret=elastic-agent-ca" \
--set "nameOverride=${CHART_RELEASE_NAME}" .
```
