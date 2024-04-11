
# Table of Contents
----------------------

[[_TOC_]]

# Elastic stack installation

Manuals:
- user guide: https://www.elastic.co/guide/en/cloud-on-k8s/current
- role node: https://opster.com/guides/elasticsearch/data-architecture/how-to-configure-all-elasticsearch-node-roles/
- role node minimal: https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-node.html
- elastic-agent config: https://www.elastic.co/guide/en/starting-with-the-elasticsearch-platform-and-its-solutions/current/getting-started-kubernetes.html
- elastic-agent limits: https://www.elastic.co/guide/en/fleet/current/scaling-on-kubernetes.html
- dev tools check params of integration module: GET kbn:/api/fleet/agent_policies/eck-agent

Sources:
- developer guide: https://www.elastic.co/guide/en/kibana/master/development.html
- elasticsearch (bin): https://github.com/elastic/elasticsearch.gi
- kibana (bin): https://github.com/elastic/kibana.git
- elastic-agent (bin,dockerfile): https://github.com/elastic/elastic-agent.git
- elastic,kibana (dockerfile): https://github.com/elastic/dockerfiles.git
- eck-operator (bin): https://github.com/elastic/cloud-on-k8s.git
- eck-operator (charts): https://github.com/elastic/cloud-on-k8s/tree/main/deploy
- official images index: https://github.com/elastic/official-images




## Requirements

### Generic

1. open traffic to following services in k8s and bastion

```bash

helm.elastic.co:TCP/443
download.elastic.co:TCP/443
docker.elastic.co:TCP/443

```

2. install kube-vip or any solution which support external ip in a service (optional)
3. minimum 3 worker nodes 12x vCPU, 32GB RAM
4. minimal requirements for each pod

```bash

kubectl get po -o custom-columns=NAME:.metadata.name,RESOURCES:.spec.containers[].resources,NODE:.spec.nodeName --sort-by='{.spec.nodeName}'

```


