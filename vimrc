" This must be first, because it changes other options as side effect
set nocompatible " be iMproved
"------------------------------------------------------------------------------
lan C

set encoding=utf-8
set fileformats=unix,dos,mac
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯХЪЖЭБЮ;ABCDEFGHIJKLMNOPQRSTUVWXYZ{}:\"<>,фисвуапршолдьтщзйкыегмцчняхъжэю;abcdefghijklmnopqrstuvwxyz[]\;'.

set autowrite
let loaded_errormaker = 1
let mapleader="," "change the mapleader from \ to ,

" Vundle config {{{
filetype off                  " Vundle required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo

" Bbye allows you to do delete buffers (close files) without closing your
" windolws or messing up your layout.
Plugin 'moll/vim-bbye'
" one stop shop for vim colorschemes.
Plugin 'flazz/vim-colorschemes'

Plugin 'wincent/command-t'
Plugin 'rkennedy/vim-delphi'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-obsession'
" Vim sugar for the UNIX shell commands that need it the most.
Plugin 'tpope/vim-eunuch'
Plugin 'thoughtbot/vim-rspec'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'
Plugin 'tmhedberg/matchit'
Plugin 'scrooloose/nerdtree'

" seamless switching between VIM windows and Tmux panes
Plugin 'christoomey/vim-tmux-navigator'

" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
" }}}

" Better copy & paste
set pastetoggle=<F2>  "toggle pasting unmodified text from system clipboard
set clipboard=unnamed "use system clipboard

set shortmess+=I "remove useless splash screen

syntax on

set omnifunc=syntaxcomplete#Complete

