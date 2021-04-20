# Hive

**Installation**

Download hive distribution
```bash
wget https://apache.ip-connect.vn.ua/hive/hive-3.1.2/apache-hive-3.1.2-bin.tar.gz
```
Unpack hive
```bash
tar xzf apache-hive-3.1.2-bin.tar.gz
```

Add hive and hadoop variables to env.
```bash
export HADOOP_HOME=~/infra_experiments/hadoop/hadoop-3.3.0
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPPED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/bin

export HIVE_HOME=~/infra_experiments/hive/apache-hive-3.1.2-bin
export PATH=$PATH:$HIVE_HOME/bin
```
**Create Hive Directories in HDFS**

Create two separate directories to store data in the HDFS layer:

 * The temporary, tmp directory is going to store the intermediate results of Hive processes.
 * The warehouse directory is going to store the Hive related tables.
 
**Create tmp Directory**

Create a tmp directory within the HDFS storage layer. This directory is going to store the intermediary data Hive sends to the HDFS:

```bash
hdfs dfs -mkdir /tmp
```
Add write and execute permissions to tmp group members:
```bash
hdfs dfs -chmod g+w /tmp
```
Check if the permissions were added correctly:
```bash
hdfs dfs -ls /
```

**Create warehouse Directory**

Create the warehouse directory within the /user/hive/ parent directory:
```bash
hdfs dfs -mkdir -p /user/hive/warehouse
```
Add write and execute permissions to warehouse group members:
```bash
hdfs dfs -chmod g+w /user/hive/warehouse
```
Check if the permissions were added correctly:
```bash
hdfs dfs -ls /user/hive
```

**Configure hive-site.xml File**

Apache Hive distributions contain template configuration files by default. The template files are located within the Hive conf directory and outline default Hive settings.

Use the following command to locate the correct file:

```bash
cd $HIVE_HOME/conf
```
Use the hive-default.xml.template to create the hive-site.xml file:
```bash
cp hive-default.xml.template hive-site.xml
```
Access the hive-site.xml file using the nano text editor:
```bash
vim hive-site.xml
```
Using Hive in a stand-alone mode rather than in a real-life Apache Hadoop cluster is a safe option for newcomers. You can configure the system to use your local storage rather than the HDFS layer by setting the hive.metastore.warehouse.dir parameter value to the location of your Hive warehouse directory.
```xml
<configuration>
<!-- at the begging of file -->
  <property>
    <name>system:java.io.tmpdir</name>
    <value>/tmp/hive/java</value>
  </property>
  <property>
    <name>system:user.name</name>
    <value>${user.name}</value>
  </property>

<!-- change hive.metastore.warehouse.dir value to -->

  <property>
    <name>hive.metastore.warehouse.dir</name>
    <value>/user/hive/warehouse</value>
    <description>location of default database for the warehouse</description>
  </property>
  
 </configuration>

```
Also there could be some issues with encoding in description. I've deleted illegal symbols. 

**Initiate Derby Database**
Apache Hive uses the Derby database to store metadata. Initiate the Derby database, from the Hive bin directory using the schematool command:
```bash
cd $HIVE_HOME/bin
./schematool -dbType derby -initSchema 
```

**How to Fix guava Incompatibility Error in Hive**

If the Derby database does not successfully initiate,  you might receive an error with the following content:

“Exception in thread “main” java.lang.NoSuchMethodError: com.google.common.base.Preconditions.checkArgument(ZLjava/lang/String;Ljava/lang/Object;)V”

This error indicates that there is most likely an incompatibility issue between Hadoop and Hive guava versions.

```bash
rm $HIVE_HOME/lib/guava-19.0.jar
cp $HADOOP_HOME/share/hadoop/hdfs/lib/guava-27.0-jre.jar $HIVE_HOME/lib/
```

**Launch Hive Client Shell on Ubuntu**

```bash
cd $HIVE_HOME/bin
hive
```
