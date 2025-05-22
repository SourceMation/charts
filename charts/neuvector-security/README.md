## General

### Are you looking for more information?


1. Documentation: https://open-docs.neuvector.com/policy/groups
2. Chart Source: https://github.com/SourceMation/charts.git


## Before Installation

1. Install NeuVector chart from marketplace


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


#### How to use created groups in your app

1. Sign in to your NeuVector web-ui.
2. Go to Policy -> Groups.
3. Find you app in the list. 
4. Select appropriate group name. For instance: nv.test-app.policy-test.
4. Click "Switch Mode" button.
5. Select "Protect" or "Monitor" depend on selected option during chart installation.



## Known Issues

> **Note:**
> Notify us: https://github.com/SourceMation/charts/issues


## CLI installation

### Preparation

```bash
export RELEASE_NAME=neuvector-sec
export CHART_NAME=neuvector-security
export RELEASE_NAMESPACE=lp-system
export CHART_VERSION=1.0.0

kubectl create ns ${RELEASE_NAMESPACE}
kubectl config set-context --current --namespace ${RELEASE_NAMESPACE}
```

### Go go helm

``` bash
helm -n ${RELEASE_NAMESPACE} upgrade --install ${RELEASE_NAME} \
${CHART_NAME} --repo https://charts.sourcemation.com/ \
-f /tmp/values.yaml \
--version ${CHART_VERSION}
```

### Validation and Testing

```bash
kubectl get nvadmissioncontrolsecurityrules.neuvector.com,nvclustersecurityrules.neuvector.com,nvcomplianceprofiles.neuvector.com,nvdlpsecurityrules.neuvector.com,nvsecurityrules.neuvector.com,nvvulnerabilityprofiles.neuvector.com,nvwafsecurityrules.neuvector.com -A
```

## CLI removing

```bash
helm -n ${RELEASE_NAMESPACE} uninstall ${RELEASE_NAME}
```
