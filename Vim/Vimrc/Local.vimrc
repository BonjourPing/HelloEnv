"==============================================================================
" Local configuration for various machine with various operating system
" environment.
"==============================================================================

"========= Global variables configuration =====================================
function! InitLocalConf()
endfunction

"========= Run once on startup ================================================
function! OnStartupLocal(vim_root_dir)
    let l:local_plugin_dir = a:vim_root_dir . 'Plugin/Local/'

    "Compatible with Vim-7.4
    execute 'set runtimepath+=' . l:local_plugin_dir. 'vim-fugitive-for_vim_7_4/'

endfunction

"========= Rerunable: run on startup and reconfiguration ======================
"Reconfig Vundle plugin
function! OnReloadVundlePluginLocal()

    "Better to use latest version from github for Vim-8
    "Plugin 'tpope/vim-fugitive'

endfunction

"Reconfig all other
function! OnReconfigLocal(vim_root_dir)
endfunction
