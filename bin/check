#! /bin/bash

ping -c1 -t1 192.168.10.10 &> /dev/null
if [ $? -ne 0 ]; then
    echo "lathe does not appear to be up. consider 'vagrant up'."
    exit 0
fi

ping -c1 -t1 lathe &> /dev/null
if [ $? -ne 0 ]; then
    echo "consider adding '192.168.10.10 lathe' to /etc/hosts"
else
    echo "lathe already contained in /etc/hosts. that's good."
fi
