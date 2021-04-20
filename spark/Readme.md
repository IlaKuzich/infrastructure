# Spark

(Install hadoop first)

You can check distributive on https://www2.apache.paket.ua/spark

Download spark distributive
```bash
wget https://www2.apache.paket.ua/spark/spark-3.1.1/spark-3.1.1-bin-hadoop3.2.tgz
```
Unpack spark
```bash
tar -xvf spark-3.1.1-bin-hadoop3.2.tg
```
Add env variables
```bash
export SPARK_HOME=~/infra_experiments/spark/spark-3.1.1-bin-hadoop3.2
export PATH=$PATH:$SPARK_HOME/bin
```

**Start Hadoop**

Make sure, that hadoop is properly configured in `$HADOOP_HOME/etc/hadoop/`.

`core-site.xml`
```xml
<configuration>
  <property>
    <name>fs.defaultFS</name>
    <value>hdfs://localhost:9000</value>
  </property>
</configuration>
```
`hdfs-site.xml`
```xml
<configuration>
  <property>
    <name>dfs.datanode.data.dir</name>
    <value>file:///opt/hadoop_tmp/hdfs/datanode</value>
  </property>
  <property>
    <name>dfs.namenode.name.dir</name>
    <value>file:///opt/hadoop_tmp/hdfs/namenode</value>
  </property>
  <property>
    <name>dfs.replication</name>
    <value>1</value>
  </property>
</configuration> 
```

Create hadoop directories:
```bash
sudo mkdir -p /opt/hadoop_tmp/hdfs/datanode
sudo mkdir -p /opt/hadoop_tmp/hdfs/namenode
sudo chown user:user -R /opt/hadoop_tmp
```
`mapred-site.xml`
```xml
<configuration>
  <property>
    <name>mapreduce.framework.name</name>
    <value>yarn</value>
  </property>
</configuration>
```
`yarn-site.xml`
```xml
<configuration>
  <property>
    <name>yarn.nodemanager.aux-services</name>
    <value>mapreduce_shuffle</value>
  </property>
  <property>
    <name>yarn.nodemanager.auxservices.mapreduce.shuffle.class</name>  
    <value>org.apache.hadoop.mapred.ShuffleHandler</value>
  </property>
</configuration> 
```

**Start hdfs and yarn**
```bash
cd $HADOOP_HOME
sbin/start-dfs.sh
sbin/start-yarn.sh
```
Check if everything is working:
```bash
jps
```
You should see a NameNode and a DataNode, at minimum, in that list. Check that HDFS is behaving correctly by trying to create a directory, then listing the contents of the HDFS:
```bash
hdfs dfs -mkdir /test
hdfs dfs -ls /
```
**Test spark-shell**

Copy file from examples to hdfs
```bash
hdfs dfs -put $SPARK_HOME/examples/src/main/resources/users.parquet /users.parquet
```
Start spark-shell
```bash
spark-shell
```
```scala
val df = spark.read.parquet("hdfs://localhost:9000/users.parquet")
df.collect.foreach(println)
```
**Spart spark job on yarn**

```bash
cd $SPARK_HOME/bin
spark-submit --class org.apache.spark.examples.SparkPi \
    --master yarn \
    --deploy-mode cluster \
    --driver-memory 4g \
    --executor-memory 2g \
    --executor-cores 1 \
    examples/jars/spark-examples*.jar \
    10
```
Check YARN cluster http://localhost:8088/cluster

**Shutdown hadoop**

```bash
cd $HADOOP_HOME
sbin/stop-dfs.sh
sbin/stop-yarn.sh
```

**Links**
* https://dev.to/awwsmm/installing-and-running-hadoop-and-spark-on-ubuntu-18-393h
* https://spark.apache.org/docs/latest/running-on-yarn.html
