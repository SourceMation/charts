## Generic

Based on: https://github.com/elastic/cloud-on-k8s.git  
Doc: https://www.elastic.co/guide/en/cloud-on-k8s/current/index.html  
Source: https://github.com/Sourcemation/charts.git  

## Requirements

no action required

## Before Installation

1. Install chart via Apps: Elastic - Apps (2/3)
2. Prepare CAs for elastic and kibana
3. Add CAs to /tmp/remote.ca.crt file
4. Create secret in kube-system namespace 

```bash
kubectl -n kube-system create secret generic elastic-agent-ca \
--from-file=ca.crt=/tmp/remote.ca.crt -o yaml --dry-run=client | kubectl apply -f -
```

5. Prepare Fleet Agent URL

* Login to Kibana 
* Go to Management -> Fleet -> Settings -> Fleet server hosts

6. Prepare Fleet enrolnment token

* Go to Management -> Fleet -> Enrollment tokens 
* Show token for Agent Kubernetes Policy on RKE2


## After Installation

no action required

## Before Upgrade

no action required

## After Upgrade

no action required

## Tips and Tricks

no action required

## Known Issues

lack of known issues


## CLI installation

### Preparation

```bash
export RELEASE_NAME=elk-agent
export CHART_NAME=elastic-agent
export RELEASE_NAMESPACE=kube-system
export CHART_VER=1.4.0

export AGENT_FLEET_URL=https://fleet-tst.apps.example.com:443
export AGENT_FLEET_ENROLLMENT_TOKEN=''

kubectl create ns ${RELEASE_NAMESPACE}
kubectl config set-context --current --namespace ${RELEASE_NAMESPACE}
```

### Go go helm

```bash
helm -n ${RELEASE_NAMESPACE} upgrade --install ${RELEASE_NAME} \
--set "elasticAgent.params.fleetEnrollmentToken=${AGENT_FLEET_ENROLLMENT_TOKEN}" \
--set "elasticAgent.params.fleetUrl=${AGENT_FLEET_URL}" \
--set "additionalTrustedCASecret=elastic-agent-ca" \
--set "nameOverride=${RELEASE_NAME}" \
${CHART_NAME} --repo https://charts.sourcemation.com/ \
--version ${CHART_VER}
```

### Validation and Testing

```bash
kubectl -n kube-system get po -o wide -l app=elastic-agent
kubectl -n kube-system get po -o wide -l app.kubernetes.io/name=kube-state-metrics

kubectl -n kube-system logs deploy/kube-state-metrics
kubectl -n kube-system logs ds/elastic-agent
```

## CLI removing

```bash
helm -n ${RELEASE_NAMESPACE} uninstall ${RELEASE_NAME}
```
