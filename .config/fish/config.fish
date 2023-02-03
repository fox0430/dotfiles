set PATH /home/fox/.nimble/bin $PATH
set PATH /home/fox/.cargo/bin $PATH

#export TERM=rxvt-unicode-256color
export TERM=xterm-256color

#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Djxbrowser.ipc.external=true'

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
eval (ssh-agent -c)

fish_vi_key_bindings

alias vi "nvim"

alias x "startx"

alias py "python"

alias DL "cd & cd ~/Downloads"
alias rm "rm -v -i -r"
alias cp "cp -v -i -r"
alias mv "mv -v -i"

alias DC "/bin/bash ~/.config/fish/dysplayChange.sh"

alias nmgui "/bin/bash ~/.config/fish/nmgui.sh"

alias stopdocker "/bin/bash ~/.config/fish/allStopDocker.sh"

alias k "kubectl"
alias kns "kubens"
alias kctx "kubectx"
alias kg "kubectl get"
alias regcred "kubectl create secret generic regcred \
    --from-file=.dockerconfigjson=$HOME/.docker/config.json \
    --type=kubernetes.io/dockerconfigjson"

function cd
    # Avoid set completions.
    set -l previous $PWD

    if test "$argv" = "-"
        if test "$__fish_cd_direction" = "next"
            nextd
        else
            prevd
        end
        return $status
    end
    builtin cd $argv
    set -l cd_status $status
    # Log history
    if test $cd_status -eq 0 -a "$PWD" != "$previous"
        set -q dirprev[$MAX_DIR_HIST]
        and set -e dirprev[1]
        set -g dirprev $dirprev $previous
        set -e dirnext
        set -g __fish_cd_direction prev
    end

    if test $cd_status -ne 0
        return 1
    end
    ls
    return $status
end

function merge_kubeconfig
  set path "$argv"
  set path_len (string length $path)

  if test $path_len -gt 0
    KUBECONFIG=$HOME/.kube/config:$path kubectl config view --flatten > /tmp/config && mv /tmp/config ~/.kube/config
    echo $HOME/.kube/config
  else
    echo "Erro: Please set a New kubeconfig path"
  end

end
