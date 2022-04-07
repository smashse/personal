#!/bin/bash

sudo sh -c "
  apt update --fix-missing; 
  apt -y install apt-transport-https bash-completion \
   ca-certificates conntrack curl ethtool gnupg2 htop \
   ipset mlocate nano net-tools nftables socat software-properties-common \
   tar unzip wget xz-utils;
  apt -y dist-upgrade;
  apt -y autoremove
"
