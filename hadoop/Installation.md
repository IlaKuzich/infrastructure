# Hadoop 3

Hadoop 3 is not compatible with sqoop. If you need sqoop use Hadoop 2

**Instalation**

Prerequisites: java must be installed

Download hadoop distribution
```bash
wget https://www2.apache.paket.ua/hadoop/common/hadoop-3.3.0/hadoop-3.3.0.tar.gz
```

You can get versions of hadoop here https://www2.apache.paket.ua/hadoop/

Unpack hadoop distribution.

```bash
tar -xvf hadoop-3.3.0.tar.gz
```
Run example, to verify whether everything is working
```bash
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.0.jar grep input output 'dfs[a-z.]+'
```

**Pseudo-Distributed Operation**

Modify configuration

etc/hadoop/core-site.xml:
```xml
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>
    </property>
</configuration>
```

etc/hadoop/hdfs-site.xml
```xml
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
</configuration>
```

Enable ssh access to localhost. 

On mac you should enable SSH access in System Preferences.

**Execution**

The following instructions are to run a MapReduce job locally. If you want to execute a job on YARN, see YARN on Single Node.

Format the filesystem:

```bash
bin/hdfs namenode -format
```
  
Start NameNode daemon and DataNode daemon:
```bash
sbin/start-dfs.sh
```
The hadoop daemon log output is written to the $HADOOP_LOG_DIR directory (defaults to $HADOOP_HOME/logs).

Browse the web interface for the NameNode; by default it is available at:

NameNode - http://localhost:9870/
Make the HDFS directories required to execute MapReduce jobs:
```bash
  bin/hdfs dfs -mkdir /user
  bin/hdfs dfs -mkdir /user/<username>
```

  
Copy the input files into the distributed filesystem:
```bash
bin/hdfs dfs -mkdir input
bin/hdfs dfs -put etc/hadoop/*.xml input
```

Run some of the examples provided:
```bash
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.0.jar grep input output 'dfs[a-z.]+'
```
Examine the output files: Copy the output files from the distributed filesystem to the local filesystem and examine them:
```bash
  bin/hdfs dfs -get output output
  cat output/*
```
or

View the output files on the distributed filesystem:
````bash
bin/hdfs dfs -cat output/*
````
When you’re done, stop the daemons with:
```bash
sbin/stop-dfs.sh
```
 
**Run with YARN**

You can run a MapReduce job on YARN in a pseudo-distributed mode by setting a few parameters and running ResourceManager daemon and NodeManager daemon in addition.

The following instructions assume that 1. ~ 4. steps of the above instructions are already executed.

Configure parameters as follows:

etc/hadoop/mapred-site.xml:

```xml
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
    <property>
        <name>mapreduce.application.classpath</name>
        <value>$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/*:$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/lib/*</value>
    </property>
</configuration>
```
etc/hadoop/yarn-site.xml:
```xml
<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
    <property>
        <name>yarn.nodemanager.env-whitelist</name>
        <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PREPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME</value>
    </property>
</configuration>
```
Start ResourceManager daemon and NodeManager daemon:
```bash
sbin/start-yarn.sh
```
Check if everything is working:
```bash
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.10.1.jar grep input output 'dfs[a-z.]+'
```
  
Browse the web interface for the ResourceManager; by default it is available at:

ResourceManager - http://localhost:8088/

Run a MapReduce job.
```bash
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.0.jar grep input output 'dfs[a-z.]+'
```

When you’re done, stop the daemons with:
```bash
sbin/stop-yarn.sh
```

# Hadoop 2

Download hadoop 2 distribution
```bash
wget https://www2.apache.paket.ua/hadoop/common/hadoop-2.10.1/hadoop-2.10.1.tar.gz
```
Export hadoop 2 distribution
```bash
tar -xvf hadoop-2.10.1.tar.gz
```
Override HADOOP_HOME if version 3 is present
```bash
export HADOOP_HOME=~/infra_experiments/hadoop/hadoop-2.10.1
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPPED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/bin
```

Modify configuration

etc/hadoop/core-site.xml:
```xml
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>
    </property>
</configuration>
```

etc/hadoop/hdfs-site.xml
```xml
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
</configuration>
```


Format the filesystem:

```bash
bin/hdfs namenode -format
```
  
Start NameNode daemon and DataNode daemon:
```bash
sbin/start-dfs.sh
```
The hadoop daemon log output is written to the $HADOOP_LOG_DIR directory (defaults to $HADOOP_HOME/logs).

Browse the web interface for the NameNode; by default it is available at:

NameNode - http://localhost:9870/
Make the HDFS directories required to execute MapReduce jobs:
```bash
  bin/hdfs dfs -mkdir /user
  bin/hdfs dfs -mkdir /user/<username>
```

  
Copy the input files into the distributed filesystem:
```bash
bin/hdfs dfs -mkdir input
bin/hdfs dfs -put etc/hadoop/*.xml input
```
Run example:
```bash
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.10.1.jar grep input output 'dfs[a-z.]+'
```

# Troubleshooting

If datanode is not starting probably namespace is corrupted and you have to format hdfs see:

https://www.cs.brandeis.edu/~cs147a/lab/hadoop-troubleshooting/
