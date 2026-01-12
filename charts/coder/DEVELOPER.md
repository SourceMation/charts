## For developers

## Installing from repo

```bash
export RELEASE_NAME=coder
export CHART_NAME=coder
export RELEASE_NAMESPACE=coder-namespace
export CHART_URL=coder.apps.example.com
export CERT_ISSUER_NAME=default-selfsigned-ca
export CERT_ISSUER_KIND=ClusterIssuer
export CERT_SECRET_NAME=coder-tls-cert

git clone git@github.com:SourceMation/charts.git
cd charts/charts/${CHART_NAME}


cat <<EOF> /tmp/values.yaml
coder:
  coder:
    ingress:
      host: "${CHART_URL}"
      tls:
        issuerName: "${CERT_ISSUER_NAME}"
        issuerKind: "${CERT_ISSUER_KIND}"
        secretName: "${CERT_SECRET_NAME}"
EOF


helm -n ${RELEASE_NAMESPACE} upgrade --install --create-namespace \
-f /tmp/values.yaml
${RELEASE_NAME} . \
```

# Cleaning

```bash
helm -n ${RELEASE_NAMESPACE} uninstall ${RELEASE_NAME}
kubectl -n ${RELEASE_NAMESPACE} delete cert ${CERT_SECRET_NAME}
```

# Testing

```bash
kubectl -n ${RELEASE_NAMESPACE} get po,svc,sts,secret,cm,pvc,ingress,cert
```
