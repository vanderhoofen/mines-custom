#!/bin/bash
# vim: set ts=4 sw=4 sts=4 et :
# URL: https://www.gnu.org/software/bash/manual/bashref.html#Bash-Startup-Files

# PS1 reasonable default
if [[ $PS1 ]] && export PS1="\[\033[0;32m\]\h \[\033[0;33m\]\w\[\033[0;0m\] \n\[\033[0;37m\]$(date +%H:%M)\[\033[0;0m\] $ "


if_exist_alias_it(){
  alias_name="$1"
  location="$2"
  if [ -e "$location" ] ; then
      eval alias $alias_name="$location"
  fi
}

if_exist_export_it(){
  VAR="$1"
  location="$2"
  if [ -e "$location" ] ; then
      eval export $VAR="$location"
  fi
}

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
if_exist_export_it SHELL '/usr/local/bin/bash'
export BASH_VERSION="$(bash --version | head -1 | awk -F " " '{print $4}')"
# ShellCheck: Ignore: https://goo.gl/n9W5ly
export SHELLCHECK_OPTS="-e SC2155"

### bashrc
if [ -f ~/.bashrc ] ; then
    source ~/.bashrc
fi

### git
if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi
