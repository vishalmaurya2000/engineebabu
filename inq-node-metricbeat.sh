if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

echo "Please enter a server tag"
read tag
if [ -z "$tag" ]; then
    echo "server tag is empty. exiting...."
    exit 1
fi


function aptInstall {
    sudo apt --purge remove  metricbeat -y
    sudo apt-get update -y
    sudo wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
    apt-get install apt-transport-https -y
    echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
    sudo apt-get update -y && sudo apt-get install metricbeat=7.14.2 -y
    sudo echo 'setup.template.enabled: false' >>/etc/metricbeat/metricbeat.yml
    sudo echo 'setup.ilm.enabled: false' >>/etc/metricbeat/metricbeat.yml
    sudo echo 'output.elasticsearch.index: "inq-node-metricbeat-%{+yyyy.MM}-w-%{+ww}"' >>/etc/metricbeat/metricbeat.yml
    sudo echo 'setup.template.overwrite: true' >>/etc/metricbeat/metricbeat.yml
    sudo echo 'setup.template.name: "inq-node-metricbeat"' >>/etc/metricbeat/metricbeat.yml
    sudo echo 'setup.template.pattern: "inq-node-metricbeat-*"' >>/etc/metricbeat/metricbeat.yml
    sudo echo 'tags: ["'$tag'"]' >>/etc/metricbeat/metricbeat.yml
    sudo echo 'cloud.id: "inq-elastic:ZXVyb3BlLXdlc3QyLmdjcC5lbGFzdGljLWNsb3VkLmNvbSQ1NGRjNjAzNDNhM2I0NmQzYTI2ODQwYWE3N2RjNDZkMyQ2MDM1NzU0ZTFlMDc0YzE2OTFiNGZkYmRlOGJmMDQwYw=="' >>/etc/metricbeat/metricbeat.yml
    sudo echo 'cloud.auth: "edge-ai-node:4rRst4fTzx9GdWw"' >>/etc/metricbeat/metricbeat.yml
    sudo metricbeat modules enable system
    sudo systemctl enable metricbeat
    sudo systemctl restart metricbeat
}

function yumInstall {
    sudo rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch
    cat >/etc/yum.repos.d/elastic-7.x.repo <<EOL
[elastic-7.x]
name=Elastic repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOL
    sudo yum remove  metricbeat	-y
    sudo yum install metricbeat-7.14.2 -y
    sudo echo 'setup.template.enabled: false' >>/etc/metricbeat/metricbeat.yml
    sudo echo 'setup.ilm.enabled: false' >>/etc/metricbeat/metricbeat.yml
    sudo echo 'output.elasticsearch.index: "inq-node-metricbeat-%{+yyyy.MM}-w-%{+ww}"' >>/etc/metricbeat/metricbeat.yml
    sudo echo 'setup.template.overwrite: true' >>/etc/metricbeat/metricbeat.yml
    sudo echo 'setup.template.name: "inq-node-metricbeat"' >>/etc/metricbeat/metricbeat.yml
    sudo echo 'setup.template.pattern: "inq-node-metricbeat-*"' >>/etc/metricbeat/metricbeat.yml
    sudo echo 'tags: ["'$tag'"]' >>/etc/metricbeat/metricbeat.yml
    sudo echo 'cloud.id: "inq-elastic:ZXVyb3BlLXdlc3QyLmdjcC5lbGFzdGljLWNsb3VkLmNvbSQ1NGRjNjAzNDNhM2I0NmQzYTI2ODQwYWE3N2RjNDZkMyQ2MDM1NzU0ZTFlMDc0YzE2OTFiNGZkYmRlOGJmMDQwYw=="' >>/etc/metricbeat/metricbeat.yml
    sudo echo 'cloud.auth: "edge-ai-node:4rRst4fTzx9GdWw"' >>/etc/metricbeat/metricbeat.yml
    sudo systemctl enable metricbeat
    sudo systemctl restart metricbeat
}

if cat /etc/*release | grep ^NAME | grep CentOS; then
    echo "==============================================="
    echo "Installing Metricbeat on CentOS"
    echo "==============================================="
    yumInstall
elif cat /etc/*release | grep ^NAME | grep Red; then
    echo "==============================================="
    echo "Installing Metricbeat on RedHat"
    echo "==============================================="
    yumInstall
elif cat /etc/*release | grep ^NAME | grep Fedora; then
    echo "================================================"
    echo "Installing Metricbeat on Fedorea"
    echo "================================================"
    yumInstall
elif cat /etc/*release | grep ^NAME | grep Ubuntu; then
    echo "==============================================="
    echo "Installing Metricbeat on Ubuntu"
    echo "==============================================="
    aptInstall
elif cat /etc/*release | grep ^NAME | grep Debian; then
    echo "==============================================="
    echo "Installing Metricbeat on Debian"
    echo "==============================================="
    aptInstall
elif cat /etc/*release | grep ^NAME | grep Mint; then
    echo "============================================="
    echo "Installing Metricbeat on Mint"
    echo "============================================="
    aptInstall
else
    echo "OS NOT DETECTED, couldn't install package Metricbeat"
    exit 1
fi
