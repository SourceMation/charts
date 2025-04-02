## For developers

## Installing from repo

```bash
git clone git@github.com:SourceMation/charts.git
cd charts/charts/argo-cd/


export CHART_NAME=argo-cd
export CHART_NAMESPACE=lp-system
export CHART_URL=argo-cd.apps.example.com
export CERT_ISSUER_NAME=default-selfsigned-ca
export CERT_ISSUER_KIND=ClusterIssuer


kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace ${CHART_NAMESPACE}

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


helm -n ${CHART_NAMESPACE} upgrade --install ${CHART_NAME} . \
-f /tmp/values.yaml
```

# Cleaning

```bash
helm uninstall -n ${CHART_NAMESPACE} ${CHART_NAME}
kubectl delete -n ${CHART_NAMESPACE} secret/argocd-redis
```


# Testing

```bash
kubectl -n ${CHART_NAMESPACE} get po,svc,sts,secret,cm,pvc,ingress,cert
kubectl get crd | grep argoproj
```
