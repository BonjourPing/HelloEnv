#==============================================================================
# Common configuration for various machine with various operating system
# environment.
#==============================================================================

#========= Global variables configuration =====================================
function InitDefaultConf() {
    #echo ${FUNCNAME}

    #Inner variable
    BASHRC_ROOT_DIR="$(cd ~; pwd)/.HelloEnv/Shell/"

    #User config
    return
}

#========= Load all functions in inner lib and user local file ================
function LoadFile() {
    local bashrc_root_dir=$1

    source ${bashrc_root_dir}/Lib.bashrc
    source ${bashrc_root_dir}/Local.bashrc
    return
}

#========= Run once on startup ================================================
function OnStartup() {
    local bashrc_root_dir=$1

    #+++++++++ appearence +++++++++
    #Command line
    export PS1=${PS1}"\$(GitBranchPrompt)\e[m\e[1;36m\e[m (\D{%Y.%m.%d} \t) "

    return
}

#========= Rerunable: run on startup and reconfiguration ======================
function OnReconfig() {
    local bashrc_root_dir=$1

    #+++++++++ appearence +++++++++
    #Command line
    #export PS1_HISTORY_0=${PS1}
    #export PS1="\u @\h:\w\$ "
    #export PS1="\n\e[1;37m[\e[m\e[1;32m\u\e[m\e[1;33m@\e[m\e[1;35m\H\e[m \e[4m`pwd`\e[m\e[1;37m]\e[m\e[1;36m\e[m\n\$"
    #export PS1="\n\e[1;37m[ \e[m\e[1;32m\u\e[m\e[1;33m@ \e[m\e[1;35m\H\e[m:\e[4m\w\e[m\e[1;37m \$(GitBranchPrompt)]\e[m\e[1;36m\e[m\n\$"
    #export PS1="\n\e[1;37m[ \e[m\e[1;32m\u\e[m\e[1;33m@ \e[m\e[1;35m\H\e[m:\e[4m\w\e[m\e[1;37m \$(GitBranchPrompt)]\e[m\e[1;36m\e[m (\D{%Y.%m.%d} \t) \n\$"

    #Cursor
    #光标和数字对照表：
    #1：闪烁块。2：块。3：闪烁下划线。4：下划线。5：闪烁竖线。6：竖线。
    #if [ "$(uname)" != "Darwin" ] #Not mac
    #then
    #    echo -ne "\e[1 q"
    #fi

    #+++++++++ alias +++++++++
    alias ll="ls -alF "
    alias grep="grep --color=auto "
    alias grepir="grep -Inr --color=auto "
    alias vimr="vi -R "
    alias vimrp="vi -R -p "
    alias vimn="vi -u NONE "
    alias tmux="tmux -2"
    alias mkcpptag="ctags --languages=c,c++ --fields=+aiKSz -R "

    return
}

#========= Main function ======================================================
InitDefaultConf
LoadFile $BASHRC_ROOT_DIR
InitLocalConf

OnStartup $BASHRC_ROOT_DIR
OnStartupLocal $BASHRC_ROOT_DIR

OnReconfig $BASHRC_ROOT_DIR
OnReconfigLocal $BASHRC_ROOT_DIR

