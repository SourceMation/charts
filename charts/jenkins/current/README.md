# Useful links / Przydatne linki
- https://github.com/jenkinsci/helm-charts/blob/main/charts/jenkins/README.md
- https://github.com/jenkinsci

# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export JENKINS_NAMESPACE=jenkinsdev
export JENKINS_NAME=dev
export JENKINS_HOST=jenkins.example.com
export CHART_VERSION=5.0.1

kubectl create ns ${JENKINS_NAMESPACE}
kubectl config set-context --current --namespace=${JENKINS_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm
```bash
helm upgrade --install ${JENKINS_NAME} --repo https://charts.jenkins.io ${JENKINS_NAME} --version ${CHART_VERSION}
```

##Remove default seccompProfile / usuniecie domyslnego seccompProfile
```bash
kubectl edit statefulset.apps/${JENKINS_NAME}-jenkins

  seccompProfile:
    type: RuntimeDefault
```

#Ingress creation / Utworzenie ingress

```bash
cat <<EOF | kubectl apply -f - 
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: jenkins-urlw
  namespace: jenkinsdev
spec:
  rules:
  - host: ${JENKINS_HOST}
    http:
      paths:
      - backend:
          service:
            name: dev-jenkins
            port:
              number: 8080
        path: /
        pathType: Prefix
EOF
```