* sts/elastic-operator: 1 x vCPU, 1GiB RAM
* sts/*-es-master: all x vCPU, 2GiB RAM, PVC(RWO): 10GiB
* sts/*-es-data: all x vCPU, 2GiB RAM, PVC(RWO): 10GiB
* sts/*-es-coordinating: all x vCPU, 2GiB RAM, PVC(RWO): 10GiB
* deploy/*-apm-server: all x vCPU, 0.512 GiB RAM
* deploy/*-fleet-agent: 0.2 x vCPU, 1 GiB RAM
* deploy/*-kb: all x vCPU, 1 GiB RAM
* ds/*-system-agent: 1.5 vCPU, 1.5 GiB RAM

### Production environments

1. it is recommended to change kernel parameters on each node.

More information available here https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-virtual-memory.html

```bash
vm.max_map_count = 262144
```

2. It is recommended to use nodeaffinity to schedule on appropriate nodes

More information available here https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-advanced-node-scheduling.html#k8s_a_single_elasticsearch_node_per_kubernetes_host_default

```bash

kubectl label node/<nodename> elastic=all

```

## All - envs

```bash

export ECK_VER=2.11.1

export ELASTIC_VER=8.12.2
export ELASTIC_CLUSTER_NAME=elka-elastic
export ELASTIC_URL='es.apps.rke2.lab.linuxpolska.pl'

export KIBANA_VER="${ELASTIC_VER}"
export KIBANA_URL='kb.apps.rke2.lab.linuxpolska.pl'

export APM_VER="${ELASTIC_VER}"
export APM_HTTP_URL='apm-http.apps.rke2.lab.linuxpolska.pl'
export APM_GRPC_URL='apm-grpc.apps.rke2.lab.linuxpolska.pl'
export APM_SECRET_TOKEN="E2D3ytLiaI236F62x2n6Rvt4"

export AGENT_VER="${ELASTIC_VER}"
export FLEET_URL='fleet.apps.rke2.lab.linuxpolska.pl'
export PACKAGE_URL='repo.apps.rke2.lab.linuxpolska.pl'

export FILEBEAT_VER="${ELASTIC_VER}"
export METRICSBEAT_VER="${ELASTIC_VER}"
export LOGSTASH_VER="${ELASTIC_VER}"

export K8S_STORAGECLASS='vsphere-ext4-rwo'
export K8S_NAMESPACE='elastic'

export REG_HOSTNAME='docker.elastic.co'
export REG_NAMESPACE_ELASTIC='eck'
#export REG_NAMESPACE_DOCKER='linuxpolska-docker-io'
#export REG_NAMESPACE_QUAY='linuxpolska-quay-io'
#export REG_NAMESPACE_GHCR='linuxpolska-ghcr-io'
export REG_USERNAME_PULL='null'
export REG_PASSWD_PULL='null'

```



## All - uninstall


1. remove resources from k8s

```bash

kubectl -n ${K8S_NAMESPACE} delete elastic --all
#kubectl -n ${K8S_NAMESPACE} delete secret repo-auth


kubectl delete clusterrole.rbac.authorization.k8s.io/metricbeat
kubectl -n ${K8S_NAMESPACE} delete serviceaccount/metricbeat
kubectl delete clusterrolebinding.rbac.authorization.k8s.io/metricbeat-${K8S_NAMESPACE}

kubectl delete clusterrole.rbac.authorization.k8s.io/filebeat
kubectl -n ${K8S_NAMESPACE} delete serviceaccount/filebeat
kubectl delete clusterrolebinding.rbac.authorization.k8s.io/filebeat-${K8S_NAMESPACE}


kubectl delete clusterrole.rbac.authorization.k8s.io/fleet-server
kubectl -n ${K8S_NAMESPACE} delete serviceaccount/fleet-server
kubectl delete clusterrolebinding.rbac.authorization.k8s.io/fleet-server-${K8S_NAMESPACE}

kubectl delete clusterrole.rbac.authorization.k8s.io/elastic-agent
kubectl -n ${K8S_NAMESPACE} delete serviceaccount/elastic-agent
kubectl delete clusterrolebinding.rbac.authorization.k8s.io/elastic-agent-${K8S_NAMESPACE}

kubectl -n ${K8S_NAMESPACE} delete service -l agent.k8s.elastic.co/name=${ELASTIC_CLUSTER_NAME}-system

kubectl -n ${K8S_NAMESPACE} delete ingress -l elasticsearch.k8s.elastic.co/cluster-name=${ELASTIC_CLUSTER_NAME}
kubectl -n ${K8S_NAMESPACE} delete ingress -l agent.k8s.elastic.co/name=${ELASTIC_CLUSTER_NAME}-fleet
kubectl -n ${K8S_NAMESPACE} delete ingress -l apm.k8s.elastic.co/name=${ELASTIC_CLUSTER_NAME}
kubectl -n ${K8S_NAMESPACE} delete ingress -l kibana.k8s.elastic.co/name=${ELASTIC_CLUSTER_NAME}
kubectl -n ${K8S_NAMESPACE} delete ingress -l repo.k8s.elastic.co/name=${ELASTIC_CLUSTER_NAME}

kubectl -n ${K8S_NAMESPACE} delete pvc -l common.k8s.elastic.co/type=logstash
kubectl -n ${K8S_NAMESPACE} delete svc -l agent.k8s.elastic.co/name=elka-service
kubectl -n ${K8S_NAMESPACE} delete all,pvc,ingress -l repo.k8s.elastic.co/name=${ELASTIC_CLUSTER_NAME}


kubectl -n ${K8S_NAMESPACE} get po,pvc


```


2. clean files from hosts

```bash

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



## All - preparation

```bash

kubectl create ns ${K8S_NAMESPACE}
kubectl config set-context --current --namespace ${K8S_NAMESPACE}

```

## Operator - preparation


```bash

helm repo add elastic https://helm.elastic.co
helm repo update elastic

# show all available versions
helm search repo elastic -l | grep eck-operator


```


## Operator - uninstall helm

1. Uninstall


```bash

helm -n ${K8S_NAMESPACE} uninstall elastic-operator-crds
helm -n ${K8S_NAMESPACE} uninstall elastic-operator
kubectl -n ${K8S_NAMESPACE} delete secret repo-auth


```

2. Validation

```bash

kubectl -n ${K8S_NAMESPACE} get po,pvc

```

## Operator - install helm

1. installation

``` bash

helm -n ${K8S_NAMESPACE} install elastic-operator-crds elastic/eck-operator-crds --version ${ECK_VER}

helm -n ${K8S_NAMESPACE} list

kubectl -n ${K8S_NAMESPACE} create secret docker-registry repo-auth \
--docker-server ${REG_HOSTNAME} \
--docker-username ${REG_USERNAME_PULL} \
--docker-password ${REG_PASSWD_PULL}


cat << EOF > /tmp/eck-operator.yaml
installCRDs: false
image:
  repository: ${REG_HOSTNAME}/${REG_NAMESPACE_ELASTIC}/eck-operator
createClusterScopedResources: true
#imagePullSecrets:
#- name: repo-auth
webhook:
  enabled: false
config:
  validateStorageClass: false
EOF


helm -n ${K8S_NAMESPACE} install elastic-operator elastic/eck-operator \
-f /tmp/eck-operator.yaml \
--version ${ECK_VER}


```

2. validation/debug


```bash

helm -n ${K8S_NAMESPACE} list

kubectl -n ${K8S_NAMESPACE} get pods --selector='app.kubernetes.io/name=elastic-operator'

kubectl -n ${K8S_NAMESPACE} logs sts/elastic-operator

```



## Elasticsearch - install

1. Installation

```bash

kubectl -n ${K8S_NAMESPACE} create secret docker-registry repo-auth \
--docker-server ${REG_HOSTNAME} \
--docker-username ${REG_USERNAME_PULL} \
--docker-password ${REG_PASSWD_PULL}


#kubectl -n ${K8S_NAMESPACE} patch serviceaccount default \
#-p '{"imagePullSecrets": [{"name": "repo-auth"}]}'


kubectl apply -f - <<EOF
---
apiVersion: elasticsearch.k8s.elastic.co/v1
kind: Elasticsearch
metadata:
  name: ${ELASTIC_CLUSTER_NAME}
  namespace: ${K8S_NAMESPACE}
spec:
  version: ${ELASTIC_VER}
  image: docker.elastic.co/elasticsearch/elasticsearch:${ELASTIC_VER}
  http:
    service:
      spec:
        type: LoadBalancer
        selector:
          elasticsearch.k8s.elastic.co/cluster-name: "${ELASTIC_CLUSTER_NAME}"
          elasticsearch.k8s.elastic.co/node-master: "false" 
    tls:
      selfSignedCertificate:
        disabled: false
        subjectAltNames:
        - dns: ${ELASTIC_URL}
  podDisruptionBudget:
    spec:
      minAvailable: 2
      selector:
        matchLabels:
          elasticsearch.k8s.elastic.co/cluster-name: ${ELASTIC_CLUSTER_NAME}
  nodeSets:
  - name: master
    count: 3
    config:
      node.roles: ["master"]
      node.store.allow_mmap: false
    volumeClaimTemplates:
    - metadata:
        name: elasticsearch-data
      spec:
        accessModes:
        - ReadWriteOnce
        resources:
          requests:
            storage: 10Gi
        storageClassName: ${K8S_STORAGECLASS}
    podTemplate:
      metadata:
        labels:
          scrape: es
      spec:
#        imagePullSecrets:
#        - name: repo-auth
        containers:
        - name: elasticsearch
          resources:
            requests:
              memory: 2Gi
            limits:
              memory: 2Gi
        affinity:
          podAntiAffinity:
            preferredDuringSchedulingIgnoredDuringExecution:
            - weight: 100
              podAffinityTerm:
                labelSelector:
                  matchLabels:
                    elasticsearch.k8s.elastic.co/cluster-name: ${ELASTIC_CLUSTER_NAME}-master
                topologyKey: kubernetes.io/hostname
          nodeAffinity:
            requiredDuringSchedulingIgnoredDuringExecution:
              nodeSelectorTerms:
              - matchExpressions:
                - key: kubernetes.io/os
                  operator: In
                  values:
                  - linux
#                - key: elastic
#                  operator: In
#                  values:
#                  - all
  - name: data
    count: 3
    config:
      node.roles: ["data", "ingest", "ml", "transform", "remote_cluster_client"]
      node.store.allow_mmap: false
    volumeClaimTemplates:
    - metadata:
        name: elasticsearch-data
      spec:
        accessModes:
        - ReadWriteOnce
        resources:
          requests:
            storage: 200Gi
        storageClassName: ${K8S_STORAGECLASS}
    podTemplate:
      metadata:
        labels:
          scrape: es
      spec:
#        imagePullSecrets:
#        - name: repo-auth
        containers:
        - name: elasticsearch
          resources:
            requests:
              memory: 2Gi
            limits:
              memory: 8Gi
        affinity:
          podAntiAffinity:
            preferredDuringSchedulingIgnoredDuringExecution:
            - weight: 100
              podAffinityTerm:
                labelSelector:
                  matchLabels:
                    elasticsearch.k8s.elastic.co/cluster-name: ${ELASTIC_CLUSTER_NAME}-data
                topologyKey: kubernetes.io/hostname
          nodeAffinity:
            requiredDuringSchedulingIgnoredDuringExecution:
              nodeSelectorTerms:
              - matchExpressions:
                - key: kubernetes.io/os
                  operator: In
                  values:
                  - linux
#                - key: elastic
#                  operator: In
#                  values:
#                  - all
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ${ELASTIC_CLUSTER_NAME}-es-http
  namespace: ${K8S_NAMESPACE}
  annotations:
    nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
    nginx.ingress.kubernetes.io/ssl-passthrough: "true"
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
  labels:
    elasticsearch.k8s.elastic.co/cluster-name: ${ELASTIC_CLUSTER_NAME}
spec:
  rules:
  - host: ${ELASTIC_URL}
    http:
      paths:
      - backend:
          service:
            name: ${ELASTIC_CLUSTER_NAME}-es-http
            port:
              number: 9200
        path: /
        pathType: Prefix
  tls:
  - hosts:
    - ${ELASTIC_URL}
    secretName: ${ELASTIC_CLUSTER_NAME}-es-http-certs-internal  
EOF


```

2. Validation/debug

```bash

kubectl -n ${K8S_NAMESPACE} get pods --selector='elasticsearch.k8s.elastic.co/cluster-name='${ELASTIC_CLUSTER_NAME}'' -o wide

kubectl -n ${K8S_NAMESPACE} get elasticsearch

kubectl -n ${K8S_NAMESPACE} logs statefulset/elastic-operator

```


## package repo - install 


```bash

kubectl apply -f - <<EOF
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    common.k8s.elastic.co/type: repo
    repo.k8s.elastic.co/name: ${ELASTIC_CLUSTER_NAME}
  name: ${ELASTIC_CLUSTER_NAME}-repo
  namespace: ${K8S_NAMESPACE}
spec:
  replicas: 2
  selector:
    matchLabels:
      common.k8s.elastic.co/type: repo
      repo.k8s.elastic.co/name: ${ELASTIC_CLUSTER_NAME}
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        common.k8s.elastic.co/type: repo
        repo.k8s.elastic.co/name: ${ELASTIC_CLUSTER_NAME}
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: kubernetes.io/os
                operator: In
                values: 
                - linux
#              - key: elastic
#                operator: In
#                values:
#                - all
      containers:
      - image: docker.elastic.co/package-registry/distribution:${KIBANA_VER}
        imagePullPolicy: Always
        name: distribution
        env:
        - name: EPR_ADDRESS
          value: '0.0.0.0:8080'
#        - name: EPR_TLS_KEY
#          value: '/mnt/elastic-internal/http-certs/tls.key'
#        - name: EPR_TLS_CERT
#          value: '/mnt/elastic-internal/http-certs/tls.crt'                   
        ports:
        - containerPort: 8080
        readinessProbe:
#          failureThreshold: 3
          httpGet:
            path: /health
            port: 8080
            scheme: HTTP
#          initialDelaySeconds: 240
#          periodSeconds: 10
        resources: 
          requests:
            memory: 1Gi
          limits:
            memory: 1500Mi
#        volumeMounts:
#        - mountPath: /mnt/elastic-internal/http-certs
#          name: elastic-internal-http-certificates
#          readOnly: true
#      volumes:
#      - name: elastic-internal-http-certificates
#        secret:
#          defaultMode: 420
#          optional: false
#          secretName: ${ELASTIC_CLUSTER_NAME}-kb-http-certs-internal
---
apiVersion: v1
kind: Service
metadata:
  labels:
    common.k8s.elastic.co/type: repo
    repo.k8s.elastic.co/name: ${ELASTIC_CLUSTER_NAME}
  name: ${ELASTIC_CLUSTER_NAME}-repo
  namespace: ${K8S_NAMESPACE}
spec:
  type: LoadBalancer
  ports:
  - port: 8080
    protocol: TCP
    targetPort: 8080
  selector:
    common.k8s.elastic.co/type: repo
    repo.k8s.elastic.co/name: ${ELASTIC_CLUSTER_NAME}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ${ELASTIC_CLUSTER_NAME}-repo
  namespace: ${K8S_NAMESPACE}
  annotations:
    nginx.ingress.kubernetes.io/backend-protocol: "HTTP"
    nginx.ingress.kubernetes.io/ssl-passthrough: "false"
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
    nginx.ingress.kubernetes.io/force-ssl-redirect: "false"
  labels:
    common.k8s.elastic.co/type: repo
    repo.k8s.elastic.co/name: ${ELASTIC_CLUSTER_NAME}
spec:
  rules:
  - host: ${PACKAGE_URL}
    http:
      paths:
      - backend:
          service:
            name: ${ELASTIC_CLUSTER_NAME}-repo
            port:
              number: 8080
        path: /
        pathType: Prefix
  tls:
  - hosts:
    - ${PACKAGE_URL}
    secretName: ${ELASTIC_CLUSTER_NAME}-kb-http-certs-internal
EOF

```

2. Validation

```bash

kubectl -n ${K8S_NAMESPACE} get pods --selector='common.k8s.elastic.co/type=repo' -o wide

kubectl -n ${K8S_NAMESPACE} logs deployment/${ELASTIC_CLUSTER_NAME}-repo

```


## Kibana - install

1. Installation

```bash


kubectl apply -f - <<EOF
---
apiVersion: kibana.k8s.elastic.co/v1
kind: Kibana
metadata:
  name: ${ELASTIC_CLUSTER_NAME}
  namespace: ${K8S_NAMESPACE} 
spec:
  version: ${KIBANA_VER}
  image: docker.elastic.co/kibana/kibana:${KIBANA_VER}
  count: 1
  podTemplate:
    metadata:
      labels:
        scrape: kb
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: kubernetes.io/os
                operator: In
                values:
                - linux
#              - key: elastic
#                operator: In
#                values:
#                - all
      initContainers:
      - name: wait-for
        image: busybox:latest
        command: 
        - /bin/sh
        - -c
        - >
          set -x;
          until wget -q --spider --no-check-certificate http://${ELASTIC_CLUSTER_NAME}-repo:8080; do sleep 2; done
      containers:
      - name: kibana
        resources:
          requests:
            memory: 1Gi
          limits:
            memory: 2Gi
  http:
    service:
      spec:
        type: LoadBalancer
    tls:
      selfSignedCertificate:
        disabled: false
        subjectAltNames:
        - dns: ${KIBANA_URL}
        - dns: ${ELASTIC_CLUSTER_NAME}-repo
        - dns: ${PACKAGE_URL}
        - dns: ${APM_HTTP_URL}
        - dns: ${APM_GRPC_URL}
  elasticsearchRef:
    name: ${ELASTIC_CLUSTER_NAME}
  config:
    monitoring.kibana.collection.enabled: 'true'
    monitoring.ui.ccs.enabled: 'true'
    monitoring.ui.container.elasticsearch.enabled: 'true'
    monitoring.ui.container.logstash.enabled: 'true'
    xpack.reporting.kibanaServer.hostname: "${KIBANA_URL}"
    xpack.reporting.kibanaServer.protocol: "https"
    xpack.reporting.kibanaServer.port: "443"
    xpack.reporting.roles.enabled: "false"
    server.publicBaseUrl: "https://${KIBANA_URL}:443"
    xpack.fleet.registryUrl: "http://${ELASTIC_CLUSTER_NAME}-repo:8080"
    xpack.fleet.agents.fleet_server.hosts:
    - "https://${ELASTIC_CLUSTER_NAME}-fleet-agent-http.${K8S_NAMESPACE}.svc:8220"
    - "https://${FLEET_URL}:443"
    - "https://${FLEET_URL}:8220"
    xpack.fleet.outputs:
    - id: elastic
      is_default: true
      is_default_monitoring: true
      name: elastic
      type: elasticsearch
      hosts:
      - "https://${ELASTIC_CLUSTER_NAME}-es-http.${K8S_NAMESPACE}.svc:9200"
      - "https://${ELASTIC_URL}:443"
      - "https://${ELASTIC_URL}:9200"
      ssl:
        certificate_authorities: 
        - "/mnt/elastic-internal/elasticsearch-association/${K8S_NAMESPACE}/${ELASTIC_CLUSTER_NAME}/certs/ca.crt"
    xpack.fleet.packages:
      - name: system
        version: latest
      - name: elastic_agent
        version: latest
      - name: fleet_server
        version: latest
      - name: apm
        version: latest
      - name: kubernetes
        version: latest
    xpack.fleet.agentPolicies:
      - name: Agent Fleet Policy on ECK
        id: eck-agent-fleet
        namespace: default
        monitoring_enabled:
          - logs
          - metrics
        unenroll_timeout: 900
        package_policies:
        - name: agent-fleet-1
          id: agent-fleet-1
          package:
            name: fleet_server
        - name: system-1
          id: system-1
          package:
            name: system
      - name: Agent Service Policy on ECK
        id: eck-agent-service
        namespace: default
        monitoring_enabled:
          - logs
          - metrics
        unenroll_timeout: 900
        package_policies:
        - name: system-2
          id: system-2
          package:
            name: system
        - name: apm-1
          id: apm-1
          package:
            name: apm
          inputs:
          - type: apm
            enabled: true
            vars:
            - name: host
              value: "0.0.0.0:8200"
            - name: url
              value: "https://${APM_HTTP_URL}:443"
            - name: api_key_enabled
              value: 'true'
            - name: secret_token
              value: "${APM_SECRET_TOKEN}"
            - name: tls_enabled
              value: 'true'
            - name: tls_certificate
              value: "/mnt/elastic-internal/http-certs/tls.crt"
            - name: tls_key
              value: "/mnt/elastic-internal/http-certs/tls.key"
      - name: Agent Kubernetes Policy on RKE2 
        id: rke2-agent-kubernetes
        namespace: default
        monitoring_enabled:
          - logs
          - metrics
        unenroll_timeout: 900
        package_policies:
        - name: system-2
          id: system-3
          package:
            name: system
        - name: rke2-1
          id: rke2-1
          package:
            name: kubernetes
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ${ELASTIC_CLUSTER_NAME}-kb-http
  namespace: ${K8S_NAMESPACE} 
  annotations:
    nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
    nginx.ingress.kubernetes.io/ssl-passthrough: "false"
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
    nginx.ingress.kubernetes.io/force-ssl-redirect: "false"
  labels:
    kibana.k8s.elastic.co/name: ${ELASTIC_CLUSTER_NAME}
spec:
  rules:
  - host: ${KIBANA_URL}
    http:
      paths:
      - backend:
          service:
            name: ${ELASTIC_CLUSTER_NAME}-kb-http
            port:
              number: 5601
        path: /
        pathType: Prefix
  tls:
  - hosts:
    - ${KIBANA_URL}
#    secretName: ${ELASTIC_CLUSTER_NAME}-kb-http-certs-internal
EOF



```

2. Validation/debug

```bash

kubectl -n ${K8S_NAMESPACE} get pod --selector='kibana.k8s.elastic.co/name='${ELASTIC_CLUSTER_NAME}''

kubectl -n ${K8S_NAMESPACE} logs deploy/${ELASTIC_CLUSTER_NAME}-kb
kubectl -n ${K8S_NAMESPACE} get kibana

kubectl -n ${K8S_NAMESPACE} logs sts/elastic-operator

```



## Fleet server - install


1. Preparation

```bash

kubectl apply -f - <<EOF
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: fleet-server
rules:
- apiGroups: [""]
  resources:
  - pods
  - namespaces
  - nodes
  verbs:
  - get
  - watch
  - list
- apiGroups: ["apps"]
  resources:
    - replicasets
  verbs:
    - get
    - watch
    - list
- apiGroups: ["batch"]
  resources:
    - jobs
  verbs:
    - get
    - watch
    - list
- apiGroups: ["coordination.k8s.io"]
  resources:
  - leases
  verbs:
  - get
  - create
  - update
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: fleet-server
  namespace: ${K8S_NAMESPACE}
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: fleet-server-${K8S_NAMESPACE}
subjects:
- kind: ServiceAccount
  name: fleet-server
  namespace: ${K8S_NAMESPACE}
roleRef:
  kind: ClusterRole
  name: fleet-server
  apiGroup: rbac.authorization.k8s.io
EOF

```

2. Installation

```bash


kubectl apply -f - <<EOF
---
apiVersion: agent.k8s.elastic.co/v1alpha1
kind: Agent
metadata:
  name: ${ELASTIC_CLUSTER_NAME}-fleet
  namespace: ${K8S_NAMESPACE}
spec:
  http:
    service:
      spec:
        type: LoadBalancer
  version: ${AGENT_VER}
  image: docker.elastic.co/beats/elastic-agent:${AGENT_VER}
  kibanaRef:
    name: ${ELASTIC_CLUSTER_NAME}
  elasticsearchRefs:
  - name: ${ELASTIC_CLUSTER_NAME}
  mode: fleet
  fleetServerEnabled: true
  policyID: eck-agent-fleet
  deployment:
    replicas: 2
    podTemplate:
      metadata:
        labels:
          scrape: agent
      spec:
        serviceAccountName: fleet-server
        automountServiceAccountToken: true
        securityContext:
          runAsUser: 0
        affinity:
          nodeAffinity:
            requiredDuringSchedulingIgnoredDuringExecution:
              nodeSelectorTerms:
              - matchExpressions:
                - key: kubernetes.io/os
                  operator: In
                  values:
                  - linux
#                - key: elastic
#                  operator: In
#                  values:
#                  - all
        containers:
        - name: agent
          resources:
            requests:
              cpu: 200m
              memory: 1Gi
            limits:
              cpu: 300m
              memory: 1Gi
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ${ELASTIC_CLUSTER_NAME}-fleet-agent-http
  namespace: ${K8S_NAMESPACE}
  annotations:
    nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
    nginx.ingress.kubernetes.io/ssl-passthrough: "true"
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
  labels:
    agent.k8s.elastic.co/name: ${ELASTIC_CLUSTER_NAME}-fleet
spec:
  rules:
  - host: ${FLEET_URL}
    http:
      paths:
      - backend:
          service:
            name: ${ELASTIC_CLUSTER_NAME}-fleet-agent-http
            port:
              number: 8220
        path: /
        pathType: Prefix
  tls:
  - hosts:
    - ${FLEET_URL}
    secretName: ${ELASTIC_CLUSTER_NAME}-fleet-agent-http-certs-internal
EOF

```

3. Validation/debug

```bash

kubectl -n ${K8S_NAMESPACE} get pod --selector='agent.k8s.elastic.co/name='${ELASTIC_CLUSTER_NAME}'-fleet'

kubectl -n ${K8S_NAMESPACE} logs deploy/${ELASTIC_CLUSTER_NAME}-fleet-agent

kubectl -n ${K8S_NAMESPACE} get agent

kubectl -n ${K8S_NAMESPACE} logs sts/elastic-operator

```



## Elastic agent - install



1. Preparation

```bash

kubectl apply -f - <<EOF
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: elastic-agent
rules:
- apiGroups: [""]
  resources:
  - pods
  - nodes
  - namespaces
  - events
  - services
  - configmaps
  verbs:
  - get
  - watch
  - list
- apiGroups: ["coordination.k8s.io"]
  resources:
  - leases
  verbs:
  - get
  - create
  - update
- nonResourceURLs:
  - "/metrics"
  verbs:
  - get
- apiGroups: ["extensions"]
  resources:
    - replicasets
  verbs:
  - "get"
  - "list"
  - "watch"
- apiGroups:
  - "apps"
  resources:
  - statefulsets
  - deployments
  - replicasets
  verbs:
  - "get"
  - "list"
  - "watch"
- apiGroups:
  - ""
  resources:
  - nodes/stats
  verbs:
  - get
- apiGroups:
  - "batch"
  resources:
  - jobs
  verbs:
  - "get"
  - "list"
  - "watch"
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: elastic-agent
  namespace: ${K8S_NAMESPACE}
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: elastic-agent-${K8S_NAMESPACE}
subjects:
- kind: ServiceAccount
  name: elastic-agent
  namespace: ${K8S_NAMESPACE}
roleRef:
  kind: ClusterRole
  name: elastic-agent
  apiGroup: rbac.authorization.k8s.io
EOF

```


2. Installation agent service

```bash

kubectl apply -f - <<EOF
---
apiVersion: agent.k8s.elastic.co/v1alpha1
kind: Agent
metadata:
  name: ${ELASTIC_CLUSTER_NAME}-service
  namespace: ${K8S_NAMESPACE}
spec:
  version: ${AGENT_VER}
  image: docker.elastic.co/beats/elastic-agent:${AGENT_VER}
  kibanaRef:
    name: ${ELASTIC_CLUSTER_NAME}
  fleetServerRef:
    name: ${ELASTIC_CLUSTER_NAME}-fleet
  mode: fleet
  policyID: eck-agent-service
#  daemonSet:
  deployment:
    replicas: 3
    podTemplate:
      metadata:
        labels:
          scrape: agent
      spec:
#        hostNetwork: true
#        dnsPolicy: ClusterFirstWithHostNet
        serviceAccountName: elastic-agent
        automountServiceAccountToken: true
        affinity:
          nodeAffinity:
            requiredDuringSchedulingIgnoredDuringExecution:
              nodeSelectorTerms:
              - matchExpressions:
                - key: kubernetes.io/os
                  operator: In
                  values:
                  - linux
#                - key: elastic
#                  operator: In
#                  values:
#                  - all
        containers:
        - name: agent
          resources:
            requests:
              memory: 800Mi
              cpu: 1500m
            limits:
              memory: 800Mi
              cpu: 1500m
          volumeMounts:
          - mountPath: /mnt/elastic-internal/http-certs
            name: elastic-internal-http-certificates
            readOnly: true
        securityContext:
          runAsUser: 0
        volumes:
        - name: agent-data
          emptyDir: {}
        - name: elastic-internal-http-certificates
          secret:
            defaultMode: 420
            optional: false
            secretName: ${ELASTIC_CLUSTER_NAME}-kb-http-certs-internal
EOF



```

3. Validation/debug

```bash

kubectl -n ${K8S_NAMESPACE} get pod --selector='agent.k8s.elastic.co/name='${ELASTIC_CLUSTER_NAME}'-service'

#kubectl -n ${K8S_NAMESPACE} logs ds/${ELASTIC_CLUSTER_NAME}-system

kubectl -n ${K8S_NAMESPACE} get agent

kubectl -n ${K8S_NAMESPACE} logs sts/elastic-operator

```


## apm agent - install (option 1 recommended)



1. Installation

```bash

kubectl apply -f - <<EOF
---
apiVersion: v1
kind: Service
metadata:
  name: ${ELASTIC_CLUSTER_NAME}-apm-agent
  namespace: ${K8S_NAMESPACE}
  labels:
    agent.k8s.elastic.co/name: ${ELASTIC_CLUSTER_NAME}-service
    common.k8s.elastic.co/type: agent
spec:
  type: LoadBalancer
  selector:
    agent.k8s.elastic.co/name: ${ELASTIC_CLUSTER_NAME}-service
  ports:
  - protocol: TCP
    port: 8200

---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ${ELASTIC_CLUSTER_NAME}-apm-agent-http
  namespace: ${K8S_NAMESPACE}
  annotations:
    nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
    nginx.ingress.kubernetes.io/ssl-passthrough: "true"
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
  labels:
    apm.k8s.elastic.co/name: ${ELASTIC_CLUSTER_NAME}
spec:
  rules:
  - host: ${APM_HTTP_URL}
    http:
      paths:
      - backend:
          service:
            name: ${ELASTIC_CLUSTER_NAME}-apm-agent
            port:
              number: 8200
        path: /
        pathType: Prefix
  tls:
  - hosts:
    - ${APM_HTTP_URL}
    secretName: ${ELASTIC_CLUSTER_NAME}-kb-http-certs-internal
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ${ELASTIC_CLUSTER_NAME}-apm-agent-grpc
  namespace: ${K8S_NAMESPACE}
  annotations:
    nginx.ingress.kubernetes.io/backend-protocol: "GRPCS"
    nginx.ingress.kubernetes.io/ssl-passthrough: "true"
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
  labels:
    apm.k8s.elastic.co/name: ${ELASTIC_CLUSTER_NAME}
spec:
  rules:
  - host: ${APM_GRPC_URL}
    http:
      paths:
      - backend:
          service:
            name: ${ELASTIC_CLUSTER_NAME}-apm-agent
            port:
              number: 8200
        path: /
        pathType: Prefix
  tls:
  - hosts:
    - ${APM_GRPC_URL}
    secretName: ${ELASTIC_CLUSTER_NAME}-kb-http-certs-internal
EOF


```




2. Validation/debug - during preparation


```bash

kubectl -n ${K8S_NAMESPACE} get pod --selector='apm.k8s.elastic.co/name='${ELASTIC_CLUSTER_NAME}''

kubectl -n ${K8S_NAMESPACE} logs deploy/${ELASTIC_CLUSTER_NAME}-apm-server

kubectl -n ${K8S_NAMESPACE} get apm


kubectl -n ${K8S_NAMESPACE} logs sts/elastic-operator

```

 
```bash 

# option 1 - via go app 


sudo dnf install git -y
curl -LO https://go.dev/dl/go1.22.1.linux-amd64.tar.gz
sudo bash -c 'rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.1.linux-amd64.tar.gz'
export PATH=$PATH:/usr/local/go/bin

 


cat <<EOF> hello.go 
package main

import (
        "fmt"
        "net/http"

        echo "github.com/labstack/echo/v4"

        "go.elastic.co/apm/module/apmechov4"
)

func main() {
        e := echo.New()
        e.Use(apmechov4.Middleware())
        e.GET("/hello/:name", func(c echo.Context) error {
                fmt.Println(c.Param("name"))
                return nil
        })
        http.ListenAndServe(":8080", e)
}
EOF


go mod init example.com/hello
go get github.com/labstack/echo/v4
go get go.elastic.co/apm/module/apmechov4

export ELASTIC_APM_SERVER_URL="https://${APM_HTTP_URL}:443"
export ELASTIC_APM_SECRET_TOKEN=${APM_SECRET_TOKEN}
export ELASTIC_APM_VERIFY_SERVER_CERT='false'
export ELASTIC_APM_SERVICE_NAME='usluga-testowa'
export ELASTIC_APM_SERVICE_NODE_NAME='moj.node.kk.test'
export ELASTIC_APM_LOG_FILE='stderr'
export ELASTIC_APM_LOG_LEVEL='debug'


go run hello.go &

curl http://localhost:8080/hello/world


fg

ctrl+c


# option 2 - via curl 



echo '------------------------------'

#export APM_TOKEN=$(kubectl -n ${K8S_NAMESPACE} get secret/${ELASTIC_CLUSTER_NAME}-apm-token -o go-template='{{index .data "secret-token" | base64decode}}')
export APM_IP=$(kubectl get svc ${ELASTIC_CLUSTER_NAME}-apm-agent -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export APM_PORT=$(kubectl get svc ${ELASTIC_CLUSTER_NAME}-apm-agent -o jsonpath='{.status.loadBalancer.ingress[0].ports[0].port}')
echo "URL: https://$APM_IP:$APM_PORT"
echo "token: ${APM_SECRET_TOKEN}"


curl \
-kvL -X POST "https://$APM_IP:$APM_PORT" \
-H "Authorization: Bearer ${APM_SECRET_TOKEN}"


#option 3 via demo app
#example app: https://github.com/elastic/opentelemetry-demo



kubectl -n ${K8S_NAMESPACE} delete secret elastic-secret


kubectl -n ${K8S_NAMESPACE} create secret generic elastic-secret \
  --from-literal=elastic_apm_endpoint="${APM_HTTP_URL}:443" \
  --from-literal=elastic_apm_secret_token="${APM_SECRET_TOKEN}"


helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts

helm repo update open-telemetry

helm show values open-telemetry/opentelemetry-demo | less

cat <<EOF> /tmp/apm.yaml

opentelemetry-collector:
  mode: "deployment"
  presets:
    kubernetesAttributes:
      enabled: true
    kubernetesEvents:
      enabled: true
    clusterMetrics:
      enabled: true

  extraEnvs:
    - name: ELASTIC_APM_ENDPOINT
      valueFrom:
        secretKeyRef:
          name: elastic-secret
          key: elastic_apm_endpoint
    - name: ELASTIC_APM_SECRET_TOKEN
      valueFrom:
        secretKeyRef:
          name: elastic-secret
          key: elastic_apm_secret_token
  config:
    exporters:
      otlp/elastic:
        endpoint: \${ELASTIC_APM_ENDPOINT}
        compression: none
        headers:
          Authorization: Bearer \${ELASTIC_APM_SECRET_TOKEN}
        tls:
          insecure: true
    receivers:
      otlp:
        protocols:
          grpc:
            endpoint: \${MY_POD_IP}:4317
          http:
            cors:
              allowed_origins:
              - http://*
              - https://*
            endpoint: \${MY_POD_IP}:4318
    service:
      pipelines:
        traces:
          receivers: [otlp]
          processors: [batch]
          exporters: [otlp/elastic]
        metrics:
          receivers: [otlp]
          processors: [batch]
          exporters: [otlp/elastic]
        logs:
          receivers: [otlp]
          processors: [batch]
          exporters: [otlp/elastic]
grafana:
  enabled: false

jaeger:
  enabled: false

prometheus:
  enabled: false

EOF



helm  install -n ${K8S_NAMESPACE} -f /tmp/apm.yaml my-otel-demo open-telemetry/opentelemetry-demo

kubectl logs deploy/my-otel-demo-otelcol -f

```


## Logstash - install 

1. Installation

```bash

kubectl apply -f - <<EOF
---
apiVersion: logstash.k8s.elastic.co/v1alpha1
kind: Logstash
metadata:
  name:  ${ELASTIC_CLUSTER_NAME}
  namespace: ${K8S_NAMESPACE}
  labels:
    scrape: ls
spec:
  count: 1
  version: ${LOGSTASH_VER}
  image: docker.elastic.co/logstash/logstash:${LOGSTASH_VER}
  elasticsearchRefs:
  - clusterName:  eck
    name: ${ELASTIC_CLUSTER_NAME}
  monitoring:
    metrics:
      elasticsearchRefs:
        - name: ${ELASTIC_CLUSTER_NAME}
  pipelines:
    - pipeline.id: main
      config.string: |
        input {
          beats {
            port => 5044
          }
        }
        output {
          elasticsearch {
            hosts => [ "\${ECK_ES_HOSTS}" ]
            user => "\${ECK_ES_USER}"
            password => "\${ECK_ES_PASSWORD}"
            ssl_certificate_authorities => "\${ECK_ES_SSL_CERTIFICATE_AUTHORITY}"
          }
        }
  services:
  - name: beats
    service:
      spec:
        type: LoadBalancer
        selector:
          common.k8s.elastic.co/type: logstash
          logstash.k8s.elastic.co/name: ${ELASTIC_CLUSTER_NAME}
        ports:
          - port: 5044
            name: "filebeat"
            protocol: TCP
            targetPort: 5044
  podTemplate:
    spec:
      containers:
      - name: logstash
        env:
        - name: LS_JAVA_OPTS   
          value: "-Xmx2g -Xms2g"
        resources:
          requests:
            cpu: 1
            memory: 2Gi
          limits:
            cpu: 2
            memory: 2Gi
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: kubernetes.io/os
                operator: In
                values:
                - linux
#              - key: elastic
#                operator: In
#                values:
#                - all
EOF

```


2. Validation

```bash

kubectl -n ${K8S_NAMESPACE} logs deploy/${ELASTIC_CLUSTER_NAME}-validation-beat-filebeat

kubectl -n ${K8S_NAMESPACE} get beats ${ELASTIC_CLUSTER_NAME}-validation

kubectl -n ${K8S_NAMESPACE} delete beat ${ELASTIC_CLUSTER_NAME}-validation

```




## Monitoring stack - install 

1. metricsbeat - preparation 

```bash 

kubectl apply -f - <<EOF
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: metricbeat
rules:
- apiGroups: [""] # "" indicates the core API group
  resources:
  - namespaces
  - pods
  - nodes
  verbs:
  - get
  - watch
  - list
- apiGroups: ["apps"]
  resources:
  - replicasets
  verbs:
  - get
  - list
  - watch
- apiGroups: ["batch"]
  resources:
  - jobs
  verbs:
  - get
  - list
  - watch
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: metricbeat
  namespace: ${K8S_NAMESPACE}
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: metricbeat-${K8S_NAMESPACE}
subjects:
- kind: ServiceAccount
  name: metricbeat
  namespace: ${K8S_NAMESPACE}
roleRef:
  kind: ClusterRole
  name: metricbeat
  apiGroup: rbac.authorization.k8s.io
EOF

```

2. Metrcsbeat - installation 

```bash

kubectl -n ${K8S_NAMESPACE} apply -f - <<EOF
---
apiVersion: beat.k8s.elastic.co/v1beta1
kind: Beat
metadata:
  name: ${ELASTIC_CLUSTER_NAME}-metric-mon
  namespace: ${K8S_NAMESPACE}
spec:
  type: metricbeat
  version: ${METRICSBEAT_VER}
  image: docker.elastic.co/beats/metricbeat:${METRICSBEAT_VER}
  elasticsearchRef:
    name: ${ELASTIC_CLUSTER_NAME}
  config:
    metricbeat:
      autodiscover:
        providers:
          - type: kubernetes
            scope: cluster
            hints.enabled: true
            templates:
              - condition:
                  contains:
                    kubernetes.labels.scrape: es
                config:
                  - module: elasticsearch
                    metricsets:
                      - ccr
                      - cluster_stats
                      - enrich
                      - index
                      - index_recovery
                      - index_summary
                      - ml_job
                      - node_stats
                      - shard
                    period: 10s
                    hosts: "https://\${data.host}:\${data.ports.https}"
                    username: \${MONITORED_ES_USERNAME}
                    password: \${MONITORED_ES_PASSWORD}
                    # WARNING: disables TLS as the default certificate is not valid for the pod FQDN
                    # TODO: switch this to "certificate" when available: https://github.com/elastic/beats/issues/8164
                    ssl.verification_mode: "none"
                    xpack.enabled: true
              - condition:
                  contains:
                    kubernetes.labels.scrape: kb
                config:
                  - module: kibana
                    metricsets:
                      - stats
#                      - status
#                      - settings
#                      - cluster_actions
#                      - cluster_rules
#                      - node_actions
#                      - node_rules
                    period: 10s
                    hosts: "https://\${data.host}:\${data.ports.https}"
                    username: \${MONITORED_ES_USERNAME}
                    password: \${MONITORED_ES_PASSWORD}
                    # WARNING: disables TLS as the default certificate is not valid for the pod FQDN
                    # TODO: switch this to "certificate" when available: https://github.com/elastic/beats/issues/8164
                    ssl.verification_mode: "none"
                    xpack.enabled: true
              - condition:
                  contains:
                    kubernetes.labels.scrape: ls
                config:
                  - module: logstash
                    metricsets:
                      - node
                      - node_stats
                    period: 10s
                    hosts: "http://\${data.host}:9600"
                    username: \${MONITORED_ES_USERNAME}
                    password: \${MONITORED_ES_PASSWORD}
                    ssl.verification_mode: "none"
                    xpack.enabled: true

              - condition:
                  contains:
                    kubernetes.labels.scrape: beat
                config:
                  - module: beat
                    metricsets:
                      - state
                      - stats
                    period: 10s
                    hosts: "http://\${data.host}:9600"
                    username: \${MONITORED_ES_USERNAME}
                    password: \${MONITORED_ES_PASSWORD}
                    ssl.verification_mode: "none"
                    xpack.enabled: true
    processors:
    - add_cloud_metadata: {}
    logging.json: true
  deployment:
    podTemplate:
      metadata:
        labels:
          scrape: beat
      spec:
        serviceAccountName: metricbeat
        automountServiceAccountToken: true
        # required to read /etc/beat.yml
        securityContext:
          runAsUser: 0
        containers:
        - name: metricbeat
          env:
          - name: MONITORED_ES_USERNAME
            value: elastic
          - name: MONITORED_ES_PASSWORD
            valueFrom:
              secretKeyRef:
                key: elastic
                name: ${ELASTIC_CLUSTER_NAME}-es-elastic-user
          resources:
            requests:
              cpu: 100m
              memory: 200Mi
            limits:
              cpu: 100m
              memory: 300Mi

        affinity:
          nodeAffinity:
            requiredDuringSchedulingIgnoredDuringExecution:
              nodeSelectorTerms:
              - matchExpressions:
                - key: kubernetes.io/os
                  operator: In
                  values:
                  - linux
#                - key: elastic
#                  operator: In
#                  values:
#                  - all
EOF



```


3. Metricsbeat - Validation/debug

```bash

kubectl -n ${K8S_NAMESPACE} get pod --selector='beat.k8s.elastic.co/name='${ELASTIC_CLUSTER_NAME}'-metric-mon'

kubectl -n ${K8S_NAMESPACE} get beat

kubectl -n ${K8S_NAMESPACE} logs sts/elastic-operator

```




4. Filebeat - preparation 

```bash 

kubectl apply -f - <<EOF
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: filebeat
rules:
- apiGroups: [""] # "" indicates the core API group
  resources:
  - namespaces
  - pods
  - nodes
  verbs:
  - get
  - watch
  - list
- apiGroups: ["apps"]
  resources:
  - replicasets
  verbs:
  - get
  - list
  - watch
- apiGroups: ["batch"]
  resources:
  - jobs
  verbs:
  - get
  - list
  - watch
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: filebeat
  namespace: ${K8S_NAMESPACE} 
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: filebeat-${K8S_NAMESPACE} 
subjects:
- kind: ServiceAccount
  name: filebeat
  namespace: ${K8S_NAMESPACE} 
roleRef:
  kind: ClusterRole
  name: filebeat
  apiGroup: rbac.authorization.k8s.io
EOF

```

5. Filebeat - installation 

```bash

kubectl apply -f - <<EOF
---
apiVersion: beat.k8s.elastic.co/v1beta1
kind: Beat
metadata:
  name: ${ELASTIC_CLUSTER_NAME}-file-mon
  namespace: ${K8S_NAMESPACE}
spec:
  type: filebeat
  version: ${FILEBEAT_VER}
  image: docker.elastic.co/beats/filebeat:${FILEBEAT_VER}
  elasticsearchRef:
    name: ${ELASTIC_CLUSTER_NAME}
  kibanaRef:
    name: ${ELASTIC_CLUSTER_NAME}
  config:
    filebeat:
      autodiscover:
        providers:
        - type: kubernetes
          node: \${NODE_NAME}
          hints:
            enabled: true
            default_config:
              type: container
              paths:
              - /var/log/containers/*\${data.kubernetes.container.id}.log
    processors:
    - add_cloud_metadata: {}
    - add_host_metadata: {}
    logging.json: true
  daemonSet:
    podTemplate:
      metadata:
        labels:
          scrape: beat
      spec:
        serviceAccountName: filebeat
        automountServiceAccountToken: true
        terminationGracePeriodSeconds: 30
        dnsPolicy: ClusterFirstWithHostNet
        hostNetwork: true # Allows to provide richer host metadata
        securityContext:
          runAsUser: 0
          # If using Red Hat OpenShift uncomment this:
          #privileged: true
        containers:
        - name: filebeat
          volumeMounts:
          - name: varlogcontainers
            mountPath: /var/log/containers
          - name: varlogpods
            mountPath: /var/log/pods
          - name: varlibdockercontainers
            mountPath: /var/lib/docker/containers
          env:
            - name: NODE_NAME
              valueFrom:
                fieldRef:
                  fieldPath: spec.nodeName
          resources:
            requests:
              cpu: 100m
              memory: 200Mi
            limits:
              cpu: 500m
              memory: 500Mi
        volumes:
        - name: varlogcontainers
          hostPath:
            path: /var/log/containers
        - name: varlogpods
          hostPath:
            path: /var/log/pods
        - name: varlibdockercontainers
          hostPath:
            path: /var/lib/rancher/rke2/agent/containerd/io.containerd.grpc.v1.cri/containers
        affinity:
          nodeAffinity:
            requiredDuringSchedulingIgnoredDuringExecution:
              nodeSelectorTerms:
              - matchExpressions:
                - key: kubernetes.io/os
                  operator: In
                  values:
                  - linux
#                - key: elastic
#                  operator: In
#                  values:
#                  - all
EOF

```

6. Metricsbeat - Validation/debug

```bash

kubectl -n ${K8S_NAMESPACE} get pod --selector='beat.k8s.elastic.co/name='${ELASTIC_CLUSTER_NAME}'-file-mon'

kubectl -n ${K8S_NAMESPACE} get beat

kubectl -n ${K8S_NAMESPACE} logs sts/elastic-operator

```

## Summary - list services 

```bash

kubectl -n ${K8S_NAMESPACE} get svc -o \
custom-columns='NAME:.metadata.name,TYPE:.spec.type,IP:..status.loadBalancer.ingress[0].ip,PORT:.status.loadBalancer.ingress[0].ports[0].port' | grep -v 'none'

export ELASTIC_IP=$(kubectl -n ${K8S_NAMESPACE} get svc ${ELASTIC_CLUSTER_NAME}-es-http -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export ELASTIC_PORT=$(kubectl -n ${K8S_NAMESPACE} get svc ${ELASTIC_CLUSTER_NAME}-es-http -o jsonpath='{.status.loadBalancer.ingress[0].ports[0].port}')
export ELASTIC_FQDN=$(kubectl -n ${K8S_NAMESPACE} get ingress ${ELASTIC_CLUSTER_NAME}-es-http -o jsonpath='{.spec.rules[0].host}')

export KIBANA_IP=$(kubectl -n ${K8S_NAMESPACE} get svc ${ELASTIC_CLUSTER_NAME}-kb-http -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export KIBANA_PORT=$(kubectl -n ${K8S_NAMESPACE} get svc ${ELASTIC_CLUSTER_NAME}-kb-http -o jsonpath='{.status.loadBalancer.ingress[0].ports[0].port}')
export KIBANA_FQDN=$(kubectl -n ${K8S_NAMESPACE} get ingress ${ELASTIC_CLUSTER_NAME}-kb-http -o jsonpath='{.spec.rules[0].host}')

export FLEET_IP=$(kubectl -n ${K8S_NAMESPACE} get svc ${ELASTIC_CLUSTER_NAME}-fleet-agent-http -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export FLEET_PORT=$(kubectl -n ${K8S_NAMESPACE} get svc ${ELASTIC_CLUSTER_NAME}-fleet-agent-http -o jsonpath='{.status.loadBalancer.ingress[0].ports[0].port}')
export FLEET_FQDN=$(kubectl -n ${K8S_NAMESPACE} get ingress ${ELASTIC_CLUSTER_NAME}-fleet-agent-http -o jsonpath='{.spec.rules[0].host}')

export APM_IP=$(kubectl -n ${K8S_NAMESPACE} get svc ${ELASTIC_CLUSTER_NAME}-apm-agent -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export APM_PORT=$(kubectl -n ${K8S_NAMESPACE} get svc ${ELASTIC_CLUSTER_NAME}-apm-agent -o jsonpath='{.status.loadBalancer.ingress[0].ports[0].port}')
export APM_HTTP_FQDN=$(kubectl -n ${K8S_NAMESPACE} get ingress ${ELASTIC_CLUSTER_NAME}-apm-agent-http -o jsonpath='{.spec.rules[0].host}')
export APM_GRPC_FQDN=$(kubectl -n ${K8S_NAMESPACE} get ingress ${ELASTIC_CLUSTER_NAME}-apm-agent-grpc -o jsonpath='{.spec.rules[0].host}')



export LOGSTASH_IP=$(kubectl -n ${K8S_NAMESPACE} get svc ${ELASTIC_CLUSTER_NAME}-ls-beats -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export LOGSTASH_PORT=$(kubectl -n ${K8S_NAMESPACE} get svc ${ELASTIC_CLUSTER_NAME}-ls-beats -o jsonpath='{.status.loadBalancer.ingress[0].ports[0].port}')
export LOGSTASH_FQDN='fqdn-not-available'


echo "######################"
echo "${ELASTIC_CLUSTER_NAME} - list available services"
echo "----------------------"
echo "       kibana: FQDN: ${KIBANA_FQDN}     IP: ${KIBANA_IP}:${KIBANA_PORT} (add ip to dns)"
echo "elasticsearch: FQDN: ${ELASTIC_FQDN}    IP: ${ELASTIC_IP}:${ELASTIC_PORT} (add ip to dns)"
echo "        fleet: FQDN: ${FLEET_FQDN}      IP: ${FLEET_IP}:${FLEET_PORT} (add ip to dns)"
echo "apm via https: FQDN: ${APM_HTTP_FQDN}   IP: ${APM_IP}:${APM_PORT} (add ip to dns)"
echo "apm via grpcs: FQDN: ${APM_GRPC_FQDN}   IP: ${APM_IP}:${APM_PORT} (add ip to dns)"
echo "     logstash: FQDN: ${LOGSTASH_FQDN}   IP: ${LOGSTASH_IP}:${LOGSTASH_PORT} (add ip to dns)"
echo "######################"

```

## Summary - credentials

```bash

export ELASTIC_USER=elastic
export ELASTIC_PASSWORD=$(kubectl -n ${K8S_NAMESPACE} get secret ${ELASTIC_CLUSTER_NAME}-es-elastic-user -o go-template='{{.data.elastic | base64decode}}')
#export APM_TOKEN=$(kubectl -n ${K8S_NAMESPACE} get secret/${ELASTIC_CLUSTER_NAME}-apm-token -o go-template='{{index .data "secret-token" | base64decode}}')

echo "######################"
echo "${ELASTIC_CLUSTER_NAME} list credentials"
echo "----------------------"
echo "elasticsearch: LOGIN: ${ELASTIC_USER}, PASSWD: ${ELASTIC_PASSWORD}"
echo "       kibana: LOGIN: ${ELASTIC_USER}, PASSWD: ${ELASTIC_PASSWORD}"
echo "          apm: TOKEN: ${APM_SECRET_TOKEN}"
echo "######################"

```


## Summary - curl validation

1. Kibana curl via Ingress 

```bash 

curl -u "elastic:$ELASTIC_PASSWORD" \
-kL "https://${KIBANA_URL}/api/task_manager/_health" | jq .

```

2. Kibana curl via VIP

```bash

curl -u "elastic:$ELASTIC_PASSWORD" \
-kL "https://$KIBANA_IP:$KIBANA_PORT/api/task_manager/_health" | jq .

```

3. Elasticsearch curl via Ingress 

```bash 

curl -u "elastic:$ELASTIC_PASSWORD" \
-kL "https://${ELASTIC_URL}/_cluster/health" | jq .

```

4. Elasticsearch curl via VIP

```bash

curl -u "elastic:$ELASTIC_PASSWORD" \
-kL "https://$ELASTIC_IP:$ELASTIC_PORT/_cluster/health" | jq .

```

5. APM curl via VIP

```bash 

curl \
-kvL -X POST "https://$APM_IP:$APM_PORT" \
-H "Authorization: Bearer ${APM_TOKEN}"

```


# Rancher - elastic agent integration



## kube-state-metrics installation

1. remove old versions of kube-state-metrics

```bash

curl -fL https://raw.githubusercontent.com/kubernetes/kube-state-metrics/main/examples/standard/cluster-role-binding.yaml | kubectl delete -f -
curl -fL https://raw.githubusercontent.com/kubernetes/kube-state-metrics/main/examples/standard/cluster-role.yaml | kubectl delete -f -
curl -fL https://raw.githubusercontent.com/kubernetes/kube-state-metrics/main/examples/standard/deployment.yaml >> /tmp/deployment.yaml
sed -i 's/seccompProfile://g' /tmp/deployment.yaml
sed -i 's/type: RuntimeDefault//g' /tmp/deployment.yaml
kubectl delete -f /tmp/deployment.yaml
curl -fL https://raw.githubusercontent.com/kubernetes/kube-state-metrics/main/examples/standard/service-account.yaml | kubectl delete -f -
curl -fL https://raw.githubusercontent.com/kubernetes/kube-state-metrics/main/examples/standard/service.yaml | kubectl delete -f -


kubectl -n kube-system delete ds/elastic-agent

```

1. Installation

```bash

curl -fL https://raw.githubusercontent.com/kubernetes/kube-state-metrics/main/examples/standard/cluster-role-binding.yaml | kubectl apply -f -
curl -fL https://raw.githubusercontent.com/kubernetes/kube-state-metrics/main/examples/standard/cluster-role.yaml | kubectl apply -f -
curl -fL https://raw.githubusercontent.com/kubernetes/kube-state-metrics/main/examples/standard/deployment.yaml > /tmp/deployment.yaml
sed -i 's/seccompProfile://g' /tmp/deployment.yaml
sed -i 's/type: RuntimeDefault//g' /tmp/deployment.yaml
kubectl apply -f /tmp/deployment.yaml
curl -fL https://raw.githubusercontent.com/kubernetes/kube-state-metrics/main/examples/standard/service-account.yaml | kubectl apply -f -
curl -fL https://raw.githubusercontent.com/kubernetes/kube-state-metrics/main/examples/standard/service.yaml | kubectl apply -f -

```

2. Verification 

```bash

kubectl -n kube-system get po  -l app.kubernetes.io/name=kube-state-metrics

kubectl -n kube-system logs deploy/kube-state-metrics

```



## elastic-agent via  kubernetes integration wizard 

1. Remove old versions of elastic agent

```bash

kubectl -n kube-system delete role.rbac.authorization.k8s.io,clusterrole.rbac.authorization.k8s.io,sa -l k8s-app=elastic-agent
kubectl -n kube-system delete all -l app=elastic-agent --wait=false
kubectl -n kube-system delete \
rolebinding.rbac.authorization.k8s.io elastic-agent elastic-agent-kubeadm-config 

kubectl -n kube-system delete \
secret elastic-agent-ca

kubectl delete \
clusterrolebinding.rbac.authorization.k8s.io elastic-agent


```

2. clean files from hosts

```bash

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
          - rm -rf /hostfs/var/lib/elastic-agent-managed; ls /hostfs/var/lib
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


```

2. Download elasticsearch CA if you using selfisgned cert or add own ca


```bash

#kubectl -n ${K8S_NAMESPACE} get secret ${ELASTIC_CLUSTER_NAME}-es-transport-certs-public \
#-o go-template='{{index .data "ca.crt" | base64decode}}' > /tmp/remote.ca.crt

kubectl -n ${K8S_NAMESPACE} get secret ${ELASTIC_CLUSTER_NAME}-es-http-certs-public \
-o go-template='{{index .data "tls.crt" | base64decode }}' > /tmp/remote.ca.crt

kubectl -n ${K8S_NAMESPACE} get secret ${ELASTIC_CLUSTER_NAME}-fleet-agent-http-certs-public \
-o go-template='{{index .data "tls.crt" | base64decode }}' >> /tmp/remote.ca.crt



```

3. Go to integrations -> installed integrations -> kubernetes -> Integration polices -> add agent and copy yaml for kubernetes

4. deploy yaml manifest according to information in wizard

5. patch the manifest 

```bash 

export ELASTIC_CLUSTER_NAME=elka-elastic
export AGENT_VER=8.12.2
export FLEET_URL=fleet-tst.apps.rke2.lab.linuxpolska.pl
export K8S_NAMESPACE=elastic

kubectl -n kube-system create secret generic elastic-agent-ca \
--from-file=ca.crt=/tmp/remote.ca.crt -o yaml --dry-run=client | oc apply -f -

kubectl -n kube-system patch ds/elastic-agent -p '
{
    "spec": {
        "template": {
            "spec": {
                "containers": [{
                    "name": "elastic-agent",
                    "image": "docker.elastic.co/beats/elastic-agent:'${AGENT_VER}'",
                    "env": [
                            {
                                "name": "FLEET_INSECURE",
                                "value": "true"
                            },
                            {
                                "name": "FLEET_URL",
                                "value": "https://'${FLEET_URL}':443"
                            }
                    ],
                    "command": [
                            "/usr/bin/env",
                            "bash",
                            "-c",
                            "#!/usr/bin/env bash\nset -e\nif [[ -f /mnt/elastic-internal/elasticsearch-association/'${K8S_NAMESPACE}'/'${ELASTIC_CLUSTER_NAME}'/certs/ca.crt ]]; then\n  if [[ -f /usr/bin/update-ca-trust ]]; then\n    cp /mnt/elastic-internal/elasticsearch-association/'${K8S_NAMESPACE}'/'${ELASTIC_CLUSTER_NAME}'/certs/ca.crt /etc/pki/ca-trust/source/anchors/\n    /usr/bin/update-ca-trust\n  elif [[ -f /usr/sbin/update-ca-certificates ]]; then\n    cp /mnt/elastic-internal/elasticsearch-association/'${K8S_NAMESPACE}'/'${ELASTIC_CLUSTER_NAME}'/certs/ca.crt /usr/local/share/ca-certificates/\n    /usr/sbin/update-ca-certificates\n  fi\nfi\n/usr/bin/tini -- /usr/local/bin/docker-entrypoint -e\n"
                    ],
                    "volumeMounts": [{
                        "mountPath": "/mnt/elastic-internal/elasticsearch-association/'${K8S_NAMESPACE}'/'${ELASTIC_CLUSTER_NAME}'/certs",
                        "name": "elasticsearch-certs"
                    }]
                }],
                "volumes": [
                  {
                      "hostPath": {
                          "path": "/var/lib/rancher/rke2/agent/containerd/io.containerd.grpc.v1.cri/containers",
                          "type": ""
                      },
                      "name": "varlibdockercontainers"
                  },
                  {
                    "name": "elasticsearch-certs",
                        "secret": {
                            "defaultMode": 420,
                            "optional": false,
                            "secretName": "elastic-agent-ca"
                        }
                  }
                ]
            }
        }
    }
}
'


kubectl -n kube-system rollout restart ds/elastic-agent

```

6. Validation/debug

```bash

kubectl -n kube-system get po -o wide -l app=elastic-agent

kubectl -n kube-system logs  ds/elastic-agent



```




# WORK IN PROGRESS

## elastic-agent via elastic operator (deployment only the same cluster as elastic)


1. Preparation 

```bash 

export K8S_NAMESPACE_AGENT=kube-system
kubectl apply -f - <<EOF
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: elastic-agent
subjects:
  - kind: ServiceAccount
    name: elastic-agent
    namespace: ${K8S_NAMESPACE_AGENT}
roleRef:
  kind: ClusterRole
  name: elastic-agent
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  namespace: ${K8S_NAMESPACE_AGENT}
  name: elastic-agent
subjects:
  - kind: ServiceAccount
    name: elastic-agent
    namespace: ${K8S_NAMESPACE_AGENT}
roleRef:
  kind: Role
  name: elastic-agent
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: elastic-agent-kubeadm-config
  namespace: ${K8S_NAMESPACE_AGENT}
subjects:
  - kind: ServiceAccount
    name: elastic-agent
    namespace: ${K8S_NAMESPACE_AGENT}
roleRef:
  kind: Role
  name: elastic-agent-kubeadm-config
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: elastic-agent
  labels:
    k8s-app: elastic-agent
rules:
  - apiGroups: [""]
    resources:
      - nodes
      - namespaces
      - events
      - pods
      - services
      - configmaps
      # Needed for cloudbeat
      - serviceaccounts
      - persistentvolumes
      - persistentvolumeclaims
    verbs: ["get", "list", "watch"]
  # Enable this rule only if planing to use kubernetes_secrets provider
  #- apiGroups: [""]
  #  resources:
  #  - secrets
  #  verbs: ["get"]
  - apiGroups: ["extensions"]
    resources:
      - replicasets
    verbs: ["get", "list", "watch"]
  - apiGroups: ["apps"]
    resources:
      - statefulsets
      - deployments
      - replicasets
      - daemonsets
    verbs: ["get", "list", "watch"]
  - apiGroups:
      - ""
    resources:
      - nodes/stats
    verbs:
      - get
  - apiGroups: [ "batch" ]
    resources:
      - jobs
      - cronjobs
    verbs: [ "get", "list", "watch" ]
  # Needed for apiserver
  - nonResourceURLs:
      - "/metrics"
    verbs:
      - get
  # Needed for cloudbeat
  - apiGroups: ["rbac.authorization.k8s.io"]
    resources:
      - clusterrolebindings
      - clusterroles
      - rolebindings
      - roles
    verbs: ["get", "list", "watch"]
  # Needed for cloudbeat
  - apiGroups: ["policy"]
    resources:
      - podsecuritypolicies
    verbs: ["get", "list", "watch"]
  - apiGroups: [ "storage.k8s.io" ]
    resources:
      - storageclasses
    verbs: [ "get", "list", "watch" ]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: elastic-agent
  # Should be the namespace where elastic-agent is running
  namespace: ${K8S_NAMESPACE_AGENT}
  labels:
    k8s-app: elastic-agent
rules:
  - apiGroups:
      - coordination.k8s.io
    resources:
      - leases
    verbs: ["get", "create", "update"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: elastic-agent-kubeadm-config
  namespace: ${K8S_NAMESPACE_AGENT}
  labels:
    k8s-app: elastic-agent
rules:
  - apiGroups: [""]
    resources:
      - configmaps
    resourceNames:
      - kubeadm-config
    verbs: ["get"]
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: elastic-agent
  namespace: ${K8S_NAMESPACE_AGENT}
  labels:
    k8s-app: elastic-agent
---

EOF


```


2. installation

```bash


kubectl apply -f - <<EOF
---
apiVersion: agent.k8s.elastic.co/v1alpha1
kind: Agent
metadata:
  name: ${ELASTIC_CLUSTER_NAME}-rancher
  namespace: ${K8S_NAMESPACE_AGENT}
spec:
  version: ${AGENT_VER}
  image: docker.elastic.co/beats/elastic-agent:${AGENT_VER}
  kibanaRef:
    name: ${ELASTIC_CLUSTER_NAME}
    namespace: ${K8S_NAMESPACE}
  fleetServerRef:
    name: ${ELASTIC_CLUSTER_NAME}-fleet
    namespace: ${K8S_NAMESPACE}
  mode: fleet
  policyID: 330425fb-1c9d-44b5-a78b-9809d7b0b0cd
#  policyID: eck-agent-service
  daemonSet:
#  deployment:
#    replicas: 3
    podTemplate:
      spec:
        hostNetwork: true
        dnsPolicy: ClusterFirstWithHostNet
        serviceAccountName: elastic-agent
        automountServiceAccountToken: true
        affinity:
          nodeAffinity:
            requiredDuringSchedulingIgnoredDuringExecution:
              nodeSelectorTerms:
              - matchExpressions:
                - key: kubernetes.io/os
                  operator: In
                  values:
                  - linux
#                - key: elastic
#                  operator: In
#                  values:
#                  - all
        containers:
        - name: agent
          resources:
            requests:
              memory: 800Mi
              cpu: 1500m
            limits:
              memory: 800Mi
              cpu: 1500m
          volumeMounts:
          - mountPath: /hostfs/proc
            name: proc
            readOnly: true
          - mountPath: /hostfs/sys/fs/cgroup
            name: cgroup
            readOnly: true
          - mountPath: /var/lib/docker/containers
            name: varlibdockercontainers
            readOnly: true
          - mountPath: /var/log
            name: varlog
            readOnly: true
          - mountPath: /hostfs/etc
            name: etc-full
            readOnly: true
          - mountPath: /hostfs/var/lib
            name: var-lib
            readOnly: true
          - mountPath: /etc/machine-id
            name: etc-mid
            readOnly: true
          - mountPath: /sys/kernel/debug
            name: sys-kernel-debug
          - mountPath: /usr/share/elastic-agent/state
            name: elastic-agent-state
        securityContext:
          runAsUser: 0
        volumes:
        - hostPath:
            path: /proc
            type: ""
          name: proc
        - hostPath:
            path: /sys/fs/cgroup
            type: ""
          name: cgroup
        - hostPath:
            path: /var/lib/rancher/rke2/agent/containerd/io.containerd.grpc.v1.cri/containers
            type: ""
          name: varlibdockercontainers
        - hostPath:
            path: /var/log
            type: ""
          name: varlog
        - hostPath:
            path: /etc
            type: ""
          name: etc-full
        - hostPath:
            path: /var/lib
            type: ""
          name: var-lib
        - hostPath:
            path: /etc/machine-id
            type: File
          name: etc-mid
        - hostPath:
            path: /sys/kernel/debug
            type: ""
          name: sys-kernel-debug
        - hostPath:
            path: /var/lib/elastic-agent-managed/kube-system/state
            type: DirectoryOrCreate
          name: elastic-agent-state
EOF

```


2. Verification 


```bash

kubectl -n kube-system get po -l app=elastic-agent

kubectl -n kube-system logs ds/elastic-agent | grep -i err

kubectl -n kube-system logs ds/${ELASTIC_CLUSTER_NAME}-rancher-agent

kubectl -n ${K8S_NAMESPACE} rollout restart ds/${ELASTIC_CLUSTER_NAME}-rancher-agent


```



## operator uninstall - yaml manifests

```bash
kubectl delete -f https://download.elastic.co/downloads/eck/${ECK_VER}/crds.yaml
kubectl delete -f /tmp/eck-operator.yaml
```

## operator installation - yaml manifests

```bash

kubectl apply -f https://download.elastic.co/downloads/eck/${ECK_VER}/crds.yaml


curl -fL https://download.elastic.co/downloads/eck/${ECK_VER}/operator.yaml > /tmp/eck-operator.yaml

cat /tmp/eck-operator.yaml | grep -i 'image: '

sed -i "s/image: docker.elastic.co\/eck/image: ${REG_HOSTNAME}\/${REG_NAMESPACE}/g" /tmp/eck-operator.yaml

cat /tmp/eck-operator.yaml | grep -i 'image: '

kubectl apply -f /tmp/eck-operator.yaml


#kubectl -n elastic-system create secret docker-repo repo-auth \
#--docker-server ${REG_HOSTNAME} \
#--docker-username ${REG_USERNAME_PULL} \
#--docker-password ${REG_PASSWD_PULL}

#kubectl -n elastic-system patch serviceaccount elastic-operator \
#-p '{"imagePullSecrets": [{"name": "repo-auth"}]}'
#kubectl -n elastic-system patch serviceaccount default \
#-p '{"imagePullSecrets": [{"name": "repo-auth"}]}'

kubectl -n elastic-system rollout restart statefulset/elastic-operator

kubectl -n elastic-system get po

kubectl -n elastic-system logs -f statefulset/elastic-operator

```


## operator upgrade  - yaml manifests


```bash

kubectl replace -f https://download.elastic.co/downloads/eck/${ECK_VER}/crds.yaml


kubectl create -f https://download.elastic.co/downloads/eck/${ECK_VER}/crds.yaml


curl -fL https://download.elastic.co/downloads/eck/${ECK_VER}/operator.yaml > /tmp/eck-operator.yaml

cat /tmp/eck-operator.yaml | grep -i 'image: '

sed -i "s/image: docker.elastic.co\/eck/image: ${REG_HOSTNAME}\/${REG_NAMESPACE}/g" /tmp/eck-operator.yaml

cat /tmp/eck-operator.yaml | grep -i 'image: '

kubectl apply -f /tmp/eck-operator.yaml



```


## apm standalone - install (option 2 optional - do not install)


```bash

kubectl -n ${K8S_NAMESPACE} apply -f - <<EOF
apiVersion: apm.k8s.elastic.co/v1
kind: ApmServer
metadata:
  name: ${ELASTIC_CLUSTER_NAME}
  namespace: ${K8S_NAMESPACE}
spec:
  http:
    service:
      spec:
        type: LoadBalancer
    tls:
      selfSignedCertificate:
        disabled: true
#        subjectAltNames:
#        - dns: ${APM_HTTP_URL}
  version: ${APM_VER}
  image: docker.elastic.co/apm/apm-server:${APM_VER}
  count: 1
  elasticsearchRef:
    name: ${ELASTIC_CLUSTER_NAME}
  kibanaRef:
    name: ${ELASTIC_CLUSTER_NAME}
  podTemplate:
    metadata:
      labels:
        scrape: apm
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: kubernetes.io/os
                operator: In
                values:
                - linux
#              - key: elastic
#                operator: In
#                values:
#                - all
      containers:
      - name: apm-server
        resources:
          requests:
            memory: 500Mi
          limits:
            memory: 512Mi

EOF

```


## logstash - example logs, validation


```bash


kubectl apply -f - <<EOF
---
apiVersion: beat.k8s.elastic.co/v1beta1
kind: Beat
metadata:
  name: ${ELASTIC_CLUSTER_NAME}-validation
  namespace: ${K8S_NAMESPACE}
spec:
  type: filebeat
  version: ${FILEBEAT_VER}
  image: docker.elastic.co/beats/filebeat:${FILEBEAT_VER}
  kibanaRef:
    name: ${ELASTIC_CLUSTER_NAME}
  config:
    filebeat.inputs:
      - type: log
        paths:
          - /data/logstash-tutorial.log
    output.logstash:
      hosts: 
      - "${ELASTIC_CLUSTER_NAME}-ls-beats:5044"
  deployment:
    podTemplate:
      metadata:
        labels:
          scrape: beat
      spec:
        automountServiceAccountToken: true
        initContainers:
          - name: download-tutorial
            image: curlimages/curl
            command: ["/bin/sh"]
            args: ["-c", "curl -L https://download.elastic.co/demos/logstash/gettingstarted/logstash-tutorial.log.gz | gunzip -c > /data/logstash-tutorial.log"]
            volumeMounts:
              - name: data
                mountPath: /data
        containers:
          - name: filebeat
            volumeMounts:
              - name: data
                mountPath: /data
              - name: beat-data
                mountPath: /usr/share/filebeat/data
        volumes:
          - name: data
            emptydir: {}
          - name: beat-data
            emptydir: {}
EOF


```
