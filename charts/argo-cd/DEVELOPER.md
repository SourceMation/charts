## For developers

## Installing from repo

```bash
export RELEASE_NAME=argo
export CHART_NAME=argo-cd
export RELEASE_NAMESPACE=argocd

export CHART_URL=argo-cd.apps.example.com
export CERT_ISSUER_NAME=default-selfsigned-ca
export CERT_ISSUER_KIND=ClusterIssuer

git clone git@github.com:SourceMation/charts.git
cd charts/charts/${CHART_NAME}

kubectl create ns ${RELEASE_NAMESPACE}
kubectl config set-context --current --namespace ${RELEASE_NAMESPACE}

cat << EOF > /tmp/values.yaml
argocd:
  global:
    domain: "${CHART_URL}$"
  server:
    ingress:
      enabled: true
      tls: true
    certificate:
      enabled: true
      issuer:
        group: "cert-manager.io"
        kind: "${CERT_ISSUER_KIND}"
        name: "${CERT_ISSUER_NAME}"
EOF


helm -n ${RELEASE_NAMESPACE} upgrade --install ${RELEASE_NAME} . \
-f /tmp/values.yaml
```

# Cleaning

```bash
helm uninstall -n ${RELEASE_NAMESPACE} ${RELEASE_NAME}
kubectl delete -n ${RELEASE_NAMESPACE} secret/argocd-redis
kubectl get crd -o name | grep -i argoproj | xargs kubectl delete
```


# Testing

```bash
kubectl -n ${RELEASE_NAMESPACE} get po,svc,sts,secret,cm,pvc,ingress,cert
kubectl get crd | grep argoproj
```
