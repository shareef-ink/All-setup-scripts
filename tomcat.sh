sudo yum install java -y
cd /opt
sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.117/bin/apache-tomcat-9.0.117.tar.gz
sudo tar -xvf /opt/apache-tomcat-9.0.117.tar.gz

cd /opt/apache-tomcat-9.0.117/webapps/manager/META-INF

sed -i '/<Context/,/<\/Context>/c\<Context antiResourceLocking="false" privileged="true" >\n</Context>' context.xml


cd /opt/apache-tomcat-9.0.117/conf
sudo mv tomcat-users.xml tomcat-users_bkup_21apr2026.xml
sudo touch tomcat-users.xml
sudo echo '<?xml version="1.0" encoding="utf-8"?>
        <tomcat-users>
        <role rolename="manager-gui"/>
        <user username="tomcat" password="tomcat" roles="manager-gui, manager-script, manager-status"/>
        </tomcat-users>' > tomcat-users.xml

cd /opt/apache-tomcat-9.0.117/conf/
sudo sed -i 's/Connector port="8080"/Connector port="8081"/g' server.xml
sudo /opt/apache-tomcat-9.0.117/bin/startup.sh

====================================================================
====================================================================

Docker file for Tomcat setup:
-----------------------------

Dockerfile:

FROM amazonlinux:latest
LABEL maintainer="Madhukiran <madhu@gmail.com>"
RUN yum install java wget tar gzip -y && \
    yum clean all 

WORKDIR /opt
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.117/bin/apache-tomcat-9.0.117.tar.gz && \
    tar -xvf /opt/apache-tomcat-9.0.117.tar.gz && \
	rm -rf apache-tomcat-9.0.117.tar.gz
RUN sed -i '/<Context/,/<\/Context>/c\<Context antiResourceLocking="false" privileged="true" >\n</Context>' /opt/apache-tomcat-9.0.117/webapps/manager/META-INF/context.xml

WORKDIR /opt/apache-tomcat-9.0.117/conf
RUN mv tomcat-users.xml tomcat-users_bkup_9May2026.xml && \
    echo '<?xml version="1.0" encoding="utf-8"?>  \
        <tomcat-users> \
        <role rolename="manager-gui"/> \
        <user username="tomcat" password="tomcat" roles="manager-gui, manager-script, manager-status"/> \
        </tomcat-users>' > tomcat-users.xml   && \

    sed -i 's/Connector port="8080"/Connector port="8081"/g' server.xml

CMD ["/opt/apache-tomcat-9.0.117/bin/catalina.sh", "run" ]
EXPOSE 8081
