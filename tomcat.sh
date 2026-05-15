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
