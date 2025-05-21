## For developers

## Installing from repo

```bash
export CHART_NAME=jenkins
export CHART_NAMESPACE=jenkins
export CHART_URL=jenkins.apps.example.com
export CERT_ISSUER_NAME=default-selfsigned-ca
export CERT_ISSUER_KIND=ClusterIssuer
export CERT_SECRET_NAME=jenkins-tls-cert 

git clone git@github.com:SourceMation/charts.git
cd charts/charts/${CHART_NAME}/

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


helm -n ${CHART_NAMESPACE} upgrade --install ${CHART_NAME} . \
-f /tmp/values.yaml
```

# Cleaning

```bash
helm uninstall -n ${CHART_NAMESPACE} ${CHART_NAME}
kubectl delete certificate "${CHART_NAME}-tls-cert"
```


# Testing

```bash
kubectl -n ${CHART_NAMESPACE} get po,svc,sts,secret,cm,pvc,ingress,cert
helm -n ${CHART_NAMESPACE} test ${CHART_NAME}
```
