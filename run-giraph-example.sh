#!/bin/bash

cd $GIRAPH_HOME

$HADOOP_HOME/bin/hdfs dfs -put tiny-graph.txt /user/root/input/tiny-graph.txt

$HADOOP_HOME/bin/hadoop jar \
 /usr/local/giraph/giraph-examples/target/giraph-examples-1.1.0-for-hadoop-2.7.1-jar-with-dependencies.jar \
 org.apache.giraph.GiraphRunner org.apache.giraph.examples.SimplePageRankComputation \
 --yarnjars giraph-examples-1.1.0-for-hadoop-2.7.1-jar-with-dependencies.jar \
 --workers 1 \
 --vertexInputFormat org.apache.giraph.io.formats.JsonLongDoubleFloatDoubleVertexInputFormat \
 --vertexInputPath /user/root/input/tiny-graph.txt \
 --vertexOutputFormat org.apache.giraph.io.formats.IdWithValueTextOutputFormat \
 --outputPath /user/root/output

$HADOOP_HOME/bin/hdfs dfs -cat /user/root/output/part-m-00001
