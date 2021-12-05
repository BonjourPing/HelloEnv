#!/bin/bash

#Clear essential git config
git config --global --unset user.name
git config --global --unset user.email

#Set default editor
git config --global core.editor "vim"
