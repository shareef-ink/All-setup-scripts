
#!/bin/bash

# install aws cli 
# while run the script manually sudo ./awscli.sh
apt update -y
apt install -y curl unzip

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip

unzip -q /tmp/awscliv2.zip -d /tmp

/tmp/aws/install

aws --version

rm -rf /tmp/aws /tmp/awscliv2.zip

