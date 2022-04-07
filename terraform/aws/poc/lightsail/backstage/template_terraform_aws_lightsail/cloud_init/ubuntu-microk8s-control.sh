#!/bin/bash

sudo sh -c "
  apt update --fix-missing;
  snap refresh;
  snap install kubectl --classic;
  snap install helm --classic;
  snap install microk8s --classic;
  microk8s status --wait-ready;
  microk8s add-node --token-ttl 126144000 --token 868f88ee477f893de65c99d906e767dcaf59ce10fe30795ef9b2d11af4faefa;
  microk8s enable dns ingress prometheus storage;
"
