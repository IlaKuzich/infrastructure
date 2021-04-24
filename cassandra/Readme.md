# Cassandra

**Install with helm**

Install helm if it is not installed.
```bash
brew install helm
```
Add `bitnami` chart repo:
```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
```
Install cassandra chart:
```bash
helm install <installation name> bitnami/cassandra
```
Expose cassandra `9042` port
```bash
kubectl port-forward svc/<installation name>-cassandra 9042
```

**Download cassandra client:**
Download cassandra distribution
```bash
wget https://apache.ip-connect.vn.ua/cassandra/3.11.10/apache-cassandra-3.11.10-bin.tar.gz --no-check-certificate
```
Unpack cassanda
```bash
tar -xvf apache-cassandra-3.11.10-bin.tar.gz 
```
Login to cassandra
```bash
bin/cqlsh -u cassandra
```
Password you can find on cassandra stateful set configuration
