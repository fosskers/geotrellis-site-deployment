#!/bin/bash

# Normal Dependencies
apt-get update
apt-get install -y openjdk-8-jre-headless openjdk-8-jdk-headless htop

# Environment
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/" >> /home/ubuntu/.profile
