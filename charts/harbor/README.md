## General

### Are you looking for more information?

1. Based on: https://github.com/goharbor/harbor-helm
2. Documentation: https://goharbor.io/docs/2.11.0/
3. Chart Source: https://github.com/SourceMation/charts/tree/main/charts/harbor

## CLI installation

### Preparation

#### Create namespace.
```bash
NAMESPACE=harbor
kubectl create ns $NAMESPACE
```

### Go go helm - minimal configuration

To make harbor functional, configure at least:
- `harbor.expose.ingress.hosts.core`
- `harbor.externalURL`

To configure fields from above and other, you may:
- edit `values.yaml`
- use `--set` option. Example:
```
NAMESPACE=harbor
RELEASENAME=harbor
FQDN=harbor.example.com
helm -n $NAMESPACE upgrade --install $RELEASENAME . --set "harbor.expose.ingress.hosts.core=$FQDN" --set "harbor.externalURL=https://$FQDN"
```

Example for upgrade / install with `values-override.yaml` file:
``` bash
NAMESPACE=harbor
RELEASENAME=harbor
FQDN=harbor.example.com

cat << EOF > values-override.yaml
harbor:
  expose:
    ingress:
      hosts:
        core: $FQDN
  externalURL: https://$FQDN
EOF

helm -n $NAMESPACE upgrade --install $RELEASENAME \
--repo https://sourcemation.github.io/charts/ harbor \
-f values-override.yaml
```

### Integrate with **cert-manager**

To take advantage on cert-manager integration, ensure that it is installed and configured in the kubernetes cluster. [See](https://github.com/SourceMation/charts/tree/main/charts/cert-manager).

To integrate harbor ingress with cert-manager for ingress tls managment the following values must be properly set:
- `certManager.ingress.enabled=true`
- `certManager.issuerKind` choose `ClusterIssuer` or `Issuer` if namespaced issuer is configured in same namespace as harbor. Usually `ClusterIssuer` is used.
- `certManager.issuerName` set name to same issuer which is configured.

Example script which deploy harbor with **cert-manager** integration:
```
NAMESPACE=harbor
RELEASENAME=harbor
FQDN=harbor.example.com
ISSUER_KIND=ClusterIssuer
ISSUER_NAME=default-selfsigned-ca
helm -n $NAMESPACE upgrade --install $RELEASENAME . \
    --set "harbor.expose.ingress.hosts.core=$FQDN" --set "harbor.externalURL=https://$FQDN" \
    --set "certManager.ingress.enabled=true" \
    --set "certManager.ingress.issuerKind=$ISSUER_KIND" \
    --set "certManager.ingress.issuerName=$ISSUER_NAME"
```

### Integration with **Prometheus**

To take advantage on Prometheus integration, ensure that it is installed and configured in the kubernetes cluster. [See](https://ranchermanager.docs.rancher.com/integrations-in-rancher/monitoring-and-alerting).

To integrate harbor with Promethus, configure values in `harbor.metrics.*`. Minimal configuration which enables this integration contains setting:
- `harbor.metrics.enabled=true`
- `harbor.metrics.serviceMonitor.enabled=true`

Example script which deploy harbor with **Prometheus** integration:
```
NAMESPACE=harbor
RELEASENAME=harbor
FQDN=harbor.example.com
helm -n $NAMESPACE upgrade --install $RELEASENAME . \
    --set "harbor.expose.ingress.hosts.core=$FQDN" --set "harbor.externalURL=https://$FQDN" \
    --set "harbor.metrics.enabled=true" \
    --set "harbor.metrics.serviceMonitor.enabled=true"
```

### Data traceing

Harbor facilitates integration with data tracers like **otel** or **jaeger**. Configuration is contained in values `harbor.trace.*`.

## Validation and Testing

```bash
NAMESPACE=harbor
kubectl -n $NAMESPACE get po
```

## CLI removing

```bash
NAMESPACE=harbor
RELEASENAME=harbor
helm -n $NAMESPACE uninstall $RELEASENAME
# Delete remaining PVCs
kubectl -n $NAMESPACE get pvc | sed -n '/'"$RELEASENAME"'/s/ .*//p' | xargs kubectl delete pvc -n $NAMESPACE
```

## Known Issues

> **Note:**
> Notify us: https://github.com/SourceMation/charts/issues
