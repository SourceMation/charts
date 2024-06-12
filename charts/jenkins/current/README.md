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

#Create own keystore and convert to base64 / utworzenie wlasnego keystore i konwersja do base64
cat keystore.jks | base64

cat <<EOF > values.yaml
controller:
  installPlugins:
    - kubernetes:4230.vceef11cb_ca_37
    - workflow-aggregator:596.v8c21c963d92d
    - git:5.2.2
    - configuration-as-code:1807.v0175eda_00a_20
  additionalPlugins:
    - pipeline-stage-view:2.34
    - pipeline-utility-steps:2.16.2
    - generic-webhook-trigger:2.2.1
    - gitea:1.4.7
    - rebuild:332.va_1ee476d8f6d

  httpsKeyStore:
    enable: true
    jenkinsHttpsJksSecretName: ""
    jenkinsHttpsJksSecretKey: "jenkins-jks-file"
    jenkinsHttpsJksPasswordSecretName: ""
    jenkinsHttpsJksPasswordSecretKey: "https-jks-password"
    disableSecretMount: false
    httpPort: 8081
    path: "/var/jenkins_keystore"
    fileName: "keystore.jks"
    password: "password"
    jenkinsKeyStoreBase64Encoded: |
      (hashed value of keystore generated before)

  serviceType: ClusterIP
  resources:
    requests:
      memory: "2Gi"
      cpu: "1000m"
    limits:
      memory: "4Gi"
      cpu: "2000m"

  persistence:
    enabled: true
    existingClaim: jenkins-pvc
    size: 50Gi
    storageClass: jenkins-sc
    annotations: {}
    accessMode: ReadWriteOnce

  adminSecret:
    enabled: true
    useExisting: false
    user: admin
    password: auto  # Automatically generated

  javaOpts: >
    -Xmx2g
    -Djenkins.install.runSetupWizard=false
    -Dorg.jenkinsci.plugins.casc.ConfigurationAsCode.systemConfig=/var/jenkins_home/casc_configs/jenkins-casc.yaml

  JCasC:
    configScripts:
      jenkins-setup: |
        jenkins:
          systemMessage: "Welcome to Jenkins analyzed by SourceMation!"
          numExecutors: 4
          securityRealm:
            local:
              allowsSignup: false
              users:
                - id: "${JENKINS_USER}"
                  password: "${JENKINS_PASS}"
          authorizationStrategy:
            roleBased:
              roles:
                global:
                  - name: "admin"
                    description: "Admin role with all permissions"
                    permissions:
                      - "Overall/Administer"
                    assignments:
                      - "${JENKINS_USER}"
          unclassified:
            location:
              url: "https://${JENKINS_HOST}/"
          tool:
            git:
              installations:
                - name: "Default"
                  home: "/usr/bin/git"

EOF
```

## Installation via helm / Instalacja przy użyciu helm
```bash
helm upgrade --install ${JENKINS_NAME} --repo https://charts.jenkins.io ${JENKINS_NAME} --version ${CHART_VERSION} -f values.yaml
```

## Remove default seccompProfile / usuniecie domyslnego seccompProfile
```bash
kubectl edit statefulset.apps/${JENKINS_NAME}-jenkins

  seccompProfile:
    type: RuntimeDefault
```

# Ingress creation / Utworzenie ingress

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

# Admin password retrieval / Uzyskanie hasla administratora

```bash
kubectl get secret ${JENKINS_NAME}-jenkins -n ${JENKINS_NAMESPACE} -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode
```
