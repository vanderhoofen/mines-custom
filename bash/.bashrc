# vim: set ts=4 sw=4 sts=4 et :

### vim
export EDITOR='/usr/local/bin/vim'
alias vi="$EDITOR"
alias nim='/usr/local/bin/nvim'

### System
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

### coreutils
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:/usr/local/share/man:/usr/share/man
# Filesystem Operational Behavior
function ll { ls -l   "$@" | egrep -v '.(DS_Store|CFUserTextEncoding)'; }
function la { ls -al  "$@" | egrep -v '.(DS_Store|CFUserTextEncoding)'; }
function ld { ls -ld  "$@" | egrep -v '.(DS_Store|CFUserTextEncoding)'; }
function lh { ls -alh "$@" | egrep -v '.(DS_Store|CFUserTextEncoding)'; }
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


### homebrew completions
if [[ $PS1 ]] ; then
	if [ -f /usr/local/Homebrew/completions/bash/brew ] ; then
		source /usr/local/Homebrew/completions/bash/brew
	fi
fi

### VirtualBox
export VBOX_USER_HOME="$HOME/vms/vbox"

### VMware
export VMWARE_STORAGE="$HOME/vms/vmware"

### Python
export PIP_CONFIG_FILE="$HOME/.config/python/pip.conf"
# Setup autoenv to your tastes
#export AUTOENV_AUTH_FILE="$HOME/.config/python/autoenv_authorized"
#export AUTOENV_ENV_FILENAME='.env'
#export AUTOENV_LOWER_FIRST=''
#source /usr/local/bin/activate.sh

### Ruby
[[ $PS1 ]] && which rbenv >&- && eval "$(rbenv init -)"

### GO
export GOPATH=$HOME/code/go
[[ $PS1 ]] && which go >&- && pathadd $GOPATH/bin after

### Remote Access
# HashiCorp Atlas
export ATLAS_TOKEN=''
# Homebrew / Github
export HOMEBREW_GITHUB_API_TOKEN=''

### Amazon
complete -C "$(type -P aws_completer)" aws
export AWS_REGION=${AWS_REGION:-us-east-1}
export AWS_PROFILE=${AWS_PROFILE:-$USER}
export AWS_CONFIG_FILE="$HOME/.aws/config"

### Terraform
alias tf='/usr/local/bin/terraform'
export TF_VAR_AWS_PROFILE="$AWS_PROFILE"
export TF_LOG='DEBUG'
export TF_LOG_PATH='/tmp/terraform.log'

### Packer
export PACKER_HOME="$HOME/vms/packer"
# leave PACKER_CONFIG commented till you need it
#export PACKER_CONFIG="$PACKER_HOME"
export PACKER_CACHE_DIR="$PACKER_HOME/iso-cache"
export PACKER_BUILD_DIR="$PACKER_HOME/builds"
export PACKER_LOG='yes'
export PACKER_LOG_PATH='/tmp/packer.log'
export PACKER_NO_COLOR='no'

### Vagrant
#export VAGRANT_LOG=debug
export VAGRANT_HOME="$HOME/vms/vagrant"
export VAGRANT_BOXES="$VAGRANT_HOME/boxes"
export VAGRANT_DEFAULT_PROVIDER='virtualbox'

### Ansible
export ANSIBLE_CONFIG="$HOME/.ansible"

### Powerline
[[ $PS1 ]] && if which powerline-config >&- ; then
  powerline-daemon -q
  POWERLINE_ROOT=~/code/powerline
  export POWERLINE_CONFIG_COMMAND=powerline-config
  export POWERLINE_BASH_CONTINUATION=1
  export POWERLINE_BASH_SELECT=1
  . $POWERLINE_ROOT/powerline/bindings/bash/powerline.sh
fi

### kubectl
# shellcheck disable=SC1090
[[ $PS1 ]] && which kubectl >&- && source <(kubectl completion bash)
alias k='kubectl'
#export KUBECONFIG=~/.config/kubernetes/admin.conf

### minikube ###
# shellcheck disable=SC1090
[[ $PS1 ]] && which minikube >&- && source <(minikube completion bash)

### helm
# shellcheck disable=SC1090
[[ $PS1 ]] && which helm >&- && source <(helm completion bash)
export HELM_HOME="$HOME/.helm"


