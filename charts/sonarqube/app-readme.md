## Overview

SonarQube is an on-premise analysis tool designed to detect coding issues in 30+ languages, frameworks, and IaC platforms. 

## Prerequisites

- Kubernetes 1.26+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure
- An Ingress controller installed within the cluster
- The kernel vm.max_map_count ≥ 262144 set on the worker node

For more information on how to configure the Helm chart, refer to the Helm Chart README.
