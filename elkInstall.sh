#!/bin/bash

### Script to install Java 1.8, Elasticsearch 6.3.2 and Kibana 6.3.2 on Red Hat 7.5 machine 
## Reference [1] Elastic search RPM - https://www.elastic.co/guide/en/elasticsearch/reference/current/rpm.html 
### Reference [1] Kibana -  https://www.elastic.co/guide/en/kibana/current/rpm.html

### -------------------  Red Hat System Update ------------------- 
cd ~
# Update one or all packages on your system 
sudo yum update -y
sudo echo "1. Update one or all packages on your system "

# Intall the Wget 
sudo yum install wget -y
sudo echo "2. Intall the Wget"

# Install Curl on ReadHat
sudo yum install curl -y
sudo echo "2.a Install Curl on ReadHat"

# Install Nano on ReadHat
sudo yum install nano -y
sudo echo "2.b Install Nano on ReadHat"


### -------------------  Install JDK ------------------- 
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
java -version

# Remove JDK the downloaded .rpm
cd ~
rm jdk-8u181-linux-x64.rpm 
sudo echo "7. Remove downloaded JDK RPM"

### -------------------  Download and Install Elastic Search ------------------- 
# Download and install Elastic Search the RPM manually
cd ~
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.3.2.rpm

sudo echo "7. Download and install Elastic Search the RPM manually "

# -------------------  Calculate the SHA 
# wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.3.2.rpm.sha512
# shasum -a 512 -c elasticsearch-6.3.2.rpm.sha512

# Installation of the Elasticsearch 6.3.2 
sudo rpm --install elasticsearch-6.3.2.rpm
sudo echo "8. Installation of the Elasticsearch 6.3.2 "

# To configure Elasticsearch to start automatically when the system boots up,
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo echo "9. Configure Elasticsearch to start automatically when the system boots up"

# Start the Elasticsearch  Cluster
sudo systemctl start elasticsearch.service
# Wait for 25 Seconds 
sleep 25s 
sudo echo "10. Start the Elasticsearch  Cluster"

# Check the status of the Cluster 
sudo systemctl status elasticsearch.service
sudo echo "11. Check the status of the Cluster "
curl -X GET "localhost:9200/"


### -------------------  Download and Install Kibana  ------------------- 
# Download the Kibana RPM Package 
wget https://artifacts.elastic.co/downloads/kibana/kibana-6.3.2-x86_64.rpm
sudo echo "12. Download the Kibana RPM Package "

# Intall the Kibana with RPM
sudo rpm --install kibana-6.3.2-x86_64.rpm
sudo echo "13. Intall the Kibana with RPM"


# configure Kibana to start automatically when the system boots up
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable kibana.service
sudo echo "14. configure Kibana to start automatically when the system boots up"

# Kibana start the service  
sudo systemctl start kibana.service
# Wait for 25 Seconds 
sleep 25s 
sudo echo "15.  Kibana start the service  "

sudo systemctl status kibana.service
curl -X GET "localhost:5601"
 
