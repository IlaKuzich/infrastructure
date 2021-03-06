# Minikube

**Instalation**

https://kubernetes.io/ru/docs/tasks/tools/install-minikube/

For macOS

```bash
brew install minikube
```
or from binary
```bash
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64 \
  && chmod +x minikube
  
sudo mv minikube /usr/local/bin
```

To check installation run 
```bash
minikube status
```
Start kubernetes 
```bash
minikube start --kubernetes-version v1.14.0
```
You can specify minikube config in KUBECONFIG e.g ~/.kube/config

**Troubleshooting**

If minikube falls with unsupported version specify version (like in example below).
If you see the following issue ⛔  Exiting due to RSRC_INSUFFICIENT_REQ_MEMORY: Requested memory allocation 0MiB is less than the usable minimum of 1800MB
```bash
minikube delete
```
and than restart
```bash
minikube start
```
If 
 * Configuring RBAC rules .../ E0420 15:54:13.630867    2850 start.go:131] Unable to scale down deployment "coredns" in namespace "kube-system" to 1 replica: timed out waiting for the condition

Try to wipe out all minikube data
```bash
minikube delete --all
minikube delete --purge
```
