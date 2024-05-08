<p align="center">
    <img width="300px" height=auto src="https://github.com/linuxpolska/ezd-rp/blob/release/1.0.0/docs/LinuxPolska-icon.png" />
</p>


<p align="center">
    <a href="https://github.com/bitnami/charts"><img src="https://badgen.net/github/stars/SourceMation/charts?icon=github" /></a>
    <a href="https://github.com/bitnami/charts"><img src="https://badgen.net/github/forks/SourceMation/charts?icon=github" /></a>
</p>


# The Linux Polska Charts for Kubernetes


Our repository contains set of helm charts which allow you to install desired services on Kubernetes using [Helm](https://github.com/helm/helm).




## Table of content
- [Before you begin](PREREQUISITES.md)
- [Installation](charts/README.md)


## Getting Started

The best way to get started is with the  ["Before you begin"](PREREQUISITES.md), ["Installation"](charts/README.md) 
section in the documentation.


## Package versioning

Versioning for charts:


Example versioning `1.2.3`:

* `1.` - adding new functionality for instance: new chelm chart with minio, postfix server, change mongodb chart on totally different
* `2.` - update version of helm chart for instance from mongodb 4.x to 7.x, modify content of helm charts
* `3.` - change default values in helm chart, for instance tag version, default parameters in existing release of charts


Image versioning

Example versioning `0.15.0-el-9-r1`:

* `0.15.0` - version of rpm package use in solution or any number if you build main service from sources during container build
* `el-9` - version of image uses in section FROM (containerfile). For instance `FROM  quay.io/eurolinux/eurolinux-9:latest`
* `r1` - changes in dockerfile

Please use the following to reach members of the community:


- GitHub:  If you have any questions start a [discussion](https://github.com/sourcemation/charts/discussions) or if you want make changes open an [issue](https://github.com/sourcemation/charts/issues)  
- Web Page: If you need commercial support [contact with us](https://linuxpolska.com/pl/kontakt/)

We are supporting polish and english language.
