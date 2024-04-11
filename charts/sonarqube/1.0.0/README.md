# Useful links / Przydatne linki
- https://github.com/SonarSource/helm-chart-sonarqube

# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export SONAR_NAMESPACE=jenkinsdev
export SONAR_NAME=sonarqube
export SONAR_HOST=<assign your host>

kubectl create ns ${SONAR_NAMESPACE}
kubectl config set-context --current --namespace=${SONAR_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm
```bash
helm install ${SONAR_NAME} sonarqube/sonarqube --set persistence.enabled=true --namespace ${SONAR_NAMESPACE}
helm upgrade --install ${SONAR_NAME} --repo https://SonarSource.github.io/helm-chart-sonarqube ${SONAR_NAME}  --set persistence.enabled=true
```

## Remove default seccompProfile / Usuniecie domyslnego seccompProfile

```bash
kubectl edit statefulset.apps/${SONAR_NAME}-sonarqube

  seccompProfile:
    type: RuntimeDefault
```

## Ingress creation / Utworzenie ingress

```bash
cat <<EOF | kubectl apply -f - 
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: sonar-urlw
  namespace: jenkinsdev
spec:
  rules:
  - host: ${SONAR_HOST}
    http:
      paths:
      - backend:
          service:
            name: sonardev-sonarqube
            port:
              number: 9000
        path: /
        pathType: Prefix
EOF
```
