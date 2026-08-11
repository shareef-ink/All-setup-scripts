
#!/bin/bash

# install trivy
# while running the script ./trivy.sh

apt update -y
apt install -y wget gpg

wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | \
  gpg --dearmor -o /usr/share/keyrings/trivy.gpg

echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" \
  > /etc/apt/sources.list.d/trivy.list

apt update -y
apt install -y trivy

trivy --version

