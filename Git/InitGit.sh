#!/bin/bash

#Help:
#Delete exist config:   git config --global --unset-all confignameA.confignameB
#Set new config:        git config --global config_nameA.config_nameB config_value

######### Safety #########

#Clear essential git config
git config --global --unset user.name
git config --global --unset user.email

#gi push need explicit argument
git config --global push.default=nothing

#Disable fast-forward as default
git config --global merge.ff false

######### Appearance and usage #########

#Appearance
git config --global color.ui true
git config --global log.decorate true

#Set default editor
git config --global core.editor "vim"

######### Shortcut #########

#Graph log
git config --global alias.glog "log --graph --pretty=oneline --abbrev-commit --color --decorate"
