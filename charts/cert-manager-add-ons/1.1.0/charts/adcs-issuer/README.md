# adcs-issuer

## Chart Overview

ADCS Issuer plugin for cert-manager.

### Chart Details

- **Chart Name:** adcs-issuer
- **Version:** ![Version: 2.1.2](https://img.shields.io/badge/Version-2.1.2-informational?style=flat-square)
- **App Version:** ![AppVersion: 2.1.2](https://img.shields.io/badge/AppVersion-2.1.2-informational?style=flat-square)
- **Chart Type:** ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

**Homepage:** <https://github.com/djkormo/adcs-issuer>

## Source Code

* <https://github.com/djkormo/adcs-issuer>
* <https://djkormo.github.io/adcs-issuer/>

## Requirements

Kubernetes: `>=1.16.0`

| Repository | Name | Version |
|------------|------|---------|
| https://charts.jetstack.io | cert-manager | >=1.9 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| controllerManager.affinity.nodeAffinity | object | `{}` |  |
| controllerManager.affinity.podAffinity | object | `{}` |  |
| controllerManager.affinity.podAntiAffinity | object | `{}` |  |
| controllerManager.arguments.cluster-resource-namespace | string | `"adcs-issuer"` |  |
| controllerManager.arguments.disable-approved-check | string | `"false"` |  |
| controllerManager.arguments.enable-leader-election | string | `"true"` |  |
| controllerManager.arguments.zap-log-level | int | `5` |  |
| controllerManager.caCertsSecretName | string | `"ca-certificates"` |  |
| controllerManager.enabledCaCerts | bool | `false` |  |
| controllerManager.enabledWebHooks | bool | `false` |  |
| controllerManager.environment.ENABLE_DEBUG | string | `"false"` |  |
| controllerManager.environment.ENABLE_WEBHOOKS | string | `"false"` |  |
| controllerManager.environment.KUBERNETES_CLUSTER_DOMAIN | string | `"cluster.local"` |  |
| controllerManager.manager.image.repository | string | `"djkormo/adcs-issuer"` |  |
| controllerManager.manager.image.tag | string | `"2.1.2"` |  |
| controllerManager.manager.livenessProbe.httpGet.path | string | `"/healthz"` |  |
| controllerManager.manager.livenessProbe.httpGet.port | int | `8081` |  |
| controllerManager.manager.livenessProbe.httpGet.scheme | string | `"HTTP"` |  |
| controllerManager.manager.livenessProbe.periodSeconds | int | `10` |  |
| controllerManager.manager.livenessProbe.timeoutSeconds | int | `10` |  |
| controllerManager.manager.readinessProbe.httpGet.path | string | `"/readyz"` |  |
| controllerManager.manager.readinessProbe.httpGet.port | int | `8081` |  |
| controllerManager.manager.readinessProbe.httpGet.scheme | string | `"HTTP"` |  |
| controllerManager.manager.readinessProbe.initialDelaySeconds | int | `10` |  |
| controllerManager.manager.readinessProbe.periodSeconds | int | `20` |  |
| controllerManager.manager.readinessProbe.timeoutSeconds | int | `20` |  |
| controllerManager.manager.resources.limits.cpu | string | `"100m"` |  |
| controllerManager.manager.resources.limits.memory | string | `"500Mi"` |  |
| controllerManager.manager.resources.requests.cpu | string | `"100m"` |  |
| controllerManager.manager.resources.requests.memory | string | `"100Mi"` |  |
| controllerManager.rbac.certManagerNamespace | string | `"cert-manager"` |  |
| controllerManager.rbac.certManagerServiceAccountName | string | `"cert-manager"` |  |
| controllerManager.rbac.enabled | bool | `true` |  |
| controllerManager.rbac.serviceAccountName | string | `"adcs-issuer"` |  |
| controllerManager.replicas | int | `1` |  |
| controllerManager.securityContext.runAsUser | int | `1000` |  |
| crd.install | bool | `true` |  |
| metricsService.enabled | bool | `true` |  |
| metricsService.ports[0].name | string | `"https"` |  |
| metricsService.ports[0].port | int | `8443` |  |
| metricsService.ports[0].targetPort | string | `"https"` |  |
| metricsService.type | string | `"ClusterIP"` |  |
| nodeSelector | object | `{}` |  |
| simulator.affinity.nodeAffinity | object | `{}` |  |
| simulator.affinity.podAffinity | object | `{}` |  |
| simulator.affinity.podAntiAffinity | object | `{}` |  |
| simulator.arguments.dns | string | `"adcs-sim-service.adcs-issuer.svc,adcs2.example.com"` |  |
| simulator.arguments.ips | string | `"10.10.10.1,10.10.10.2"` |  |
| simulator.arguments.port | int | `8443` |  |
| simulator.certificateDuration | string | `"2160h"` |  |
| simulator.certificateRenewBefore | string | `"360h"` |  |
| simulator.clusterIssuserName | string | `"adcs-sim-adcsclusterissuer"` |  |
| simulator.configMapName | string | `"adcs-sim-configmap"` |  |
| simulator.containerPort | int | `8443` |  |
| simulator.containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| simulator.containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| simulator.containerSecurityContext.readOnlyRootFilesystem | bool | `true` |  |
| simulator.deploymentName | string | `"adcs-sim-deployment"` |  |
| simulator.enabled | bool | `false` |  |
| simulator.environment.ENABLE_DEBUG | string | `"false"` |  |
| simulator.exampleCertificate.enabled | bool | `true` |  |
| simulator.exampleCertificate.name | string | `"adcs-sim-certificate"` |  |
| simulator.image.repository | string | `"djkormo/adcs-sim"` |  |
| simulator.image.tag | string | `"0.0.6"` |  |
| simulator.issuerGroup | string | `"cert-manager.io"` |  |
| simulator.issuerKind | string | `"Issuer"` |  |
| simulator.issuerName | string | `"adcs-sim-issuer"` |  |
| simulator.livenessProbe.httpGet.path | string | `"/healthz"` |  |
| simulator.livenessProbe.httpGet.port | int | `8443` |  |
| simulator.livenessProbe.httpGet.scheme | string | `"HTTPS"` |  |
| simulator.livenessProbe.periodSeconds | int | `10` |  |
| simulator.livenessProbe.timeoutSeconds | int | `10` |  |
| simulator.podSecurityContext.runAsUser | int | `1000` |  |
| simulator.readinessProbe.httpGet.path | string | `"/readyz"` |  |
| simulator.readinessProbe.httpGet.port | int | `8443` |  |
| simulator.readinessProbe.httpGet.scheme | string | `"HTTPS"` |  |
| simulator.readinessProbe.initialDelaySeconds | int | `10` |  |
| simulator.readinessProbe.periodSeconds | int | `20` |  |
| simulator.readinessProbe.timeoutSeconds | int | `20` |  |
| simulator.resources.limits.cpu | string | `"100m"` |  |
| simulator.resources.limits.memory | string | `"500Mi"` |  |
| simulator.resources.requests.cpu | string | `"100m"` |  |
| simulator.resources.requests.memory | string | `"100Mi"` |  |
| simulator.secretCertificateName | string | `"adcs-sim-certificate-secret"` |  |
| simulator.secretName | string | `"adcs-sim-secret"` |  |
| simulator.serviceName | string | `"adcs-sim-service"` |  |
| simulator.servicePort | int | `8443` |  |
| webhookService.ports[0].port | int | `443` |  |
| webhookService.ports[0].targetPort | int | `9443` |  |
| webhookService.type | string | `"ClusterIP"` |  |

### Configuration

To install the chart with the release name `adcs-issuer`:

```bash
helm install adcs-issuer adcs-issuer --namespace <namespace> --create-namespace
```
