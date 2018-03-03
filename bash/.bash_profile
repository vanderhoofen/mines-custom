#!/bin/bash
# vim: set ts=4 sw=4 sts=4 et :
# URL: https://www.gnu.org/software/bash/manual/bashref.html#Bash-Startup-Files

# PATH
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
pathadd /usr/local/opt/coreutils/libexec/gnubin/
pathadd /bin after
pathadd /usr/sbin after
pathadd /sbin after
pathadd /usr/local/bin after
pathadd /usr/local/opt/tcl-tk/bin after
pathadd /usr/local/sbin after
pathadd /usr/bin after
pathadd /Applications/Wireshark.app/Contents/MacOS after
#pathadd /usr/local/share/python after
pathadd ~/bin after


### ssh-agent
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent` >/dev/null
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
shopt -s extglob
ssh-add -l >/dev/null || ssh-add ~/.ssh/id!(*.pub)


### BASH COMPLETIONS
if [[ $PS1 && -f /usr/local/share/bash-completion/bash_completion ]]; then
    . /usr/local/share/bash-completion/bash_completion
fi

### BASH
export SHELL='/usr/local/bin/bash'
export BASH_VERSION="$(bash --version | head -1 | awk -F " " '{print $4}')"
# ShellCheck: Ignore: https://goo.gl/n9W5ly
export SHELLCHECK_OPTS="-e SC2155"

### bashrc
if [ -f ~/.bashrc ] ; then
    source ~/.bashrc
fi
