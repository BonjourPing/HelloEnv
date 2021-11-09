"==============================================================================
" Common configuration for various machine with various operating system
" environment.
"==============================================================================

"========= Global variables configuration =====================================
function! InitDefaultConf()
    "Inner variable
    let g:vim_root_dir = '~/.HelloEnv/Vim/'

    "User config
    
endfunction

"========= Load all functions in inner lib and user local file ================
function! LoadFile(vim_root_dir)
    execute 'source ' . a:vim_root_dir . 'Vimrc/Lib.vimrc'
    execute 'source ' . a:vim_root_dir . 'Vimrc/Local.vimrc'
endfunction

"========= Run once on startup ================================================
function! OnStartup(vim_root_dir)

    "Setup for loading basic plugin
    let l:common_plugin_dir = a:vim_root_dir . 'Plugin/Common/'
    "Setup for color theme and so on, such as Molokai
    execute 'set runtimepath+=' . l:common_plugin_dir
    "Setup for Vundle, a plugin manager
    execute 'set runtimepath+=' . l:common_plugin_dir . 'Vundle.vim/'
    execute 'set runtimepath+=' . l:common_plugin_dir . 'nerdtree/'
    execute 'set runtimepath+=' . l:common_plugin_dir . 'taglist/'
    execute 'set runtimepath+=' . l:common_plugin_dir . 'supertab/'
    "Setup for simple C++ code completion
    execute 'set runtimepath+=' . l:common_plugin_dir . 'OmniCppComplete/'
    
    "Appearance
    set statusline+=\ %{&fileformat}:%{&fileencoding!=''?&fileencoding:&encoding} "左侧：显示文档编码类型
    set statusline+=%=0x%B\ %-9.(%l,%c%V%)\ %P "右侧：显示光标字符十六进制、行列号、位置
    
    "Color and theme：重复执行会导致颜色变化
    syntax on
    colorscheme molokai
    set background=dark

    "Tags - for ctags and C++ code jumping
    set tags+=tags;/ "自动向上层目录进行查找tags文件
    "set tags+=~/.code_for_use_with_ctags/tags_files/cpp_src "指向依据的C++索引文件。因为补全是依赖于ctags的

endfunction

