## Overview

NeuVector provides a powerful end-to-end container security platform. This includes end-to-end vulnerability scanning and complete run-time protection for containers, pods and hosts, including:

* CI/CD Vulnerability Management & Admission Control. Scan images with a Jenkins plug-in, scan registries, and enforce admission control rules for deployments into production.
* Violation Protection. Discovers behavior and creates a whitelist based policy to detect violations of normal behavior.
* Threat Detection. Detects common application attacks such as DDoS and DNS attacks on containers.
* DLP and WAF Sensors. Inspect network traffic for Data Loss Prevention of sensitive data, and detect common OWASP Top10 WAF attacks.
* Run-time Vulnerability Scanning. Scans registries, images and running containers orchestration platforms and hosts for common (CVE) as well as application specific vulnerabilities.
* Compliance & Auditing. Runs Docker Bench tests and Kubernetes CIS Benchmarks automatically.
* Endpoint/Host Security. Detects privilege escalations, monitors processes and file activity on hosts and within containers, and monitors container file systems for suspicious activity.
* Multi-cluster Management. Monitor and manage multiple Kubernetes clusters from a single console.

Other features of NeuVector include the ability to quarantine containers and to export logs through SYSLOG and webhooks, initiate packet capture for investigation, and integration with OpenShift RBACs, LDAP, Microsoft AD, and SSO with SAML. Note: Quarantine means that all network traffic is blocked. The container will remain and continue to run - just without any network connections. Kubernetes will not start up a container to replace a quarantined container, as the api-server is still able to reach the container.
