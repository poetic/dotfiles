"Jake Craige & Matthew Hager

" Setup {{{
    set rtp+=~/.poetic_dotfiles/powerline/powerline/bindings/vim/
    if filereadable(expand("~/.vimrc.bundles"))
      source ~/.vimrc.bundles
    endif

    filetype plugin indent on
" }}}
" Language Specific {{{
    " keep you honest and without tabs
    autocmd BufWritePre * :retab
    " Javascript {{{
        autocmd BufReadPre *.coffee let b:javascript_lib_use_angularjs = 1

        augroup ft_javascript
          au!
          au Filetype javascript setlocal foldmethod=syntax
        augroup END
        " Compile coffee files automatically on sav - add | redraw! for terminal
          "au BufWritePost *.coffee silent make!
    " }}}
    " Rails {{{
        map <Leader>rm :Rmodel<cr>
        map <Leader>rc :Rcontroller<cr>
        map <Leader>rv :Rview<cr>
    " }}}
    " Ruby {{{
        augroup ft_ruby
          au!
          au Filetype ruby setlocal foldmethod=syntax
        augroup END
    " }}}
    " Vim {{{

    augroup ft_vim
        au!

        au FileType vim setlocal foldmethod=marker
        au FileType help setlocal textwidth=78
        au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
    augroup END

    " }}}
" }}}
" General make life easy settings {{{
      let mapleader = ","
      "set clipboard=unnamed      " Makes tmux c/p work
      set noesckeys
      set mouse=a
      set mousehide
      set nocompatible
      set autoindent
      set modelines=0
      set scrolljump=5
      set scrolloff=3
      set showmode
      set showcmd
      set hidden
      set wildmode=list:longest
      set visualbell
      set cursorline
      set cursorcolumn
      set ttyfast               " fast scrolling...
      set list
      set relativenumber
      set foldenable             " enable code folding
      set virtualedit=onemore    " Allow cursor beyondlast character
      set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
      set colorcolumn=+1
      set linebreak
      set title
      set shiftround
      set splitbelow
      set splitright
      set undofile
      set undoreload=10000
      set history=1000
      set laststatus=2
      set matchtime=3

      command! Q q " Bind :Q to :q
      command! Qall qall

    " Disable Ex mode
      map Q <nop>


