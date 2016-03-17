#! /bin/bash

ping -c1 lathe &> /dev/null
if [ $? -ne 0 ]; then
    echo "consider adding '192.168.10.10 lathe' to /etc/hosts"
else
    echo "lathe already contained in /etc/hosts. that's good."
fi
