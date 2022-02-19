#!/bin/bash

. /usr/local/share/demo-magic.sh
clear;echo;echo;
PROMPT_TIMEOUT=0
MSG="LET'S GET THIS DEMO STARTED..."
COW="./tux-big.cow"
pe "echo \$MSG | cowsay -f \$COW"

## create kind cluster
echo;echo
p "[.] asdf install and plugin setup"
pei "grep -i asdf ~/.bashrc"

## install plugins from global .tool-versions
pei "cd ~/"
pei "grep -v '^#' ./.tool-versions|while read -r line; do NAME=\$(echo \$line|awk '{print \$1}'); URL=\$(echo \$line|grep -o \"#https://.*$\"|sed 's/^#//g'); echo \"[*] \$NAME \$URL\"; asdf plugin add \$NAME \$URL; done"
echo;echo
pei "asdf install"

## chand back to git repo path and install versions
echo;echo
pei "cd -; echo $pwd"
pei "asdf install"

## look at some versions
echo;echo
p "[.] asdf dynamic versions"
pei "asdf list"

## show diff versions based on path
echo;echo
pei "cd -; echo $pwd"
pei "grep kubectl .tools-versions"
pei "kubectl version --short --client"
echo;echo
pei "cd -; echo $pwd"
pei "grep kubectl .tools-versions"
pei "kubectl version --short --client"

## other helpful commands
echo;echo
p "[.] asdf helpful commands"
pei "asdf current"
echo;echo
pei "asdf which kubectl"
echo;echo
pei "asdf latest kubectl"

PROMPT_TIMEOUT=0
COW="./clippy.cow"
echo;echo
MSG="COMPLETE. CAN I DEMO ANYTHING ELSE?"
pe "echo \$MSG | cowsay -f \$COW"
echo;echo

