#!/bin/bash

#Create The Kubernetes Environment
sudo sh -c "
  apt update --fix-missing;
  snap refresh;
  snap install kubectl --classic;
  snap install helm --classic;
  snap install microk8s --classic;
  microk8s status --wait-ready;
  microk8s add-node --token-ttl 126144000 --token 868f88ee477f893de65c99d906e767dcaf59ce10fe30795ef9b2d11af4faefa;
  microk8s enable dns ingress prometheus storage;
  mkdir -p /home/ubuntu/.kube;
  usermod -a -G microk8s ubuntu;
  chown -f -R ubuntu /home/ubuntu/.kube;
  microk8s config > /home/ubuntu/.kube/config;
  chmod 0600 /home/ubuntu/.kube/config;
  chown -R ubuntu: /home/ubuntu/.kube/config
"

#Clone Backstage
sh -c "
  cd /tmp;
  git init backstage;
  cd backstage;
  git remote add backstage https://github.com/backstage/backstage.git;
  git fetch backstage;
  git checkout backstage/master -- contrib/chart/backstage;
  cd contrib/chart/backstage/
"

#Taking Out The Garbage
sudo sh -c "
  rm -rf /tmp/backstage/.git;
  rm -rf /tmp/backstage/contrib/chart/backstage/.cache
"

#Create Custom Configuration
export BACKSTAGE_CHART="/tmp/backstage/contrib/chart/backstage/"
echo "appConfig:
  app:
    baseUrl: https://backstage.${DOMAIN}
    title: Backstage
  backend:
    baseUrl: https://backstage.${DOMAIN}
    cors:
      origin: https://backstage.${DOMAIN}
  lighthouse:
    baseUrl: https://backstage.${DOMAIN}/lighthouse-api
  techdocs:
    storageUrl: https://backstage.${DOMAIN}/api/techdocs/static/docs
    requestUrl: https://backstage.${DOMAIN}/api/techdocs" >$BACKSTAGE_CHART/backstage-${DOMAIN}.yaml
sed -i "s/enabled: false/enabled: true/g" $BACKSTAGE_CHART/values.yaml

#Deploy Backstage
export KUBECONFIG=/home/ubuntu/.kube/config
cd $BACKSTAGE_CHART
sudo helm dependency update
helm install -f backstage-${DOMAIN}.yaml backstage .
kubectl wait deploy/backstage-frontend --namespace=default --for condition=Available=True --timeout=90s
kubectl wait deploy/backstage-backend --namespace=default --for condition=Available=True --timeout=90s
kubectl delete ingress backstage-ingress
kubectl create ingress backstage-ingress --namespace=default --class=public \
  --rule="backstage.${DOMAIN}/*=backstage-frontend:80,tls=backstage-tls" \
  --rule="backstage.${DOMAIN}/api/*=backstage-backend:80,tls=backstage-tls"
kubectl wait deploy/backstage-lighthouse --namespace=default --for condition=Available=True --timeout=90s
kubectl delete ingress backstage-ingress-lighthouse
kubectl create ingress backstage-ingress-lighthouse --namespace=default --class=public \
  --rule="backstage.${DOMAIN}/lighthouse-api(/|$)(.*)=backstage-lighthouse:80,tls=backstage-tls"

#Create Grafana And Prometheus Ingress
kubectl wait deploy/grafana --namespace=monitoring --for condition=Available=True --timeout=90s
kubectl create ingress grafana --namespace=monitoring --rule="grafana.${DOMAIN}/*=grafana:3000" --class=public
kubectl wait deploy/prometheus-operator --namespace=monitoring --for condition=Available=True --timeout=90s
kubectl create ingress prometheus --namespace=monitoring --rule="prometheus.${DOMAIN}/*=prometheus-k8s:9090" --class=public
