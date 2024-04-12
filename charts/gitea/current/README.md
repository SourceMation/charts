# Useful links / Przydatne linki
- https://dl.gitea.io/charts/
- https://github.com/go-gitea/gitea

# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export APP_NS=gitea
export APP_NAME=gitea
export INGRESS_HOST=gitea.example.com
export GITEA_USER=<add your gitea user>
export GITEA_PASSWD=<add your gitea password>
export GITEA_EMAIL=<add your gitea email>
export DOCKER_USER=<docker user>
export DOCKER_PASSWD=<docker password>
export CHART_VERSION=10.1.3
kubectl create ns $APP_NS
kubectl config set-context --current --namespace ${APP_NS}
```

## Docker registry creation / Stworzenie rejestru docker

```bash
kubectl -n ${APP_NS} create secret docker-registry docker-io \
--docker-username ${DOCKER_USER} --docker-password ${DOCKER_PASSWD} \
--docker-server 'https://index.docker.io/v1/'
```

## Installation via helm / Instalacja przy użyciu helm
```bash
helm upgrade --install  $APP_NAME \
-n ${APP_NS} \
--set "global.imagePullSecrets[]=docker-io" \
--set "ingress.hosts[0].host=${INGRESS_HOST}" \
--set "gitea.admin.username=${GITEA_USER}" \
--set "gitea.admin.password=${GITEA_PASSWD}" \
--set "gitea.admin.email=${GITEA_EMAIL}"  \
-f https://raw.githubusercontent.com/linuxpolska/charts/main/charts/gitea/${CHART_VERSION}/values \
--repo https://dl.gitea.io/charts/  $APP_NAME --version ${CHART_VERSION} 
```
