# Setup a Kubernetes Cluster

The quickest way to setup a Kubernetes cluster to install LP Charts is following the "Get Started" guides for the different services:

- [Get Started with LP Charts using RKE2 Kubernetes](https://docs.rke2.io/install/quickstart)

For setting up Kubernetes on other cloud platforms or bare-metal servers refer to the Kubernetes [getting started guide](https://kubernetes.io/docs/getting-started-guides/).

# Install Helm
 
Helm is a tool for managing Kubernetes charts. Charts are packages of pre-configured Kubernetes resources.

To install Helm, refer to the [Helm install guide](https://github.com/helm/helm#install) and ensure that the `helm` binary is in the `PATH` of your shell.

## Using Helm

Once you have installed the Helm client, you can deploy a LP Helm Chart into a Kubernetes cluster.

Please refer to the [Quick Start guide](https://helm.sh/docs/intro/quickstart/) if you wish to get running in just a few commands, otherwise the [Using Helm Guide](https://helm.sh/docs/intro/using_helm/) provides detailed instructions on how to use the Helm client to manage packages on your Kubernetes cluster.

Useful Helm Client Commands:

- Add SourceMation chart repo: `helm repo add sourcemation https://charts.sourcemation.com`
- Install a chart: `helm install my-release sourcemation/<chart>`
- Upgrade your application: `helm upgrade my-release sourcemation/<chart>`

# Install PV Provisioner
You must install solution which support RWX and RWO PVCs

The quickest way to setup CSI is go to [CSI page](https://kubernetes-csi.github.io/docs/drivers.html)

## REQUIREMENTS

- Kubernetes 1.19+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure 
