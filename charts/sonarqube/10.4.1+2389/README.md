# Useful links / Przydatne linki
- https://github.com/SonarSource/helm-chart-sonarqube

# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export SONAR_NAMESPACE=jenkinsdev
export SONAR_NAME=sonarqube
export SONAR_HOST=sonarqube.example.com
export CHART_VERSION=10.4.1+2389

kubectl create ns ${SONAR_NAMESPACE}
kubectl config set-context --current --namespace=${SONAR_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm
```bash
helm upgrade --install ${SONAR_NAME} \
 -n ${SONAR_NAMESPACE} \
 -f https://raw.githubusercontent.com/linuxpolska/charts/main/charts/sonarqube/10.4.1+2389/values \
 --set "persistence.enabled=true" \
 --repo https://SonarSource.github.io/helm-chart-sonarqube ${SONAR_NAME} --version ${CHART_VERSION}
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
