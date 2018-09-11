#!/bin/bash
cd ~
# Update one or all packages on your system 
sudo yum update -y
sudo echo "1. Update one or all packages on your system "

# Intall the Wget 
sudo yum install wget -y
sudo echo "2. Intall the Wget"

# Install Curl on ReadHat
sudo yum install curl -y
sudo echo "2. a Intall the CURL"

# Java Installation , work from home dir 
# Download RPM JDK 1.8 and accept license
cd ~ 
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.rpm"
sudo echo "3. Download RPM JDK 1.8 and accept license "

# perform installation 
sudo yum localinstall -y jdk-8u181-linux-x64.rpm
sudo echo "4. Java Installation"

# Export the Java_HOME
sudo echo "5. Export the Java_HOME"
export JAVA_HOME=/usr/java/jdk1.8.0_181-amd64/jre

# If you want JAVA_HOME to be set for every user on the system by default, add the previous line to the /etc/environment file.
sudo sh -c "echo export JAVA_HOME=/usr/java/jdk1.8.0_181-amd64/jre >> /etc/environment"
echo $JAVA_HOME
sudo echo "6. Establish symbolic link for the Java_HOME"

# Remove JDK the downloaded .rpm
cd ~
rm jdk-8u181-linux-x64.rpm 
sudo echo "7. Remove downloaded JDK RPM"

# Download and install the RPM manually
cd ~
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.3.2.rpm

# -------------------  Calculate the SHA 
# wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.3.2.rpm.sha512
# shasum -a 512 -c elasticsearch-6.3.2.rpm.sha512

# Installation of the Elasticsearch 6.3.2 
sudo rpm --install elasticsearch-6.3.2.rpm


# To configure Elasticsearch to start automatically when the system boots up,
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service

# Start the Elasticsearch  Cluster
sudo systemctl start elasticsearch.service

# Check the status of the Cluster 
sudo -i service elasticsearch status

curl -X GET "localhost:9200/"
