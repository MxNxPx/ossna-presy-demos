#!/bin/bash

. /usr/local/share/demo-magic.sh
clear;echo;echo;
PROMPT_TIMEOUT=0
MSG="LET'S GET THIS DEMO STARTED..."
COW="./nyan.cow"
pe "echo \$MSG | cowsay -f \$COW"

## install plugins from .tool-versions
echo;echo
p "[.] asdf setup"
pei "grep -v '^#' ./.tool-versions|while read -r line; do NAME=\$(echo \$line|awk '{print \$1}'); URL=\$(echo \$line|grep -o \"#https://.*$\"|sed 's/^#//g'); echo \"[*] \$NAME \$URL\"; asdf plugin add \$NAME \$URL; done"
pei "asdf install"

## configure krew
## previously ran:
## # kubectl krew list > krew-plugin-list.txt
pei "kubectl krew install < ./krew-plugin-list.txt"
pei "asdf reshim krew"
pei "grep -Eq '^export PATH=.*/.krew/bin' ~/.bashrc &>/dev/null || echo 'export PATH='\${KREW_ROOT:-\$HOME/.krew}/bin':\$PATH' >> /root/.bashrc ; . ~/.bashrc"

## create kind cluster
echo;echo
p "[.] kind"
pei "time (kind create cluster --config ./kind-config-1m2w-ingress.yaml --image kindest/node:v1.19.11 --wait 5m && kubectl wait --timeout=5m --for=condition=Ready nodes --all)"

## view cluster status
echo;echo
pei "kubectl get nodes -o wide"
echo;echo
pei "kubectl get pods -A"

echo;echo
p "[.] fun with k8s"

## deploy the innocent workload
pei "helm repo add paulczar https://tech.paulcz.net/charts"
pei "helm upgrade --install lifeform paulczar/raw -f ./kube-thanos-yaml/lifeform-deploy-helm-manifest.yaml --atomic --wait"
#pe "kubectl -n default apply -f ./kube-thanos-yaml/lifeform-deploy-spec.yaml; kubectl -n default wait deploy/life-form --for=condition=available --timeout=120s"

## verify working
echo;echo
pei "kubectl -n default get deploy,pods -o wide"

## prepare for the snap!
echo;echo

## deploy the yaml spec
pe "kubectl apply -f ./kube-thanos-yaml/kubethanos-infinitywar-spec.yaml; kubectl -n kube-system wait deploy/thanoskube --for=condition=available --timeout=120s"
clear; for i in {1..5}; do kubectl get -n default deploy; echo; kubectl -n default get pods -o wide --sort-by=.status.startTime; echo; kubectl get events --sort-by='.lastTimestamp'|grep -e 'balance' -e 'Started'|tail -8; sleep 5; clear; done

## what will happen this time?
pei "kubectl delete -f ./kube-thanos-yaml/kubethanos-infinitywar-spec.yaml"
echo;echo
pe "kubectl apply -f ./kube-thanos-yaml/kubethanos-endgame-spec.yaml"
clear; for i in {1..5}; do kubectl get -n default deploy; echo; kubectl -n default get pods -o wide --sort-by=.status.startTime; echo; kubectl get events --sort-by='.lastTimestamp'|grep -e 'balance' -e 'Started'|tail -8; sleep 5; clear; done 

PROMPT_TIMEOUT=0
echo;echo
MSG="THE WORK IS DONE."
COW="./thanos.cow"
pe "echo \$MSG | cowsay -f \$COW"

pe "kind delete cluster"
