#!/bin/bash

mkdir -p ~/.config
cp -r bash ~/.config

cd ~ || exit

ln -sf  .config/bash/.bashrc
ln -sf  .config/bash/.bash_profile
