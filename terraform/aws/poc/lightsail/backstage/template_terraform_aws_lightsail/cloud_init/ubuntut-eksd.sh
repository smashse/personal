#!/bin/bash

sudo sh -c "
  apt update --fix-missing;
  snap refresh;
  snap install kubectl --classic;
  snap install eks --edge --classic;
  eks status --wait-ready;
  apt -y dist-upgrade;
  apt -y autoremove
"
