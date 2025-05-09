
# Elastic agent installation

1. Prepare CAs for elastic and kibana
2. Add CAs to /tmp/remote.ca.crt file
3. Create secret in kube-system namespace 

```bash

kubectl -n kube-system create secret generic elastic-agent-ca \
--from-file=ca.crt=/tmp/remote.ca.crt -o yaml --dry-run=client | kubectl apply -f -

```

4. Login to Kibana 
5. Prepare fleet url
6. Go to Management -> Fleet -> Settings -> Fleet server hosts
7. Prepare enrollnment token for Elastic Agent Kubernetes
8. Go to Management -> Fleet -> Enrollment tokens 
9. Show token for Agent Kubernetes Policy on RKE2

10. Install helm chart 

```bash

export ELASTIC_VER=1.1.0
export FLEET_URL=fleet-tst.apps.example.com
export FLEET_ENROLLMENT_TOKEN='VU04YVZvOEJ1b2RyOVZtSERkZDM6cjltOHRGN3hSUDJhb1BvU2pnelBBUQ=='

helm -n ${K8S_NAMESPACE} upgrade --install --create-namespace \
--set "elasticAgent.params.fleetEnrollmentToken=${FLEET_ENROLLMENT_TOKEN}" \
--set "elasticAgent.params.fleetUrl=${FLEET_URL}" \
--set "additionalTrustedCASecret=elastic-agent-ca" \
--repo https://charts.sourcemation.com/ \
--version ${ELASTIC_VER} \
elka-agent elastic-agent

```

# For developers


```bash

git clone git@github.com:SourceMation/charts.git

cd charts/charts/elastic-agent/1.1.0

kubectl config set-context --current --namespace kube-system

helm -n kube-system  upgrade --install elka-agent . \
--set "elasticAgent.params.fleetEnrollmentToken=${FLEET_ENROLLMENT_TOKEN}" \
--set "elasticAgent.params.fleetUrl=${FLEET_URL}" \
--set "additionalTrustedCASecret=elastic-agent-ca"

```