"========= Rerunable: run on startup and reconfiguration ======================
function! OnReconfig(vim_root_file)

    "********* Setup for loading plugin managed by Vundle *********
    let l:vundle_download_dir = a:vim_root_file . 'Plugin/VundleDownload/'
    "以下为Vundle的Github官方页面内容（有更改）

    "Manual - short manual. Use ':h vundle' for more
    " 简要帮助文档
    " :PluginList       - 列出所有已配置的插件
    " :PluginInstall    - 安装插件,追加 `!` 用以更新或使用 :PluginUpdate
    " :PluginSearch foo - 搜索 foo ; 追加 `!` 清除本地缓存
    " :PluginClean      - 清除未使用插件,需要确认; 追加 `!` 自动批准移除未使用插件
    " 查阅 :h vundle 获取更多细节和wiki以及FAQ
    "
    " 以下范例用来支持不同格式的插件安装
    " 请将安装插件的命令放在vundle#begin和vundle#end之间
    "
    " Github上的插件
    " Plugin '用户名/插件仓库名'。如：
    " Plugin 'tpope/vim-fugitive'
    "
    " 来自 http://vim-scripts.org/vim/scripts.html 的插件
    " Plugin '插件名称'。实际上是 Plugin 'vim-scripts/插件仓库名' 只是此处的用户名可以省略
    " Plugin 'L9'
    "
    " 由Git支持但不在github上的插件仓库
    " Plugin 'git clone 后面的地址'。如：
    " Plugin 'git://git.wincent.com/command-t.git'
    "
    " 本地的Git仓库(例如自己的插件)
    " Plugin 'file:///+本地插件仓库绝对路径'。如：
    " Plugin 'file:///home/gmarik/path/to/plugin'
    "
    " 插件在git仓库的子目录下
    " 正确指定路径用以设置runtimepath. 以下范例插件在sparkup/vim目录下
    " Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
    "
    " 安装插件的多个实例，避免命名冲突
    " 安装L9，如果已经安装过这个插件，可利用以下格式避免命名冲突
    " Plugin 'ascenator/L9', {'name': 'newL9'}

    "Prepare - essential preparation for Vundle loading plug
    set nocompatible          "必需。去除VI一致性,必需
    filetype off              "必需
    filetype plugin indent on "必需。加载vim自带和插件相应的语法和文件类型相关脚本
    " 忽视插件改变缩进,可以使用以下替代:
    filetype plugin on "载入文件类型插件
    
    call vundle#begin(l:vundle_download_dir) "显式指定插件安装路径
    " Vundle self-management
    "Plugin 'VundleVim/Vundle.vim'
    "
    "Plugin managed by Vundle
    "Plugin 'taglist.vim'
    "Plugin 'SirVer/ultisnips' "需要Python或者Python3支持
    "Plugin 'honza/vim-snippets'
    "Plugin 'fatih/vim-go'
    "Plugin 'dgryski/vim-godef'
    "Plugin 'tpope/vim-fugitive'
    call OnReloadVundlePluginLocal()
    call vundle#end()            " 必需

    "********* Setup of common plugin *********
    "=========NERDTree=========
    "autocmd VimEnter * NERDTree "打开vim时自动启动
    "autocmd VimEnter * wincmd p "Move cursor to the top of window when open
    "Likes Win+e to open MyComputer in Windows OS, but conflict with default
    "nnoremap <C-e> <Esc>:NERDTreeToggle<cr>
    nnoremap <F1> <Esc>:NERDTreeToggle<cr>

    "========= taglist =========
    "Open and close
    map <F2> <Esc>:Tlist<Cr>
    let Tlist_Auto_Open = 0 "打开vim时是否自动启动
    let Tlist_Close_On_Select = 0 "是否在选择tag后就关闭窗口
    let Tlist_Exit_OnlyWindow = 1
    "Appearance
    let Tlist_Use_Horiz_Window = 0 "是否水平窗口
    let Tlist_Use_Right_Window = 0 "是否右侧显示
    let Tlist_WinWidth = 40 "窗口大小
    let Tlist_Show_One_File = 1 "多文件时是否显示多个文件的list
    let Tlist_File_Fold_Auto_Close = 0 "显示多文件list情况下，是否自动折叠其他文件的list
    "按照在文件中顺序/order或名字/name对list内容，默认order。s键可在运行时切换排序模式，
    let Tlist_Sort_Type = "name"
    let Tlist_Display_Prototype = 0 "是否显示原型
    let Tlist_Display_Tag_Scope = 1 "是否显示作用域
    let Tlist_Highlight_Tag_On_BufEnter = 1
    let Tlist_Use_SingleClick = 1 "Support mouse

    "=========SuperTab设置=========
    "SuperTab是用于补全已经输入过的内容。意外的是其和OmniComplete是兼容的能够让tab键显示补全和选择
    "表示使用Vim中默认的补全，用这个才能补全输入过的。此时为tab键会被映射为Vim默认的补全键<c-p>
    let g:SuperTabDefaultCompletionType="context" 
    "let g:SuperTabDefaultCompletionType="<c-x><c-o>" "补全映射成这两个键，即用OmniComplete的补全
    let g:SuperTabRetainCompletionType=2
    "    0 不记录上次的补全方式
    "    1 记住上次的补全方式,直到用其他的补全命令改变它
    "    2 记住上次的补全方式,直到按ESC退出插入模式为止

    "=========OmniComplete C++的自动补全=========
    "基础设置
    "set omnifunc=ccomplete#Complete "C的补全
    "set omnifunc=syntaxcomplete#Complete "不知道什么补全
    "针对不同文件设置不同补全
    "omnifunc函数是必须要设置的，此处用autocmd主要原因是直接用set无法生效，仍然是默认的ccomplete。不知道什么原因，待解决
    autocmd BufNewFile,BufRead,BufEnter *.h,*.hpp,*.cpp,*.cc set omnifunc=omni#cpp#complete#Main "C++的补全
    "环境设置
    let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
    let OmniCpp_NamespaceSearch = 1
    let OmniCpp_GlobalScopeSearch = 1
    let OmniCpp_ShowAccess = 1
    let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表
    let OmniCpp_MayCompleteDot = 1   " 输入 .  后自动补全
    let OmniCpp_MayCompleteArrow = 1 " 输入 -> 后自动补全
    let OmniCpp_MayCompleteScope = 1 " 输入 :: 后自动补全
    "自动关闭补全窗口
    autocmd CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

    "Appearance
    "该两项在molokai风格下无效
    "highlight Pmenu    guibg=darkgrey  guifg=black "Pmenu表示所有项配色，guibg和guifg分别为背景和前景色
    "highlight PmenuSel guibg=lightgrey guifg=black "PmenuSel表示选中项配色

    "快捷键设置
    "ctrl+k和j分别用于移动光标选择候选补全
    inoremap <c-k> <C-Up>
    inoremap <c-j> <C-Down>
    "inoremap <expr> <CR>       pumvisible()?"\<C-Y>":"\<CR>"
    "inoremap <expr> <C-J>      pumvisible()?"\<PageDown>\<C-N>\<C-P>":"\<C-X><C-O>"
    "inoremap <expr> <C-K>      pumvisible()?"\<PageUp>\<C-P>\<C-N>":"\<C-K>"
    "inoremap <expr> <C-U>      pumvisible()?"\<C-E>":"\<C-U>" 

    "=========UltiSnips代码片段=========
    let g:UltiSnipsExpandTrigger="<tab>"
    " 使用 tab 切换下一个触发点，shit+tab 上一个触发点
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
    " 使用 UltiSnipsEdit 命令时垂直分割屏幕
    let g:UltiSnipsEditSplit="vertical"

    "********* Setup of Vundle plugin *********
    "Empty

    "********* Setup that can be reconfig *********
    "set nocp
    "filetype plugin on
    
    "=========外观配置=========
    "+++++++++颜色配置+++++++++
    "Essential for color:
    "Empty
    "Not essential for color
    "syntax on
    "color molokai
    set t_Co=256
    let g:molokai_original = 1
    let g:rehash256 = 1
    "++++++cursor setting++++++
    "注意：该部分设置用于解决Windows的Linux子系统下Windows Terminal的光标显示问题,其他系统请忽略
    "光标和数字对照表：
    "1：闪烁块。2：块。3：闪烁下划线。4：下划线。5：闪烁竖线。6：竖线。
    let &t_SI.="\e[5 q" "进入插入模式
    "let &t_SR.="\e[3 q" "进入替换模式
    let &t_EI.="\e[1 q" "从插入或替换模式退出，进入普通模式
    "打开vim时，普通模式光标
    autocmd VimEnter * silent !echo -ne "\e[1 q" 
    "离开vim后，恢复shell模式的光标
    autocmd VimLeave * silent !echo -ne "\e[1 q"
    
    "+++++++++ 主区域设置 +++++++++
    set nu "显示行号
    set wrap "一行显示不下后折叠到下一行显示
    set scrolloff=7 "设置上下预留行数，使得光标保持在中央附近
    set ruler "右下角显示光标行列位置，在设置statusline后会失效
    "辅助线
    set cursorcolumn "Column line
    set cursorline "Row line
    set colorcolumn=80

    "+++++++++ tab和标签栏设置 +++++++++
    set tabline=%!MyTabLineNumber() "设置tab标题前显示tab序号。默认显示页面的分屏数
    set tabpagemax=1024
    set showtabline=2 "0不显示，1仅在有tab时显示，2永远显示

    "+++++++++ 底边状态栏statusline设置 +++++++++
    set laststatus=2 "永久显示statusline
    "从左边开始显示文件路径、是否修改标记、只读标记、文件类型
    "从右边依次显示行号、列号、光标所在字符值
    set statusline=%<%(%F%m\ %r\ %Y%)%=%(%l-%c\ %o-%p%%\ 0x%B%)

    "=========浏览设置=========
    set mouse=a "支持鼠标光标定位，滚轮上下滚动
    set hlsearch "高亮显示搜索结果
    set ignorecase "搜索时不区分大小写。注意此处会影响到%s的匹配和替换
    set smartcase "当出现大写字母时则完全匹配。如果只有ignorecase则大侠时也能匹配小写。

    "+++++++++ ctags配置+++++++++
    "set tagcase=match "设置tselect 大小写敏感
    "nnoremap <C-[> :tabnew %<CR>g<C-]> "不是很好用，可以直接用tabnew来挺好的
    "vnoremap <C-[> <Esc>:tabnew %<CR>gvg<C-]> "不是很好用，可以直接用tabnew来挺好的
    "nnoremap <silent><C-j><C-]>    <Esc><C-w><C-]><C-w>T<Esc>
    ""XXX:当有多个标签需要选择时无法工作
    
    "=========编辑设置=========
    "缩进和tab
    set tabstop=4
    set expandtab
    set softtabstop=4
    set shiftwidth=4
    "自动缩进
    set autoindent
    set cindent
    set smartindent
    set cino=N-s;g0 "cinoptions。禁止namespace缩进及public等不缩进
    "补全设置
    set wildmode=list:longest:full
    "设置命令行补全为最长然后显示菜单。（默认是随便选一个再滚动，很难用）
    set completeopt=menuone,menu,longest,preview
    "其他
    set backspace=indent,eol,start "解决Backspace键失灵问题
    set shell=bash\ --login
    
    "========= 个性化设置 =========
    "+++++++++ 跳转 +++++++++
    "分屏跳转
    "<silent>表示不在命令行显示该命令
    nnoremap <silent><C-h> <C-w>h
    nnoremap <silent><C-j> <C-w>j
    nnoremap <silent><C-k> <C-w>k
    nnoremap <silent><C-l> <C-w>l
    
    "光标移动
    nnoremap J jjjjj
    nnoremap K kkkkk
    vnoremap J jjjjj
    vnoremap K kkkkk
    "nnoremap J gjgjgjgjgj
    "nnoremap K gkgkgkgkgk
    "vnoremap J gjgjgjgjgj
    "vnoremap K gkgkgkgkgk
    
    "文件跳转
    "Manual - default
    "gf "Open head file in current tab
    "<C-w>gf "Open head file in new tab
    "e %:r.cpp "Open path/filename.cpp of path/filename.h
    "e %<.cpp "Open path/filename.cpp of path/filename.h
    cnoreabbrev jeh         "<Esc>:e %:r.h<Cr>"
    cnoreabbrev jecc        "<Esc>:e %:r.cc<Cr>"
    cnoreabbrev jecpp       "<Esc>:e %:r.cpp<Cr>"

    "查找
    "显示当前查找结果的数量
    nnoremap <C-j>sn <Esc>:%s///gn<Cr><Esc>

    "+++++++++ 编辑 +++++++++
    "因为<C-j>也被用于自定义快捷键的前缀，为便于使用在该处增加分屏跳转快捷键
    nnoremap <silent><C-j><C-j> <C-w>j

    "文件保存和设置保存点（删除undo历史）
    "Drop undo history at a save point.
    "nmap <F8>       <Esc>:w<Cr><Esc>:set ul=-1<Cr><Esc>:e!<Cr><Esc>:set ul=1024<Cr><Esc>
    "nmap <F8><F8>   <Esc>:w!<Cr><Esc>:set ul=-1<Cr><Esc>:e!<Cr><Esc>:set ul=1024<Cr><Esc>
    cnoreabbrev jw       <Esc>:w!<Cr><Esc>
    cnoreabbrev jr       <Esc>:w!<Cr><Esc>:set ul=-1<Cr><Esc>:e!<Cr><Esc>:set ul=1024<Cr><Esc>
    
    "注释和解除注释代码
    nnoremap <C-j>/         <Esc>0i//<Esc>
    nnoremap <C-j>//        <Esc>0xx<Esc>
    nnoremap <C-j>#         <Esc>0i#<Esc>
    nnoremap <C-j>##        <Esc>0x<Cr><Esc>
    "visual mode
    vnoremap <C-j>/         0I//<Esc>
    vnoremap <C-j>//        :normal xx<Cr><Esc>
    vnoremap <C-j>#         0I#<Esc>
    vnoremap <C-j>##        :normal x<Cr><Esc>


    "========= Language specific setup =========

    "+++++++++ C++语言相关设置+++++++++
    "funcname name color
    "匹配函数名
    autocmd BufNewFile,BufRead *.h,*.hpp,*.cpp,*.cc,*.c :syntax match cppfunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
    autocmd BufNewFile,BufRead *.h,*.hpp,*.cpp,*.cc,*.c :syntax match cppfunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
    "set function name color: 118 Green
    highlight cppfunctions ctermfg=118

    "C++尾的反斜杠的添加和删除
    "添加
    "insert模式下为cpp宏在第80列添加反斜杠
    inoremap <C-j>\ <C-r>=repeat(' ', 80-virtcol('.'))<Cr>\<Esc>
    "另一种方法：
    "1.set virtualedit=all
    "2.跳转到第80列： <Esc>080l 或 <Esc>80|
    "3.替换为\： r\<Esc>
    nmap <C-j>\ <Esc>A<C-j>\<Esc>
    
    "删除末尾的\及空格
    "如下方案不好，导致搜索结果变化
    "nnoremap <C-j>\\ <Esc>:.,.s/ \+\\$//g<Esc> 
    "如下方案需要vim添加MzScheme选项/功能编译
    "Delete tail like ____\ and ____ ( _ means white space)
    function! DeleteCppMarcoTail()
      exe "normal mz"
      .,.s/\s*\\\?$//ge
      exe "normal `z"
    endfunc
    nnoremap <C-j>\\ <Esc>:call DeleteCppMarcoTail()<CR><Esc>$<Esc>
    
    "+++++++++符号补全（不好用）++++++++
    "inoremap '              ''<ESC>i
    "inoremap "              ""<ESC>i
    "inoremap (              ()<ESC>i
    "inoremap ()             ()<ESC>a
    "inoremap [              []<ESC>i
    "inoremap []             []<ESC>a
    "inoremap {              {}<ESC>i
    "inoremap {}             {}<ESC>a


    "========= Others and temp =========
    "let g:go_doc_keywordprg_enabled = 0

    "========= Load workspace specific setup =========
    "加载项目特定的vimrc文件
    call LoadWorkspaceVimrc()

endfunction



"========= Main function ======================================================
call InitDefaultConf()
call LoadFile(g:vim_root_dir)
call InitLocalConf()

call OnStartup(g:vim_root_dir)
call OnStartupLocal(g:vim_root_dir)

call OnReconfig(g:vim_root_dir)
call OnReconfigLocal(g:vim_root_dir)

