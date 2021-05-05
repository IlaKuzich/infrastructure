#HDFS operations

**DFS Admin**

Create directory.
```bash
hdfs dfs -mkdir /user
hdfs dfs -mkdir /user/hadoop
```
or with path param
```bash
hdfs dfs -mkdir -p /user/hadoop
```
Check what is in directory.
```bash
hdfs dfs -ls /user
```

**FS Shell**

Create a directory named /foodir
```bash
hadoop dfs -mkdir /foodir
```
Remove a directory named /foodir
```bash
bin/hadoop fs -rm -R /foodir
```
View the contents of a file named /foodir/myfile.txt
```bash
hadoop dfs -cat /foodir/myfile.txt
```
