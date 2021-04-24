# Nifi

**Kubernetes setup**

Install helm if not exists

```bash
brew install helm
```
Add repo cetic
```bash
helm repo add cetic https://cetic.github.io/helm-charts
```
Install nifi helm chart
```bash
helm install <nifi installation name> cetic/nifi
```
**For minikube only:**

 Modify `<nifi installation name>-nifi` service type to NodePort
 Expose nifi endpoint 
 ```bash
 minikube service <nifi installation name>-nifi
```

Uninstall nifi
```bash
helm uninstall <nifi installation name>
```
