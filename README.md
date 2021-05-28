# kube-shell

Kubernetes shell bash function to help working with kubernetes.

## Demo

![demo](./img/kube.gif "Demo Kubeshell")

## Installation

Add sourcing to your `.bash_rc` file like

```
source /path/to/kubeshell.sh
```

or directly from shell

```
bash# source ./kubeshell.sh  
```

## Usage

- `kcon`, change context, `--` or `-` for switching between last contexts
- `kname`, change namespace, `--` or `-` for switching between last namespaces
- `kubefork` or `kfork`, fork kubeconfig to separate instance, can operate on different cluster in every shell, `del` for destroying fork and returning to main kubeconfig file

