# Airflow


Add helm repo
```bash
helm repo add airflow-stable https://airflow-helm.github.io/charts
helm repo update
```
Install airflow chart.
```bash
helm install <release-name> airflow-stable/airflow
```
You could optionally define --namespace, ---version and --values.
```bash
export RELEASE_NAME=my-airflow-cluster # set a name!
export NAMESPACE=my-airflow-namespace # set a namespace!
export CHART_VERSION=8.X.X # set a version!
export VALUES_FILE=./custom-values.yaml # set your values file path!

helm install \
  $RELEASE_NAME \
  airflow-stable/airflow \
  --namespace $NAMESPACE \
  --version $CHART_VERSION \
  --values $VALUES_FILE
```
Forward web ui port.
```bash
kubectl port-forward svc/<release-name>-web 8080
```
Default user - *admin*, password - *admin*

To terminate airflow:
```bash
helm uninstall <release-name>
```
