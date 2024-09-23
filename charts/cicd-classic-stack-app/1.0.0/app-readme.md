## CICD-Classic Stack App


This chart is based on the following upstream charts:
- **Coder** as development environment
- **Forgejo** as git scm repository
- **SonarQube** as static code analyzer 
- **Jenkins** as automation server
- **Harbor** as container registry

The CICD-Classic-Stack-App deploys a set of apps that are essential for CI/CD workflows.

For more information on how to use the feature, refer to our [docs](https://github.com/sourcemation/charts).


## Prerequisites

- Kubernetes 1.26+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure


For more information on how to configure the Helm chart, refer to the Helm Chart README.