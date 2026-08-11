
#!/bin/bash

# Install Terraform
# must run the script as a "sudo" user or sudo ./terraform.sh
apt update -y
apt install -y wget gpg

wget -O- https://apt.releases.hashicorp.com/gpg | \
  gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com noble main" \
> /etc/apt/sources.list.d/hashicorp.list

apt update -y
apt install -y terraform

terraform -version
