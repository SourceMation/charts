# For developers / Dla deweloperow 
 
## Installing from repo / Instalacja z repo 
 
```bash 
 
export CHART_VERSION=1.0.0
export CHART_NAMESPACE=cert-manager
 
cd charts/charts/cert-manager-config/${CHART_VERSION} 

 
helm upgrade --install -n ${CHART_NAMESPACE} --create-namespace \ 
cert-manager-config .  


kubectl -n ${CHART_NAMESPACE} get po

kubectl get issuers,clusterissuers,certificates,certificaterequests,orders,challenges -A

 
``` 


## Removing

```bash

helm -n ${CHART_NAMESPACE} uninstall cert-manager-config

```

## Generate own TLS and test


```bash

kubectl create -f - <<EOF
---
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: test-server
spec:
  secretName: test-server-tls
  isCA: false
  usages:
    - server auth
    - client auth
  commonName: test-server.example.com
  dnsNames:
  - "test-server.example.com"
  - "test-server.test.svc.cluster.local"
  - "test-server"
  - "test-server.test.svc"
  issuerRef:
    name: default-selfsigned-issuer
    kind: ClusterIssuer
EOF


openssl x509 -in <(kubectl get secret test-server-tls -o jsonpath='{.data.tls\.crt}' | base64 -d) -text -noout


## check ca trust

openssl verify -CAfile \
<(kubectl get secret test-server-tls -o jsonpath='{.data.ca\.crt}' | base64 -d) \
<(kubectl get secret test-server-tls -o jsonpath='{.data.tls\.crt}' | base64 -d)



## create own http server with tls

echo 'Go go LinuxPolska' > test.txt

openssl s_server \
-cert <(kubectl get secret test-server-tls -o jsonpath='{.data.tls\.crt}' | base64 -d) \
-key <(kubectl get secret test-server-tls -o jsonpath='{.data.tls\.key}' | base64 -d) \
-CAfile <(kubectl get secret test-server-tls -o jsonpath='{.data.ca\.crt}' | base64 -d) \
-WWW -port 8088  \
-verify_return_error -Verify 1 &

PRESS ENTER

kubectl get secret test-server-tls -o jsonpath='{.data.ca\.crt}' | base64 -d > /tmp/ca.crt


## verify tls

echo -e 'GET /test.txt HTTP/1.1\r\n\r\n' | \
openssl s_client \
-cert <(kubectl get secret test-server-tls -o jsonpath='{.data.tls\.crt}' | base64 -d) \
-key <(kubectl get secret test-server-tls -o jsonpath='{.data.tls\.key}' | base64 -d) \
-CAfile <(kubectl get secret test-server-tls -o jsonpath='{.data.ca\.crt}' | base64 -d) \
-connect localhost:8088


rm -rf test.txt

kubectl delete certificate test-server

```
