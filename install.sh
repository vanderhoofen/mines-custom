#!/bin/bash
# requires homedir to be clean - no preexisting files


replace_as_symlink(){
  org="$1"
  config="$2"
  CHOICE="$3"
  case "$CHOICE" in 
    y|Y)  echo "Replacing as symlink $org -> $config"
          rm -rf $org
          ln -sf $config
          ;;
    n|N)  return ;;
    *)    return ;;
  esac
}


validate_or_overwrite(){
  config="$1"
  org="${1##*/}"

  if [ -L "$org" ] ; then
    replace_as_symlink $org $config $CHOICE
  elif [ -f "$org" ] ; then
    read -n1 -p "$org is a regular file. Overwrite as symlink to $config? (Y/N): " CHOICE
    echo
    replace_as_symlink $org $config $CHOICE
  elif [ -d "$org" ] ; then
    read -n1 -p "$org is a directory. Overwrite as symlink to $config? (Y/N): " CHOICE
    echo
    replace_as_symlink $org $config $CHOICE
  else
    ln -sf $config
  fi
}

echo Copying configs into ~/.config
rsync -rp .config ~/
find .config
cd ~ || exit -1

echo Symlinking BASH, VIM, TMUX
validate_or_overwrite  .config/bash/.bashrc
validate_or_overwrite  .config/bash/.bash_profile
validate_or_overwrite  .config/vim/.vimrc
validate_or_overwrite  .config/vim/.vim
validate_or_overwrite  .config/tmux/.tmux
validate_or_overwrite  .config/tmux/.tmux.conf
