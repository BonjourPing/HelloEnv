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

    source ${bashrc_root_dir}/Local.bashrc
    return
}

#========= Run once on startup ================================================
function OnStartup() {
    local bashrc_root_dir=$1
    return
}

#========= Rerunable: run on startup and reconfiguration ======================
function OnReconfig() {
    local bashrc_root_dir=$1
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

