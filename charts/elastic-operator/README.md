## Generic

Based on: https://github.com/elastic/cloud-on-k8s.git  
Doc: https://www.elastic.co/guide/en/cloud-on-k8s/current/index.html  
Source: https://github.com/SourceMation/charts.git  

## Requirements

lack of informations

## Before Installation

no action required

## After Installation

no action required

## Before Upgrade

no action required

## After Upgrade

no action required


## Known Issues

### Different namespace or release-name

Example:
```
Error: Unable to continue with install: CustomResourceDefinition "agents.agent.k8s.elastic.co" in namespace "" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "elk-operator": current value is "elastic-operator"
```

> Set either matching namespace and release-name
> 
> or
> 
> delete old CRDs.

## CLI installation

### Preparation

```bash
export RELEASE_NAME=elk-operator
export CHART_NAME=elastic-operator
export RELEASE_NAMESPACE=lp-system
export CHART_VERSION=1.5.1

kubectl create ns ${RELEASE_NAMESPACE}
kubectl config set-context --current --namespace ${RELEASE_NAMESPACE}
```

### Go go helm

```bash
helm upgrade --install ${RELEASE_NAME} \
${CHART_NAME} --repo https://charts.sourcemation.com/ \
--version ${CHART_VERSION} -n ${RELEASE_NAMESPACE}
```

## CLI removing

```bash
helm -n ${RELEASE_NAMESPACE} uninstall ${RELEASE_NAME}

kubectl get crd -o name | grep -i 'k8s\.elastic\.co$'  | xargs kubectl delete
```
