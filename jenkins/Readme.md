# Jenkins

Add helm repo.
```bash
helm repo add jenkinsci https://charts.jenkins.io
helm repo update
```
Install jenkins
```bash
helm install <release-name> jenkinsci/jenkins
```
Expose port `8080`
```bash
kubectl port-forward <release-name>-jenkins 8080
```
!!! Note this installation is not persistent. !!!

Follow this guide if you want not to lose anything after reboot.

https://www.jenkins.io/doc/book/installing/kubernetes/
