# Kafka

**Kubernetes setup**

Install helm if it hasn't been installed yet.
```bash
brew install helm
```
Add `bitnami` helm charts
```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
```
Install `kafka` chart
```bash
helm install <kafka installation name> bitnami/kafka
```
Uninstall chart
```bash
helm uninstall <kafka installation name>
```