" }}}
" Make Life Easy Bindings {{{

      " S in normal mode to split line, sister to J
      nnoremap S i<cr><esc><right>

      " Post to gist and copy in clipboard
      vnoremap <leader>G :w !gist -p -t %:e \| pbcopy<cr>

      "For when you forget to sudo.. Really Write the file.
        cmap w!! w !sudo tee % >/dev/null

      "Adjust viewports to the same size
        map <Leader>= <C-w>=

      "Rehighlight pasted text
        nnoremap <leader>v V`]

      "Save a keystroke
        nnoremap ; :

      "Bind jj to ESC for quicker switching modes
        inoremap jj <ESC>

      " 0 now goes to first char in line instead of blank"
        nnoremap 0 0^

" }}}
" Folding {{{

    " Space to toggle folds.
    nnoremap <Space> za
    vnoremap <Space> za

    " Make zO recursively open whatever top level fold we're in, no matter where the
    " cursor happens to be.
    nnoremap zO zCzO

    function! MyFoldText() " {{{
        let line = getline(v:foldstart)

        let nucolwidth = &fdc + &number * &numberwidth
        let windowwidth = winwidth(0) - nucolwidth - 3
        let foldedlinecount = v:foldend - v:foldstart

        " expand tabs into spaces
        let onetab = strpart('          ', 0, &tabstop)
        let line = substitute(line, '\t', onetab, 'g')

        let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
        let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
        return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
    endfunction " }}}
    set foldtext=MyFoldText()

" }}}
" Colorscheme, Gui, Font  {{{

    "Status line with fugitive git integration
    set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

    if has('gui_running')
      colorscheme cobalt
      " removes scrollbar and toolbar"
      set guioptions+=lrb
      set guioptions-=lrb           " Remove the toolbar
      set guioptions-=T
      set lines=40                " 40 lines of text instead of 24
    else
      set t_Co=256
      set term=screen-256color
      set background=dark
      colorscheme railscasts
    endif

    " Font , Text, Tabs {{{

        " Auto format comment blocks
        set comments=sl:/*,mb:*,elx:*/

        set guifont=Inconsolata\ 13
        "Set tabs to 2 spaces instead of the default 4
          set tabstop=2
          set shiftwidth=2
          set softtabstop=2
          set expandtab
        "Text wrapping
          set wrap
          set textwidth=80
          set formatoptions=qrn1
          set colorcolumn=+1

    " }}}

" }}}
" Quick Edit Common Files{{{

    nnoremap <leader>ev <C-w><C-v><C-l>:e ~/.vimrc.local<cr>
    nnoremap <leader>ez <C-w><C-v><C-l>:e ~/.zshrc.local<cr>

"}}}
" File Editing {{{

  " Edit another file in the same directory as the current file
  " uses expression to extract path from current file's path
    map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
    map <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
    map <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>
    map <leader><tab> :Scratch<CR>

  " RENAME CURRENT FILE (thanks Gary Bernhardt) {{{
  function! RenameFile()
      let old_name = expand('%')
      let new_name = input('New file name: ', expand('%'), 'file')
      if new_name != '' && new_name != old_name
          exec ':saveas ' . new_name
          exec ':silent !rm ' . old_name
          redraw!
      endif
  endfunction
  map <Leader>n :call RenameFile()<cr>
  " }}}
  
" Line Return On File Open{{{

" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Amit
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" }}}
" }}}
" Navigation {{{

  " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h

  "Visual shifting (does not exit Visual mode on tab)
    vnoremap < <gv
    vnoremap > >gv

  "Movement - better Navigation
    nnoremap j gj
    nnoremap k gk
    nnoremap k gk

  "Split Window Navigation mapping
    nnoremap <leader>w <C-w>v<C-w>l
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    "Split window size mapping
    nnoremap <S-Up> :resize +5<CR>
    nnoremap <S-Down> :resize -5<CR>
    nnoremap <S-Right> :vertical resize -5<CR>
    nnoremap <S-Left> :vertical resize +5<CR>

    " This if is to make these bindings work inside tmux
    if &term =~ '^screen'
        " tmux will send xterm-style keys when its xterm-keys option is on
        execute "set <xUp>=\e[1;*A"
        execute "set <xDown>=\e[1;*B"
        execute "set <xRight>=\e[1;*C"
        execute "set <xLeft>=\e[1;*D"
    endif

" }}}
" Searching {{{

      "Fix broken searching by enabling regular regex I think?
      nnoremap / /\v
      vnoremap / /\v
      set ignorecase
      set smartcase
      set gdefault " assume the /g flag on :s substitutions to replace all matches in a line
      set hlsearch

      " highlighted in visual mode, any in normal
      nnoremap <leader>s :%s//gc<left><left><left>
      nnoremap <leader>sa :%s//g<left><left>
      vnoremap <leader>s "hy:%s/<C-r>h//gc<left><left><left>
      vnoremap <leader>sa "hy:%s/<C-r>h//g<left><left>

      "Undo highlignted searches
      nnoremap <leader><space> :noh<cr>

      " Keep search matches in the middle of the window.
      nnoremap n nzzzv
      nnoremap N Nzzzv

      " Same when jumping around
      nnoremap g; g;zz
      nnoremap g, g,zz
      nnoremap <c-o> <c-o>zz

      " Don't move on *
      nnoremap * *<c-o>

      " Visual Mode */# from Scrooloose {{{
      " Lets you use * in visual mode

      function! s:VSetSearch()
        let temp = @@
        norm! gvy
        let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
        let @@ = temp
      endfunction

      vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
      vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>

      " }}}
" }}}
" Git Setup {{{

    map <Leader>gac :Gcommit -m -a ""<LEFT>
    map <Leader>gc :Gcommit -m ""<LEFT>
    map <Leader>gs :Gstatus<CR>
    map <Leader>gw :!git add . && git commit -m 'WIP' && git push<cr>

" }}}
" duplicate selected content {{{

  map <Leader>d y'>p

" }}}
" Backups {{{

  set backup                        " enable backups
  set noswapfile                    " it's 2013, Vim.

  set undodir=~/.vim/tmp/undo//     " undo files
  set backupdir=~/.vim/tmp/backup// " backups
  set directory=~/.vim/tmp/swap//   " swap files

  " Make those folders automatically if they don't already exist.
  if !isdirectory(expand(&undodir))
      call mkdir(expand(&undodir), "p")
  endif
  if !isdirectory(expand(&backupdir))
      call mkdir(expand(&backupdir), "p")
  endif
  if !isdirectory(expand(&directory))
      call mkdir(expand(&directory), "p")
  endif

" }}}
" Plugins {{{

    " NERDTree {{{
        map <C-e> :NERDTreeToggle<CR>
        let NERDTreeHighlightCursorline = 1
        let NERDTreeIgnore = ['.vim$', '\~$', '.*\.pyc$', 'pip-log\.txt$', 'whoosh_index',
                            \ 'xapian_index', '.*.pid', 'monitor.py', '.*-fixtures-.*.json',
                            \ '.*\.o$', 'db.db', 'tags.bak', '.*\.pdf$', '.*\.mid$',
                            \ '.*\.midi$']

        let NERDTreeMinimalUI = 1
        let NERDTreeDirArrows = 1
        let NERDChristmasTree = 1
        let NERDTreeChDirMode = 2
        let NERDTreeMapJumpFirstChild = 'gK'
    " }}}
    " Sparkup {{{
    
      let g:sparkupExecuteMapping = '<leader>h'
      
    " }}}
    " Tabular {{{
      nmap <Leader>a= :Tabularize /=<CR>
      vmap <Leader>a= :Tabularize /=<CR>
      nmap <Leader>a: :Tabularize /:\zs<CR>
      vmap <Leader>a: :Tabularize /:\zs<CR>
      nmap <Leader>a> :Tabularize /=><CR>
      vmap <Leader>a> :Tabularize /=><CR>
      nmap <Leader>a\ :Tabularize /\|<CR>
      vmap <Leader>a\ :Tabularize /\|<CR>
    " }}}
    " TagBar {{{
        nmap <leader>tt :TagbarToggle<CR>
        let g:tagbar_ctags_bin = '/opt/boxen/homebrew/bin/ctags'
        let g:tagbar_type_markdown = {
          \ 'ctagstype' : 'markdown',
          \ 'kinds' : [
            \ 'h:Heading_L1',
            \ 'i:Heading_L2',
            \ 'k:Heading_L3'
          \ ]
        \ }

        let g:tagbar_type_puppet = {
            \ 'ctagstype': 'puppet',
            \ 'kinds': [
                \'c:class',
                \'s:site',
                \'n:node',
                \'d:definition'
              \]
            \}

        let g:tagbar_type_ruby = {
            \ 'kinds' : [
                \ 'm:modules',
                \ 'c:classes',
                \ 'd:describes',
                \ 'C:contexts',
                \ 'f:methods',
                \ 'F:singleton methods'
            \ ]
        \ }

        let g:tagbar_type_coffee = {
            \ 'ctagstype' : 'coffee',
            \ 'kinds'     : [
                \ 'c:classes',
                \ 'm:methods',
                \ 'f:functions',
                \ 'v:variables',
                \ 'f:fields',
            \ ]
        \ }

        " Posix regular expressions for matching interesting items. Since this will 
        " be passed as an environment variable, no whitespace can exist in the options
        " so [:space:] is used instead of normal whitespaces.
        " Adapted from: https://gist.github.com/2901844
        let s:ctags_opts = '
          \ --langdef=coffee
          \ --langmap=coffee:.coffee
          \ --regex-coffee=/(^|=[ \t])*class ([A-Za-z_][A-Za-z0-9_]+\.)*([A-Za-z_][A-Za-z0-9_]+)( extends ([A-Za-z][A-Za-z0-9_.]*)+)?$/\3/c,class/
          \ --regex-coffee=/^[ \t]*(module\.)?(exports\.)?@?(([A-Za-z][A-Za-z0-9_.]*)+):.*[-=]>.*$/\3/m,method/
          \ --regex-coffee=/^[ \t]*(module\.)?(exports\.)?(([A-Za-z][A-Za-z0-9_.]*)+)[ \t]*=.*[-=]>.*$/\3/f,function/
          \ --regex-coffee=/^[ \t]*(([A-Za-z][A-Za-z0-9_.]*)+)[ \t]*=[^->\n]*$/\1/v,variable/
          \ --regex-coffee=/^[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)[ \t]*=[^->\n]*$/\1/f,field/
          \ --regex-coffee=/^[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+):[^->\n]*$/\1/f,static field/
          \ --regex-coffee=/^[ \t]*(([A-Za-z][A-Za-z0-9_.]*)+):[^->\n]*$/\1/f,field/
          \ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?/\3/f,field/
          \ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){0}/\8/f,field/
          \ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){1}/\8/f,field/
          \ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){2}/\8/f,field/
          \ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){3}/\8/f,field/
          \ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){4}/\8/f,field/
          \ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){5}/\8/f,field/
          \ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){6}/\8/f,field/
          \ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){7}/\8/f,field/
          \ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){8}/\8/f,field/
          \ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){9}/\8/f,field/'

        let $CTAGS = substitute(s:ctags_opts, '\v\([nst]\)', '\\', 'g')
    " }}}
    " Turbux {{{
        " this line needed if not using zsh which auto does bundle exec
        "let g:turbux_command_prefix = 'bundle exec'
        let g:no_turbux_mappings = 1
        map <leader>m <Plug>SendTestToTmux
        map <leader>M <Plug>SendFocusedTestToTmux
        let g:turbux_command_prefix = 'spring' " default: (empty)
    " }}}
    " Rails.vim {{{
        " Add support for cucumber, activemodelserializers, and decorators
        let g:rails_projections = {
          \ "config/projections.json": {
          \   "command": "projections"
          \ },
          \ "spec/features/*_spec.rb": {
          \   "command": "feature",
          \   "template": "require 'spec_helper'\n\nfeature '%h' do\n\nend",
          \ }}
 
        let g:rails_gem_projections = {
              \ "active_model_serializers": {
              \   "app/serializers/*_serializer.rb": {
              \     "command": "serializer",
              \     "affinity": "model",
              \     "test": "spec/serializers/%s_spec.rb",
              \     "related": "app/models/%s.rb",
              \     "template": "class %SSerializer < ActiveModel::Serializer\nend"
              \   }
              \ },
              \ "draper": {
              \   "app/decorators/*_decorator.rb": {
              \     "command": "decorator",
              \     "affinity": "model",
              \     "test": "spec/decorators/%s_spec.rb",
              \     "related": "app/models/%s.rb",
              \     "template": "class %SDecorator < Draper::Decorator\nend"
              \   }
              \ },
              \ "factory_girl_rails": {
              \   "spec/factories.rb": {
              \     "command": "factories",
              \     "template": "FactoryGirl.define do\nend"
              \   }
              \ }}
    " }}}
    " Ack {{{
        nmap <leader>a :Ack
        let g:ackprg = 'ag --nogroup --nocolor --column'
    " }}}
    " Syntastic {{{
        let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-", "<pt-"] "]
    " }}}
    " Mustache/Handlebars {{{
      let g:mustache_abbreviations = 1
    " }}}
    
" }}}
" Uncategorized {{{

  " Panic Button, haha.. 
  nnoremap <f9> mzggg?G`z

  " Local config
  if filereadable($HOME . "/.vimrc.local")
    source ~/.vimrc.local
  endif
" }}}
" Trim whitespace on save {{{
    function! <SID>StripTrailingWhitespaces()
      " Preparation: save last search, and cursor position.
      let _s=@/
      let l = line(".")
      let c = col(".")
      " Do the business:
      %s/\s\+$//e
      " Clean up: restore previous search history, and cursor position
      let @/=_s
      call cursor(l, c)
    endfunction

    autocmd BufWritePre *.py,*.js,*.rb,Gemfile,*.haml,*.erb :call <SID>StripTrailingWhitespaces()
" }}}

