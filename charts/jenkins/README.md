## General

### Are you looking for more information?

1. Documentation: https://charts.jenkins.io
2. Chart Source: https://github.com/SourceMation/charts.git

## Before Installation

The installation of cert-manager is required according to the instructions
provided in the README file of the latest version:
https://github.com/SourceMation/charts/tree/main/charts/cert-manager

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

> **Note:**
> Notify us: https://github.com/SourceMation/charts/issues

## CLI installation

### Preparation

```bash
export CHART_NAME=jenkins
export CHART_VERSION=1.0.2
export CHART_NAMESPACE=jenkins

export CHART_URL=jenkins.apps.example.com
export CERT_ISSUER_NAME=default-selfsigned-ca
export CERT_ISSUER_KIND=ClusterIssuer
export CERT_SECRET_NAME=jenkins-tls-cert

kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace ${CHART_NAMESPACE}

cat << EOF > /tmp/values.yaml
jenkins:
  controller:
    ingress:
      hostName: "${CHART_URL}"
      tls:
        - secretName: "${CERT_SECRET_NAME}"
      cert:
        issuerKind: "${CERT_ISSUER_KIND}"
        issuerName: "${CERT_ISSUER_NAME}"
EOF
```

### Go go helm

```bash
helm -n ${CHART_NAMESPACE} upgrade --install ${CHART_NAME} \
--repo https://sourcemation.github.io/charts/  ${CHART_NAME} \
--values /tmp/values.yaml  \
--version ${CHART_VERSION}
```

### Validation and Testing

```bash
kubectl -n ${CHART_NAMESPACE} get po
```

## CLI removing

```bash
helm -n ${CHART_NAMESPACE} uninstall jenkins
kubectl delete certificate "${CHART_NAME}-tls-cert"
```
