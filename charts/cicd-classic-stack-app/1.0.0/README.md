# Useful links / Przydatne linki
- https://github.com/SourceMation/charts/blob/main/charts/coder/current/README.md
- https://github.com/SourceMation/charts/blob/main/charts/forgejo/current/README.md
- https://github.com/SourceMation/charts/tree/main/charts/harbor/current/README.md
- https://github.com/SourceMation/charts/blob/main/charts/jenkins/current/README.md
- https://github.com/SourceMation/charts/blob/main/charts/sonarqube/current/README.md

# CLI Installation / CLI Instalacja

## Preparation / Przygotowanie

```bash

export STACK_NAME=cicd-classic-stack-app
export CHART_VERSION=1.0.0
export K8S_NAMESPACE=lp-app
export CODER_URL=coder.apps.example.com
export FORGEJO_URL=forgejo.apps.example.com
export HARBOR_URL=harbor.apps.example.com
export JENKINS_URL=jenkins.apps.example.com
export SONARQUBE_URL=sonarqube.apps.example.com

```

## Create file with values / Przygotuj plik z parametrami do przekazania

```bash

```


## Installation via helm / Instalacja przy użyciu helm

``` bash

helm -n ${K8S_NAMESPACE} upgrade --install ${STACK_NAME} \
--set "coder.coder.ingress.host=${CODER_URL}" \
--set "forgejo.ingress.hosts.0.host=${FORGEJO_URL}" \
--set "harbor.expose.ingress.hosts.core=${HARBOR_URL}" \
--set "jenkins.params.ingress.hostName=${JENKINS_URL}" \
--set "sonarqube.ingress.hosts.0.name=${SONARQUBE_URL}" \
--repo https://sourcemation.github.io/charts/ ${STACK_NAME} \
--version ${CHART_VERSION}

```



# For developers

```bash


cd charts/cicd-classic-stack-app/${CHART_VERSION}


cat <<EOF> /tmp/cicd-classic-stack-app.yaml
sonarqube:
  ingress:
    hosts:
      - name: "sonarqube.apps.example.com"
harbor:
  externalURL: https://harbor.apps.example.com
  expose:
    ingress:
      hosts:
        core: harbor.apps.example.com
forgejo:
  ingress:
    hosts:
      - host: "forgejo.apps.example.com"
        paths:
        - path: "/"
          pathType: "Prefix"
coder:
  coder:
    ingress:
      host: "coder.apps.example.com"
jenkins:
  params:
    ingress:
      hostName: "jenkins.apps.example.com"

EOF


helm -n ${K8S_NAMESPACE} upgrade --install --create-namespace cicd-classic-stack-app . \
-f /tmp/cicd-classic-stack-app.yaml

```
