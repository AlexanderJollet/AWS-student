#!/usr/bin/env bash

apt -y update && apt -y upgrade
echo bastion > /etc/hostname
hostname bastion
touch /tmp/cloud-init-ok
