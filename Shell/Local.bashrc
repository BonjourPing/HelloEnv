#==============================================================================
# Local configuration for various machine with various operating system
# environment.
#==============================================================================

#========= Global variables configuration =====================================
function InitLocalConf() {
    return
}

#========= Run once on startup ================================================
function OnStartupLocal() {
    local bashrc_root_dir=$1
    return
}

#========= Rerunable: run on startup and reconfiguration ======================
#Reconfig all other
function OnReconfigLocal() {
    local bashrc_root_dir=$1
    return
}
