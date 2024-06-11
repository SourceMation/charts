# Elastic Agent Client


## Elastic agent - installation

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

export ELASTIC_VER=1.2.1
export CLUSTER_NAME=elk
export K8S_NAMESPACE=elastic-tst
export AGENT_FLEET_URL=https://fleet-tst.apps.example.com:443
export AGENT_FLEET_ENROLLMENT_TOKEN=''

kubectl create ns ${K8S_NAMESPACE}

helm -n ${K8S_NAMESPACE} upgrade --install --create-namespace \
--set "elasticAgent.params.fleetEnrollmentToken=${AGENT_FLEET_ENROLLMENT_TOKEN}" \
--set "elasticAgent.params.fleetUrl=${AGENT_FLEET_URL}" \
--set "additionalTrustedCASecret=elastic-agent-ca" \
--set "nameOverride=${CLUSTER_NAME}" \
--repo https://sourcemation.github.io/charts/ \
--version ${ELASTIC_VER} \
${CLUSTER_NAME}-agent elastic-agent


kubectl -n kube-system get po -o wide -l app=elastic-agent
kubectl -n kube-system get po -o wide -l app.kubernetes.io/name=kube-state-metrics

kubectl -n kube-system logs deploy/kube-state-metrics
kubectl -n kube-system logs ds/elastic-agent

```


## Elastic agent - remove


```bash

helm -n ${K8S_NAMESPACE} uninstall ${CLUSTER_NAME}-agent

kubectl -n ${K8S_NAMESPACE} get po 

```


## For developers


```bash

git clone git@github.com:SourceMation/charts.git

cd charts/charts/elastic-agent/${ELASTIC_VER}

kubectl create ns ${K8S_NAMESPACE}

kubectl config set-context --current --namespace kube-system

helm -n ${K8S_NAMESPACE} upgrade --install ${CLUSTER_NAME}-agent . \
--set "elasticAgent.params.fleetEnrollmentToken=${AGENT_FLEET_ENROLLMENT_TOKEN}" \
--set "elasticAgent.params.fleetUrl=${AGENT_FLEET_URL}" \
--set "additionalTrustedCASecret=elastic-agent-ca" \
--set "nameOverride=${CLUSTER_NAME}"


```

