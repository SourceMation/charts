## General

### Are you looking for more information?

1. Based on: https://github.com/SonarSource/sonarqube.git
2. Documentation: https://docs.sonarsource.com/sonarqube/latest/
3. Chart Source: https://github.com/SourceMation/charts.git


## Before Installation

* The installation of cert-manager is required according to the instructions provided in the README file of the latest version: https://github.com/SourceMation/charts/tree/main/charts/cert-manager

* The installation of cloudnative-pg operator is required according to the instructions provided in the README file of the latest version: https://github.com/SourceMation/charts/tree/main/charts/cnpg-operator

* An ingress controller must be installed within the cluster.

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
export RELEASE_NAME=sonarqube
export CHART_NAME=sonarqube
export CHART_VERSION=0.4.3
export RELEASE_NAMESPACE=sonarqube
export CHART_URL=sonarqube.apps.example.com
export CERT_SECRET_NAME=sonarqube-tls-cert
export CERT_ISSUER_NAME=default-selfsigned-ca
export CERT_ISSUER_KIND=ClusterIssuer

kubectl create ns ${RELEASE_NAMESPACE}
kubectl config set-context --current --namespace ${RELEASE_NAMESPACE}

cat << EOF > /tmp/values.yaml
sonarqube:
  ingress:
    hosts:
    - name: "${CHART_URL}"
    tls:
    - secretName: "${CERT_SECRET_NAME}"
      hosts:
      - "${CHART_URL}"
    cert:
      issuerKind: "${CERT_ISSUER_KIND}"
      issuerName: "${CERT_ISSUER_NAME}"
EOF
```

### Go go helm

```bash
helm -n ${RELEASE_NAMESPACE} upgrade --install ${RELEASE_NAME} \
-f /tmp/values.yaml \
${CHART_NAME} --repo https://sourcemation.github.io/charts/ \
--version ${CHART_VERSION}
```

### Validation and Testing

```bash
kubectl -n ${RELEASE_NAMESPACE} get po
```

## CLI removing

```bash
helm -n ${RELEASE_NAMESPACE} uninstall ${RELEASE_NAME}
kubectl -n ${RELEASE_NAMESPACE} delete cert/${RELEASE_NAME}-tls-cert
```