" use Tab key for autocompletion {{{
function! InsertTabWrapper()
    let col = col(".") - 1
    if !col || getline(".")[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-n>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-p>
"}}}

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

highlight ColorColumn ctermbg=magenta guibg=magenta
call matchadd('ColorColumn', '\%81v', 100)
" set colorcolumn=81 " highligh 80's column with ColorColumn hl-ColorColumn
" Colorscheme
set t_Co=256 " terminal colors
set t_ZH=[3m
set t_ZR=[23m

if has("gui_running")
    " GUI is running or is about to start.
    " Maximize gvim window.
    colorscheme solarized
    " set lines=50 columns=90
else
    " This is console Vim.
    "   if exists("+lines")
    "       set lines=50
    "   endif
    "   if exists("+columns")
    "       set columns=85
    "   endif
    colorscheme wombat256
endif

let g:notes_directories = ['~/Dropbox/notes']
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki'}]

"Auto closing HTML tag
:iabbrev <// </<C-X><C-O>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
set laststatus=2 "always show statusline

" functions {{{
" returns an approximate grey index for the given grey level
fun! s:grey_number(x)
    if &t_Co == 88
        if a:x < 23
            return 0
        elseif a:x < 69
            return 1
        elseif a:x < 103
            return 2
        elseif a:x < 127
            return 3
        elseif a:x < 150
            return 4
        elseif a:x < 173
            return 5
        elseif a:x < 196
            return 6
        elseif a:x < 219
            return 7
        elseif a:x < 243
            return 8
        else
            return 9
        endif
    else
        if a:x < 14
            return 0
        else
            let l:n = (a:x - 8) / 10
            let l:m = (a:x - 8) % 10
            if l:m < 5
                return l:n
            else
                return l:n + 1
            endif
        endif
    endif
endfun

" returns the actual grey level represented by the grey index
fun! s:grey_level(n)
    if &t_Co == 88
        if a:n == 0
            return 0
        elseif a:n == 1
            return 46
        elseif a:n == 2
            return 92
        elseif a:n == 3
            return 115
        elseif a:n == 4
            return 139
        elseif a:n == 5
            return 162
        elseif a:n == 6
            return 185
        elseif a:n == 7
            return 208
        elseif a:n == 8
            return 231
        else
            return 255
        endif
    else
        if a:n == 0
            return 0
        else
            return 8 + (a:n * 10)
        endif
    endif
endfun

" returns the palette index for the given grey index
fun! s:grey_color(n)
    if &t_Co == 88
        if a:n == 0
            return 16
        elseif a:n == 9
            return 79
        else
            return 79 + a:n
        endif
    else
        if a:n == 0
            return 16
        elseif a:n == 25
            return 231
        else
            return 231 + a:n
        endif
    endif
endfun

" returns an approximate color index for the given color level
fun! s:rgb_number(x)
    if &t_Co == 88
        if a:x < 69
            return 0
        elseif a:x < 172
            return 1
        elseif a:x < 230
            return 2
        else
            return 3
        endif
    else
        if a:x < 75
            return 0
        else
            let l:n = (a:x - 55) / 40
            let l:m = (a:x - 55) % 40
            if l:m < 20
                return l:n
            else
                return l:n + 1
            endif
        endif
    endif
endfun

" returns the actual color level for the given color index
fun! s:rgb_level(n)
    if &t_Co == 88
        if a:n == 0
            return 0
        elseif a:n == 1
            return 139
        elseif a:n == 2
            return 205
        else
            return 255
        endif
    else
        if a:n == 0
            return 0
        else
            return 55 + (a:n * 40)
        endif
    endif
endfun

" returns the palette index for the given R/G/B color indices
fun! s:rgb_color(x, y, z)
    if &t_Co == 88
        return 16 + (a:x * 16) + (a:y * 4) + a:z
    else
        return 16 + (a:x * 36) + (a:y * 6) + a:z
    endif
endfun

" returns the palette index to approximate the given R/G/B color levels
fun! s:color(r, g, b)
    " get the closest grey
    let l:gx = s:grey_number(a:r)
    let l:gy = s:grey_number(a:g)
    let l:gz = s:grey_number(a:b)

    " get the closest color
    let l:x = s:rgb_number(a:r)
    let l:y = s:rgb_number(a:g)
    let l:z = s:rgb_number(a:b)

    if l:gx == l:gy && l:gy == l:gz
        " there are two possibilities
        let l:dgr = s:grey_level(l:gx) - a:r
        let l:dgg = s:grey_level(l:gy) - a:g
        let l:dgb = s:grey_level(l:gz) - a:b
        let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
        let l:dr = s:rgb_level(l:gx) - a:r
        let l:dg = s:rgb_level(l:gy) - a:g
        let l:db = s:rgb_level(l:gz) - a:b
        let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
        if l:dgrey < l:drgb
            " use the grey
            return s:grey_color(l:gx)
        else
            " use the color
            return s:rgb_color(l:x, l:y, l:z)
        endif
    else
        " only one possibility
        return s:rgb_color(l:x, l:y, l:z)
    endif
endfun

" returns the palette index to approximate the 'rrggbb' hex string
fun! s:rgb(rgb)
    let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
    let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
    let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0
    return s:color(l:r, l:g, l:b)
endfun

" sets the highlighting for the given group
fun! s:X(group, fg, bg, attr)
    if a:fg != ""
        exec "hi ".a:group." guifg=#".a:fg." ctermfg=".s:rgb(a:fg)
    endif
    if a:bg != ""
        exec "hi ".a:group." guibg=#".a:bg." ctermbg=".s:rgb(a:bg)
    endif
    if a:attr != ""
        if a:attr == 'italic'
            exec "hi ".a:group." gui=".a:attr." cterm=none"
        else
            exec "hi ".a:group." gui=".a:attr." cterm=".a:attr
        endif
    endif
endfun
" }}}

call s:X("User1", "ffffff", "880c0e", "bold")
call s:X("User2", "ffdad8", "880c0e", "")
call s:X("User3", "000000", "F4905C", "")
call s:X("User4", "292b00", "e4e587", "")
call s:X("User5", "112605", "aefe7B", "")
call s:X("User6", "051d00", "7dcc7d", "")
call s:X("User7", "ffffff", "5b7fbb", "")
call s:X("User8", "ffffff", "810085", "")
call s:X("User9", "ffffff", "094afe", "")

function! HighlightSearch()
    if &hls
        return 'H'
    else
        return ''
    endif
endfunction

set statusline=
set statusline+=%{fugitive#statusline()}
set statusline+=%1*\[%n]                             "buffernr
set statusline+=%2*\ %<%F\                           "File+path
set statusline+=%3*\ %y\                             "FileType
set statusline+=%4*\ %{''.(&fenc!=''?&fenc:&enc).''} "Encoding
set statusline+=%4*\ %{(&bomb?\",BOM\":\"\")}\       "Encoding2
set statusline+=%5*\ %{&ff}\                         "FileFormat (dos/unix..) 
" Spellanguage & Highlight on?
set statusline+=%6*\ %{&spelllang}\%{HighlightSearch()}\ 
set statusline+=%7*\ %=\ %l/%L\                      "Rownumber/total (%)
set statusline+=%8*\ %03c\                           "Colnr
set statusline+=%9*\ \ %m%r%w\ %P\ \                 "Modified? Readonly? Top/bot.
"}}}

" Real programmers don't use TABs but spaces
set tabstop=4     " a tab is four spaces
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set smarttab      " insert tabs on the start of a line according to
" shiftwidth, not tabstop
set expandtab     " insert spaces instead of tabs
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set backspace=indent,eol,start " allow backspacing over everything in insert mode

" Showing line numbers and length
set number        " always show line numbers
set tw=79         " width of document (used by gd)
set nowrap        " don't wrap lines on load
set fo-=t         " don't wrap text when typing

set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
" case-sensitive otherwise
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set history=1000    " remember more commands and search history
set undolevels=1000 " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title         " change the terminal's title
"set visualbell    " don't beep
set noerrorbells  " don't beep
set go-=T " remove toolbar
set go-=m " remove menubar
set go-=r " remove right-hand scroll bar
set guifont=consolas:h14:cDEFAULT
set cpoptions+=$
" Disable backup and swap files
set nobackup
set nowritebackup
set noswapfile

set foldmethod=marker
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ :help autocmd-events
augroup vimrcEx
    " Clear all autocmds in the group
    autocmd!
    autocmd FileType text setlocal textwidth=78
    " Jump to last cursor position unless it's invalid or in an event handler
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \ exe "normal g`\"" |
                \ endif

    "for ruby, autoindent with two spaces, always expand tabs
    autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et

    " Setting global variables for Ruby {{{
    autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
    autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
    autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
    autocmd FileType ruby compiler ruby "}}}

    autocmd FileType python set sw=4 sts=4 et

    autocmd! BufRead,BufNewFile *.sass setfiletype sass

    autocmd BufRead *.mkd set ai formatoptions=tcroqn2 comments=n:&gt;
    autocmd BufRead *.markdown set ai formatoptions=tcroqn2 comments=n:&gt;

    " Indent p tags
    " autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif
    autocmd FileType html,eruby let g:html_indent_tags = '\|p\|li\|dt\|dd'

    " Don't syntax highlight markdown because it's often wrong
    autocmd! FileType mkd setlocal syn=off

    " Leave the return key alone when in command line windows, since it's used
    " to run commands there.
    autocmd! CmdwinEnter * :unmap <cr>
    autocmd! CmdwinLeave * :call MapCR()

    " Automatic reloading of .vimrc after changes
    autocmd! BufWritePost .vimrc source $MYVIMRC
    autocmd! BufWritePost _vimrc source $MYVIMRC
    autocmd! BufWritePost vimrc  source $MYVIMRC
augroup END " }}}

" make F1 key not annoying
noremap <F1> <Esc>
vnoremap <F1> <Esc>
inoremap <F1> <Esc>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make the current window big, but leave others context
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=40 "999

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nnoremap ; :
"nnoremap : ;

" Bind nohl
" Removes highlight of your last search
noremap <C-n> :nohl<CR>
" Quicksave commnd
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>
" Quick quit command
noremap <Leader>q :Bdelete<CR> " delete current buffer without window closing
noremap <Leader>Q :qa!<CR>  " Quit all windows
" bind Ctrl+<movement> keys to move aroud the windows
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-h> <C-w>h

" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" map sort function to a key
"vnoremap <Leader>s :sort<CR>

" For local replace
nnoremap gr gd[{V%:s/<C-R>///gc<left><left><left>
" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>
"nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>

map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

"open .vimrc using \v
map \v :next $MYVIMRC<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPS TO JUMP TO SPECIFIC COMMAND-T TARGETS AND FILES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://www.destroyallsoftware.com/file-navigation-in-vim.html "{{{
set wildignore+=**/tmp/**,**/log/**,*.un~
function! ShowRoutes()
    " Requires 'scratch' plugin
    :topleft 100 :split __Routes__
    " Make sure Vim doesn't write __Routes__ as a file
    :set buftype=nofile
    " Delete everything
    :normal 1GdG
    " Put routes output in buffer
    :0r! bundle exec rake -s routes
    " Size window to number of lines (1 plus rake output length)
    :exec ":normal " . line("$") . "_ "
    " Move cursor to bottom
    :normal 1GG
    " Delete empty trailing line
    :normal dd
endfunction

map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gR :call ShowRoutes()<cr>
map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
map <leader>gp :CommandTFlush<cr>\|:CommandT public<cr>
map <leader>gs :CommandTFlush<cr>\|:CommandT public/stylesheets<cr>
map <leader>gf :CommandTFlush<cr>\|:CommandT features<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>
map <leader>gt :CommandTFlush<cr>\|:CommandTTag<cr>
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
map <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>>
"}}}
