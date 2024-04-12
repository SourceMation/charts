

[[_TOC_]]

# Elastic stack installation

The chart is under active development

## Requirements

### Generic

1. Open traffic from k8s to following services

```bash
helm.elastic.co:TCP/443
download.elastic.co:TCP/443
docker.elastic.co:TCP/443
epr.elastic.co:TCP/443
```

2. Install kube-vip or any solution with support external ip in a service (optional)
3. Minimum three worker nodes with 12x vCPU, 32GB RAM
4. Storage class supported block storage and RWO access with 650GiB of available space
5. it is recommended to change kernel parameters on each node for production enivronments (optional)

More information available [here](https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-virtual-memory.html)


# Elastic stack - install

```bash


export ECK_VER=2.11.1
export K8S_NAMESPACE=elastic
export ELASTICSEARCH_URL=example.com
export ELASTICSEARCH_STORAGE=example.com
export REPO_URL=example.com
export KB_URL=example.com
export APM_URL_HTTP=example.com
export APM_URL_GRPC=example.com
export FLEET_URL=example.com

helm -n default install elastic-operator-crds elastic/eck-operator-crds --version ${ECK_VER}

helm -n default list


cat << EOF > /tmp/eck-operator.yaml
installCRDs: false
createClusterScopedResources: true
webhook:
  enabled: false
config:
  validateStorageClass: false
EOF


helm -n default install elastic-operator elastic/eck-operator \
-f /tmp/eck-operator.yaml \
--version ${ECK_VER}


helm -n default list

kubectl -n default get pods --selector='app.kubernetes.io/name=elastic-operator'

kubectl -n default logs sts/elastic-operator



helm -n ${K8S_NAMESPACE} upgrade --install --create-namespace elka charts/elastic/1.0.0/ \
--set 'elasticsearch.url=${ELASTICSEARCH_URL}' \
--set 'elasticsearch.storageClass=${ELASTICSEARCH_STORAGE}' \
--set 'repo.url=repo-${REPO_URL}' \
--set 'kb.url=${KB_URL}' \
--set 'apm.urlHttp=${APM_URL_HTTP}' \
--set 'apm.urlGrpc=${APM_URL_GRPC}' \
--set 'fleet.url=${FLEET_URL}'




````

# Elastic stack remove


```bash


helm -n ${K8S_NAMESPACE}  uninstall elka

kubectl -n ${K8S_NAMESPACE} delete pvc -l common.k8s.elastic.co/type=logstash



kubectl apply -f - <<EOF
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  labels:
    app: toolbox
  name: toolbox
  namespace: ${K8S_NAMESPACE}
spec:
  selector:
    matchLabels:
      app: toolbox
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: toolbox
    spec:
      tolerations:
        - key: node-role.kubernetes.io/control-plane
          effect: NoSchedule
        - key: node-role.kubernetes.io/master
          effect: NoSchedule
      hostPID: true
      containers:
      - command:
          - /bin/sh
          - -c
          - rm -rf /hostfs/var/lib/elastic-agent-managed /hostfs/var/lib/${K8S_NAMESPACE} /hostfs/var/lib/elastic-agent; ls /hostfs/var/lib
        image: busybox
        name: busybox
        resources: {}
        securityContext:
          runAsUser: 0
        volumeMounts:
          - name: proc
            mountPath: /hostfs/
      volumes:
        - name: proc
          hostPath:
            path: /
EOF

kubectl -n ${K8S_NAMESPACE} logs ds/toolbox

kubectl -n ${K8S_NAMESPACE} delete ds/toolbox





helm -n ${K8S_NAMESPACE} uninstall elastic-operator-crds
helm -n ${K8S_NAMESPACE} uninstall elastic-operator
kubectl -n ${K8S_NAMESPACE} delete secret repo-auth


```
