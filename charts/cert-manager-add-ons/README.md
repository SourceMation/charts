## General

### Are you looking for more information?

1. Based on: https://github.com/cert-manager/cert-manager.git

2. Documentation: 
* https://cert-manager.io/docs/
* https://github.com/nokia/adcs-issuer

3. Chart Source:
* https://github.com/nokia/adcs-issuer 


## Before Installation

1. Install Cert-manager (1/3) - Operator


## After Installation

> **Note:**
> no action required

## Before Upgrade

> **Note:**
> no action required

## After Upgrade

> **Note:**
> no action required


## Tips and Tricks

> **Note:**
> no tips and tricks


## Known Issues

#### Error: Unable to continue with install: CustomResourceDefinition "adcsissuers.adcs.certmanager.csf.nokia.com" in namespace "" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "cert-manager-add-ons": current value is "adcs-issuer"; annotation validation error: key "meta.helm.sh/release-namespace" must equal "cert-manager": current value is "adcs-issuer


Reason: cert-manager is installed in another namespace

Soloution:

1. Active Directory Certificate Services is installed - no needed installation

2. If do not have Active Directory Certificate Services, just clean resources

```bash
helm -n adcs-issuer uninstall adcs-issuer
kubectl get crd -o name | grep -i adcs | xargs kubectl delete
```

#### Error: UPGRADE FAILED: Unable to continue with update: ServiceAccount "trust-manager" in namespace "cert-manager" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "cert-manager-add-ons": current value is "cert-manager-addons"

Reason: cert-manager-add-ons is installed in the same namespace under different release name

Soloution:

1. Check the installed apps in your cluster

```bash
# cert-manager namespace
helm list -n cert-manager

# all namespaces
helm list -A
```

2. Remove the duplicated helm deployment, as the chart can only be installed in the cluster once!

```bash
helm uninstall -n cert-manager cert-manager-addons # duplicated release name
```

3. Upgrade cert-manager-add-ons again


> **Note:**
> Notify us: https://github.com/SourceMation/charts/issues


## CLI installation

### Preparation

```bash
export RELEASE_NAME=cert-manager-add-ons
export CHART_NAME=cert-manager-add-ons
export RELEASE_NAMESPACE=cert-manager
export CHART_VERSION=1.2.0

kubectl create ns ${RELEASE_NAMESPACE}
kubectl config set-context --current --namespace ${RELEASE_NAMESPACE}
```

### Go go helm

``` bash
helm -n ${RELEASE_NAMESPACE} upgrade --install ${RELEASE_NAME} \
${CHART_NAME} --repo https://charts.sourcemation.com/ \
--version ${CHART_VERSION}
```

### Validation and Testing

```bash
kubectl -n ${RELEASE_NAMESPACE} get po
kubectl get ClusterAdcsIssuer,AdcsIssuer -A
```

## CLI removing

```bash
helm -n ${RELEASE_NAMESPACE} uninstall ${RELEASE_NAME}
kubectl get crd -o name | grep -i adcs | xargs kubectl delete
```
