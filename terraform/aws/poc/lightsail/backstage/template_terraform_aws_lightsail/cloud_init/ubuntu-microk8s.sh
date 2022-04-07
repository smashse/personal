#!/bin/bash

sudo sh -c "
  apt update --fix-missing;
  snap refresh;
  snap install kubectl --classic;
  snap install helm --classic;
  snap install microk8s --classic;
  microk8s status --wait-ready;
  microk8s add-node --token-ttl 126144000 --token 868f88ee477f893de65c99d906e767dcaf59ce10fe30795ef9b2d11af4faefa;
  microk8s enable dns ingress;
  mkdir -p /home/ubuntu/.kube;
  usermod -a -G microk8s ubuntu;
  chown -f -R ubuntu /home/ubuntu/.kube;
  microk8s config > /home/ubuntu/.kube/config;
  chmod 0600 /home/ubuntu/.kube/config;
  chown -R ubuntu: /home/ubuntu/.kube/config;
  export KUBECONFIG=/home/ubuntu/.kube/config;
  apt -y dist-upgrade;
  apt -y autoremove
"