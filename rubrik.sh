#!/bin/bash

url=https://east-ist-packages.mit.edu/rubrik/rubrik-east
package='rubrik-agent.x86_64.rpm'
package2='rubrik-agent.x86_64.deb'
manager='yum'
manager2='apt'
options='install -y'
dir='/tmp/rubrik-install'

#Create Temporary Dir
mkdir $dir

#Navigate to DIr
cd $dir

# Check if the script is run as root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root."
    exit 1
fi

# Check if the operating system is Linux or Unix
if [ -f /etc/redhat-release ]; then
    # RHEL/CentOS
    wget $url/rubrik-agent.x86_64.rpm

elif [ -f /etc/lsb-release ]; then
    # Ubuntu/Debian
    wget $url/rubrik-agent.x86_64.deb

else
    echo "Unsupported operating system."
    exit 1
fi

 #Install Package
if [ -f /etc/redhat-release ]; then
    # RHEL/CentOS
     sudo $manager $options $dir/$package


elif [ -f /etc/lsb-release ]; then
    # Ubuntu/Debian
    sudo $manager2 $options $dir/$package2

else
    echo "Unsupported operating system."
    exit 1
fi

#Clean up

echo "Cleaning up...."
rm -rf $dir/rubrik-agent.*
rmdir $dir

echo "Installation Completed"
