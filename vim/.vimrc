let g:python3_host_prog = $HOME.'/.pyenv/versions/neovim3/bin/python'
let g:node_host_prog = system('which neovim-node-host')

" vim plugin manager
runtime vim-pathogen/autoload/pathogen.vim

if has('nvim')
  execute pathogen#infect('bundle/{}', 'bundle.nvim/{}')
else
  execute pathogen#infect('bundle/{}')
  let g:netrw_liststyle=3
  set backspace=2
  set foldmethod=indent
endif

" plugin bindings
let g:fzf_action={'ctrl-s': 'split', 'ctrl-v': 'vsplit'}
let g:fzf_preview_window = ['right,50%,<70(up,40%)', 'ctrl-/']
let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:vimtex_view_general_options = '-reuse-instance @pdf'
let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'

" filetype settings
set shiftround expandtab softtabstop=2 tabstop=2 shiftwidth=2
autocmd FileType make,gitconfig setlocal noexpandtab
autocmd FileType markdown,mkd,md,tex,text setlocal spell spelllang=en_us
autocmd FileType qf set nobuflisted
autocmd WinEnter * if &previewwindow | set nobuflisted | endif

" vim bindings
let mapleader = "\<Space>"
set pastetoggle=<F2>
" refresh
nnoremap <silent> <Leader>r :let buf=bufnr('%')<CR>:bufdo e<CR>:syntax on<CR>:execute ":buffer ". buf<CR>
nnoremap <silent> <Leader>c :q<CR>
nnoremap <silent> <Leader>o :GFiles<CR>
nnoremap <silent> <Leader>w :w<CR>
nnoremap <silent> <Leader>q :bp\|bd #<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <C-e> 8<C-e>
nnoremap <silent> <C-y> 8<C-y>
vnoremap <silent> <C-e> 8<C-e>
vnoremap <silent> <C-y> 8<C-y>
nnoremap <silent> gn :cn<CR>
nnoremap <silent> gp :cp<CR>
nnoremap <silent> gq :ccl<CR>
nnoremap <silent> <C-L> :nohlsearch<CR>:mode<CR><C-L>
nnoremap <silent> <C-o> :on<CR>
inoremap jk <Esc>

" application settings
if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif

" vim settings
set timeout timeoutlen=300
set laststatus=2 " always display status lines
set hidden " allow switching buffers without saving
set wildmenu wildmode=list:longest,list:full wildignore=
  \.git,*.swp,*/tmp/*,*.so,*.swp,*.zip,*.o,*.a,
  \*.pyc,*.class,*.jar,*/node_modules/*,
  \*/vendor/* " bash-like command completion
set incsearch " incremental search
set tags=./tags;,tags;

" statusline
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#Cursor#
set statusline+=%{StatuslineGit()}
set statusline+=%#Visual#
set statusline+=\ %y\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]\ 
set statusline+=%#Normal#
set statusline+=\ %f\ %h%w%m%r%=%-14.(%l:%c%V\ \/\ %L%)\ %P
" A E S T H E T I C settings
set nowrap
let &colorcolumn="80,100,".join(range(120,999),",")
set list listchars=tab:▸\ ,trail:·
set number cuc cursorline
set secure modeline modelines=5
filetype plugin indent on
syntax on

" performance
set lazyredraw
set synmaxcol=256
syntax sync minlines=256
