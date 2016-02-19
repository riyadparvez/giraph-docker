#!/bin/bash

# exit on error
set -o errexit

PREFIX=/usr/local

# TODO: do this in hadoop docker instance
echo Ensure Java 1.7 stays set as default....
alternatives --install /usr/bin/java java /usr/java/latest/bin/java 1
alternatives --set java /usr/java/latest/bin/java
alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 1
alternatives --set javac /usr/java/latest/bin/javac

echo Installing maven....
curl -L# https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo > /etc/yum.repos.d/epel-apache-maven.repo
yum install -y maven2 wget git

echo Installing prebuilt Giraph....

cd $PREFIX
curl https://apache.googlesource.com/giraph/+archive/release-1.1.tar.gz > giraph-1.1.tar.gz
mkdir giraph-1.1
tar -xf giraph-1.1.tar.gz -C giraph-1.1
rm -f giraph-1.1.tar.gz
ln -s giraph-1.1 giraph
cd giraph
patch -p0 < /etc/giraph_compile.patch
mvn -Phadoop_yarn -Dhadoop.version=2.7.1 -DskipTests clean package

echo Installing Zookeeper....
curl -L# 'http://apache.claz.org/zookeeper/current/zookeeper-3.4.6.tar.gz' | tar -xz -C $PREFIX
ln -s $PREFIX/zookeeper-3.4.6 $PREFIX/zookeeper
