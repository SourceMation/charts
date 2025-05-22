## For developers

## Installing from repo

```bash
export RELEASE_NAME=sonarqube
export CHART_NAME=sonarqube
export RELEASE_NAMESPACE=sonarqube
export CHART_URL=sonarqube.apps.example.com
export CERT_SECRET_NAME=sonarqube-tls-cert
export CERT_ISSUER_NAME=default-selfsigned-ca
export CERT_ISSUER_KIND=ClusterIssuer

git clone git@github.com:SourceMation/charts.git
cd charts/charts/${CHART_NAME}

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


helm -n ${RELEASE_NAMESPACE} upgrade --install ${RELEASE_NAME} . \
-f /tmp/values.yaml
```

# Cleaning

```bash
helm uninstall -n ${RELEASE_NAMESPACE} ${RELEASE_NAME}
kubectl delete certificate "${RELEASE_NAME}-tls-cert"
```

# Testing

```bash
kubectl -n ${RELEASE_NAMESPACE} get po,svc,sts,secret,cm,pvc,ingress,cert
```
