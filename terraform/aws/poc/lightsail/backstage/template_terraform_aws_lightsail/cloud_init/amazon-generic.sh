#!/bin/bash

sudo sh -c "
  yum update -y;
  yum install -y bash-completion bash-completion-extras \
   curl deltarpm device-mapper-persistent-data htop \
   ipset lvm mlocate nano net-tools tar unzip wget xz \
   yum-plugin-downloadonly yum-plugin-versionlock yum-utils;
  yum upgrade -y
"
