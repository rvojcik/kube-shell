__kcon_complete() {
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}

    COMPREPLY=($(compgen -W "$(kubectl config get-contexts -o name)" -- ${cur}))

    return 0
}
kcon() {
    if [[ "$__old_kube_context" == "" ]]; then
        export __old_kube_context="$(kubectl config current-context)"
    fi

    if [[ "$1" == "" ]]; then
        kubectl config get-contexts
    elif [[ "$1" == "--" ]] || [[ "$1" == "-" ]]; then
        actual_context="$(kubectl config current-context)"
        kubectl config use-context "$__old_kube_context"
        export __old_kube_context="$actual_context"
    else
        export __old_kube_context="$(kubectl config current-context)"
        kubectl config use-context "$1"
    fi
}
complete -F __kcon_complete kcon

__kname_complete() {
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}

    COMPREPLY=($(compgen -W "$(kubectl get namespaces -o custom-columns=':.metadata.name')" -- ${cur}))

    return 0
}
kname() {
    if [[ "$__old_kube_ns" == "" ]]; then
        export __old_kube_ns="$(kubectl config get-contexts | grep '^*' | grep -E -o '[A-Za-z0-9_-]+$')"
    fi

    if [[ "$1" == "" ]]; then
        kubectl get namespaces 
    elif [[ "$1" == "--" ]] || [[ "$1" == "-" ]]; then
        actual_ns="$(kubectl config get-contexts | grep '^*' | grep -E -o '[A-Za-z0-9_-]+$')"
        kubectl config set-context --current --namespace "$__old_kube_ns"
        export __old_kube_ns="$actual_ns"
    else
        export __old_kube_ns=$(kubectl config get-contexts | grep '^*' | grep -E -o '[A-Za-z0-9_-]+$')
        kubectl config set-context --current --namespace "$1"
    fi
}
complete -F __kname_complete kname

kfork() {
    if [[ "$1" == "del" ]] ; then
        rm -f $KUBECONFIG
        unset KUBECONFIG
    fi
    new_config=$(mktemp)
    cp -rfp ~/.kube/config $new_config
    export KUBECONFIG="$new_config"
}
