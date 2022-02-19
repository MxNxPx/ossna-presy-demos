#!/bin/bash

. /usr/local/share/demo-magic.sh
clear;echo;echo;
PROMPT_TIMEOUT=0
MSG="LET'S GET THIS DEMO STARTED..."
COW="/usr/share/cowsay/cows/default.cow"
pe "echo \$MSG | cowsay -f \$COW"

## create kind cluster
echo;echo
p "[.] asdf install"
pei "grep -i asdf ~/.bashrc"

## install plugins from global .tool-versions
pei "cd ~/"
pei "grep -v '^#' ./.tool-versions|while read -r line; do NAME=\$(echo \$line|awk '{print \$1}'); URL=\$(echo \$line|grep -o \"#https://.*$\"|sed 's/^#//g'); echo \"[*] \$NAME \$URL\"; asdf plugin add \$NAME \$URL; done"
pei "asdf install"

## chand back to git repo path and install versions
pei "cd -; echo $pwd"
pei "asdf install"

## show diff versions based on path
pei "cd -; echo $pwd"
pei "kubectl version --short --client"
pei "cd -; echo $pwd"
pei "kubectl version --short --client"

## configure krew
## previously ran:
## # kubectl krew list > krew-plugin-list.txt
pei "kubectl krew install < ./krew-plugin-list.txt"
pei "asdf reshim krew"
pei "echo \"export PATH=\"\${KREW_ROOT:-\$HOME/.krew}/bin:\$PATH\"\" >> /root/.bashrc"

## look at some versions

PROMPT_TIMEOUT=0
echo;echo
MSG="DEMO COMPLETE."
pe "echo \$MSG | cowsay -f \$COW";echo;echo

