# multipass-demo
demo uses [multipass](https://github.com/canonical/multipass), [kind](https://github.com/kubernetes-sigs/kind), [asdf](https://github.com/asdf-vm/asdf), [demo magic](https://github.com/paxtonhare/demo-magic), [kubethanos](https://github.com/berkay-dincer/kubethanos)

## Demo steps
```
#launch multipass
bash multipass-setup.sh
#shell in
multipass shell multipass-demo
#switch users
su -
#change directories to mount and run demo(s)
cd ~/multipass-demo/asdf-demo
bash demo.sh 
cd ~/multipass-demo/k8s-demo
bash demo.sh 
```

## Recorded Demo
![kubethanos in action](./kind-kubethanos-demo.gif)


## Acknowledgements

* I built an implementation off of the original project here: https://github.com/berkay-dincer/kubethanos


## Disclaimer

* You are responsible for your actions. If you break things in production while using this software I cannot help you to restore the damage caused.  

