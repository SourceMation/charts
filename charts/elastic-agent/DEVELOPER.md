## For developers

## Installing from repo

```bash
export RELEASE_NAME=elk-agent
export CHART_NAME=elastic-agent
export RELEASE_NAMESPACE=kube-system

git clone git@github.com:SourceMation/charts.git
cd charts/charts/${CHART_NAME}

kubectl create ns ${RELEASE_NAMESPACE} 
kubectl config set-context --current --namespace kube-system

helm -n ${RELEASE_NAMESPACE} upgrade --install ${RELEASE_NAME} . \
--set "elasticAgent.params.fleetEnrollmentToken=${AGENT_FLEET_ENROLLMENT_TOKEN}" \
--set "elasticAgent.params.fleetUrl=${AGENT_FLEET_URL}" \
--set "additionalTrustedCASecret=elastic-agent-ca" \
--set "nameOverride=${RELEASE_NAME}"
```

## Cleaning

```bash
helm -n ${RELEASE_NAMESPACE} uninstall ${RELEASE_NAME}
```
