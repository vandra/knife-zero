#!/usr/bin/env bash

set -xe

/usr/sbin/sshd -E /tmp/log -o 'LogLevel DEBUG'
sed -ri 's/^session\s+required\s+pam_loginuid.so$/session optional pam_loginuid.so/' /etc/pam.d/sshd

knife rehash
knife zero diagnose

# Use Ipaddress
knife helper exec boot_ipaddress --print-only
knife helper exec boot_ipaddress
knife node show zerohost
knife helper exec converge_ipaddress --print-only
knife helper exec converge_ipaddress

# Use Name
knife helper exec boot_name --print-only
knife helper exec boot_name
knife node show 127.0.0.1
knife helper exec converge_name --print-only
knife helper exec converge_name
knife helper exec converge2_name
