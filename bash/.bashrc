# vim: set ts=4 sw=4 sts=4 et :

###############################################################################
###                                   Vim                                   ###
###############################################################################
export EDITOR='/usr/local/bin/vim'
alias vi="$EDITOR"
alias nim='/usr/local/bin/nvim'

###############################################################################
###                                  System                                 ###
###############################################################################
# export TERM='xterm-256color'
export TERM='screen'
export HISTFILESIZE=
export HISTSIZE=
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
# If you want the last command ran immediately available to all currently open
# shells then comment the one above and uncomment the two below.
#shopt -s histappend
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
export HISTCONTROL=ignoredups
export HISTTIMEFORMAT="%a%l:%M %p  "
export HISTIGNORE='ls:bg:fg:history'

###############################################################################
###                                coreutils                                ###
###############################################################################
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:/usr/local/share/man:/usr/share/man
# Filesystem Operational Behavior
function ll { ls --color -l   "$@" | egrep -v '.(DS_Store|CFUserTextEncoding)'; }
function la { ls --color -al  "$@" | egrep -v '.(DS_Store|CFUserTextEncoding)'; }
function ld { ls --color -ld  "$@" | egrep -v '.(DS_Store|CFUserTextEncoding)'; }
function lh { ls --color -alh "$@" | egrep -v '.(DS_Store|CFUserTextEncoding)'; }
alias cp='cp -rfvp'
alias mv='mv -v'
# FIX: alias for GNU zip/unzip do not work
alias zip='/usr/local/bin/gzip'
alias unzip='/usr/local/bin/gunzip'
alias hist='history | cut -c 21-'
alias grep='grep   --color=auto' 2>/dev/null
alias egrep='egrep --color=auto' 2>/dev/null
alias fgrep='fgrep --color=auto' 2>/dev/null

###############################################################################
###                                   find                                  ###
###-------------------------------------------------------------------------###
### Easily find stuff within the root '/' filesystem (fs) without errors.
###----------------------------------------------------------------------------
# Find files somewhere on the system; to use:
#   1) call the alias, 'findsys'
#   2) pass a directory where the search should begin, and
#   3) pass a file name, either exact or fuzzy: e.g.:
# $ findsys /var/ '*.log'
function findSystemStuff()   {
    findDir="$1"
    findFSO="$2"
    sudo find "$findDir" -name 'cores' -prune , -name 'dev' -prune , -name 'net' -prune , -name "$findFSO"
}
alias findsys=findSystemStuff

###-------------------------------------------------------------------------###
### Easily find stuff within your home directory. To use:
#     1) call the alias, 'findmy'
#     2) pass a 'type' of fs object, either 'f' (file) or 'd' (directory)
#     3) pass the object name, either exact or fuzzy: e.g.:
#     $ findmy f '.vim*'
function findMyStuff()   {
    findType="$1"
    findFSO="$2"
    find "$HOME" -type "$findType" -name "$findFSO"
}
alias findmy=findMyStuff

###############################################################################
###                                VirtualBox                               ###
###############################################################################
export VBOX_USER_HOME="$HOME/vms/vbox"

###############################################################################
###                                  VMware                                 ###
###############################################################################
export VMWARE_STORAGE="$HOME/vms/vmware"

###############################################################################
###                                  Python                                 ###
###############################################################################
export PIP_CONFIG_FILE="$HOME/.config/python/pip.conf"
# Setup autoenv to your tastes
#export AUTOENV_AUTH_FILE="$HOME/.config/python/autoenv_authorized"
#export AUTOENV_ENV_FILENAME='.env'
#export AUTOENV_LOWER_FIRST=''
#source /usr/local/bin/activate.sh

###############################################################################
###                                   Ruby                                  ###
###############################################################################
#source /usr/local/opt/chruby/share/chruby/chruby.sh
#source /usr/local/opt/chruby/share/chruby/auto.sh
eval "$(rbenv init -)"

###############################################################################
###                                    Go                                   ###
###############################################################################
export GOPATH="$HOME/code/gocode"
alias mygo="cd $GOPATH"

###############################################################################
###                                  npm                                    ###
###############################################################################
source /usr/local/etc/bash_completion.d/npm

###############################################################################
###                             Remote Access                               ###
###############################################################################
# HashiCorp Atlas
export ATLAS_TOKEN=''
# Homebrew / Github
export HOMEBREW_GITHUB_API_TOKEN=''

###############################################################################
###                                 Amazon                                  ###
###############################################################################
complete -C "$(type -P aws_completer)" aws
export AWS_REGION='us-west-1'
export AWS_PROFILE='matthew'
export AWS_CONFIG_FILE="$HOME/.aws/config"

###############################################################################
###                                Terraform                                ###
###############################################################################
alias tf='/usr/local/bin/terraform'
export TF_VAR_AWS_PROFILE="$AWS_PROFILE"
export TF_LOG='DEBUG'
export TF_LOG_PATH='/tmp/terraform.log'

###############################################################################
###                                  Packer                                 ###
###############################################################################
source /usr/local/etc/bash_completion.d/packer
export PACKER_HOME="$HOME/vms/packer"
# leave PACKER_CONFIG commented till you need it
#export PACKER_CONFIG="$PACKER_HOME"
export PACKER_CACHE_DIR="$PACKER_HOME/iso-cache"
export PACKER_BUILD_DIR="$PACKER_HOME/builds"
export PACKER_LOG='yes'
export PACKER_LOG_PATH='/tmp/packer.log'
export PACKER_NO_COLOR='no'

###############################################################################
###                                 Vagrant                                 ###
###############################################################################
source /usr/local/etc/bash_completion.d/vagrant
#export VAGRANT_LOG=debug
export VAGRANT_HOME="$HOME/vms/vagrant"
export VAGRANT_BOXES="$VAGRANT_HOME/boxes"
export VAGRANT_DEFAULT_PROVIDER='virtualbox'

###############################################################################
###                                 Ansible                                 ###
###############################################################################
export ANSIBLE_CONFIG="$HOME/.ansible"


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

###############################################################################
###                                 Brew                                    ###
###############################################################################
source /usr/local/etc/bash_completion.d/brew

###############################################################################
###                                 kubectl                                 ###
###############################################################################
# shellcheck disable=SC1090
source <(kubectl completion bash)
alias k='kubectl'

###############################################################################
###                                 minikube                                ###
###############################################################################
# shellcheck disable=SC1090
source <(minikube completion bash)

###############################################################################
###                                 helm                                    ###
###############################################################################
# shellcheck disable=SC1090
source <(helm completion bash)
export HELM_HOME="$HOME/.helm"

###############################################################################
###                                 docker                                  ###
###############################################################################
eval "$(docker-machine status >/dev/null && docker-machine env default)"

source <(docker-ls autocomplete bash)


# docker
#source /usr/local/etc/bash_completion.d/docker
#source /usr/local/etc/bash_completion.d/docker-compose
#source /usr/local/etc/bash_completion.d/docker-machine.bash
#source /usr/local/etc/bash_completion.d/docker-machine-wrapper.bash

# boot2docker
# eval "$(boot2docker shellinit)"

###############################################################################
###                                 git                                     ###
###############################################################################
source /usr/local/etc/bash_completion.d/git-completion.bash

###############################################################################
###                                  mac-ops                                ###
###############################################################################
alias mac-ops='phase0'
# shellcheck disable=SC2148,SC1090,SC1091,SC2012,SC2139
#declare sysBashrc='/etc/bashrc'
#if [[ -f "$sysBashrc" ]]; then
#    . "$sysBashrc"
#fi


