#!/bin/bash
# vim: set ts=4 sw=4 sts=4 et :
# URL: https://www.gnu.org/software/bash/manual/bashref.html#Bash-Startup-Files

################################################################################
#                                 bashrc                                       #
################################################################################
if [ -f ~/.bashrc ] ; then
    source ~/.bashrc
fi

################################################################################
#                                 PATH                                         #
################################################################################
pathadd() {
    newelement=${1%/}
    if [ -d "$1" ] && ! echo "$PATH" | grep -E -q "(^|:)$newelement($|:)" ; then
        if [ "$2" = "after" ] ; then
            PATH="$PATH:$newelement"
        else
            PATH="$newelement:$PATH"
        fi
    fi
}
pathrm() {
    PATH="$(echo "$PATH" | sed -e "s;\(^\|:\)${1%/}\(:\|\$\);\1\2;g" -e 's;^:\|:$;;g' -e 's;::;:;g')"
}

# PATH
pathadd /usr/local/opt/coreutils/libexec/gnubin/
pathadd /bin after
pathadd /usr/sbin after
pathadd /sbin after
pathadd /usr/local/bin after
pathadd /usr/local/opt/tcl-tk/bin after
pathadd /usr/local/sbin after
pathadd /usr/bin after
pathadd /Applications/Wireshark.app/Contents/MacOS after
pathadd /usr/local/share/python after
pathadd ~/bin after

###############################################################################
###                                 SSH Agent                               ###
###############################################################################
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    eval "$(ssh-agent)"
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
shopt -s extglob
ssh-add -l > /dev/null || ssh-add ~/.ssh/id!(*.pub)


###############################################################################
###                                 BASH COMPLETIONS                        ###
###############################################################################
# bash
if [[ $PS1 && -f /usr/local/share/bash-completion/bash_completion ]]; then
    . /usr/local/share/bash-completion/bash_completion
fi

# brew
#source /usr/local/etc/bash_completion.d/brew

# shellcheck disable=SC1090
source <(kubectl completion bash)

# minikube
# shellcheck disable=SC1090
source <(minikube completion bash)

# helm
# shellcheck disable=SC1090
source <(helm completion bash)
export HELM_HOME="$HOME/.helm"

# docker
#source /usr/local/etc/bash_completion.d/docker
#source /usr/local/etc/bash_completion.d/docker-compose
#source /usr/local/etc/bash_completion.d/docker-machine.bash
#source /usr/local/etc/bash_completion.d/docker-machine-wrapper.bash
#eval "$(docker-machine env default)"

# git
#source /usr/local/etc/bash_completion.d/git-completion.bash

###############################################################################
###                                 Powerline                               ###
###############################################################################
if [ -f "$(which powerline-config)" ]; then
  powerline-daemon -q
  POWERLINE_ROOT=~/code/powerline
  export POWERLINE_CONFIG_COMMAND=powerline-config
  export POWERLINE_BASH_CONTINUATION=1
  export POWERLINE_BASH_SELECT=1
  . $POWERLINE_ROOT/powerline/bindings/bash/powerline.sh
fi


