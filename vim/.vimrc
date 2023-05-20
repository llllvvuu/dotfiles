let g:python3_host_prog = $HOME.'/.pyenv/versions/neovim3/bin/python'
" let g:node_host_prog = $HOME.'/.nvm/versions/node/v18.16.0/bin/neovim-node-host'

" vim plugin manager
runtime vim-pathogen/autoload/pathogen.vim

if has('nvim')
    execute pathogen#infect('bundle/{}', 'bundle.nvim/{}')
    set completeopt=menu,menuone,noselect
lua << EOF
local luasnip = require('luasnip')
luasnip.filetype_extend('typescript.tsx', { 'typescriptreact' })
luasnip.filetype_extend('typescript', { 'typescriptreact' })
require("luasnip.loaders.from_vscode").lazy_load()
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
local lspconfig = require('lspconfig')

local servers = {
  'bashls',
  'bufls', -- Protobuf
  'clangd',
  'cssls',
  'cssmodules_ls',
  'custom_elements_ls',
  'docker_compose_language_service',
  'dockerls',
  'eslint',
  'graphql',
  'hls', -- Haskell
  'html',
  'jsonls',
  'pyright',
  'rust_analyzer',
  'solc', -- Solidity
  'sqlls',
  'tailwindcss',
  'texlab',
  'tsserver',
  'vimls',
  'vuels',
}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
    }
end

vim.opt.signcolumn = "yes:1"
local cmp = require('cmp')
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        {name = 'path'},
        {name = 'nvim_lsp'},
        {name = 'buffer'},
        {name = 'luasnip'},
    },
}
EOF

    imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
    inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

    snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
    snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
else
    execute pathogen#infect('bundle/{}')
    let g:netrw_liststyle=3
    set backspace=2
endif

" plugin bindings
let g:fzf_action={'ctrl-s': 'split', 'ctrl-v': 'vsplit'}
let g:fzf_preview_window = ['right,50%,<70(up,40%)', 'ctrl-/']
let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:vimtex_view_general_options = '-reuse-instance @pdf'
let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
let g:copilot_filetypes = {'text': v:false}
inoremap <C-q> <cmd>Copilot<Cr>
let g:cornelis_max_width = 80
let g:cornelis_split_location = 'vertical'
au BufRead,BufNewFile *.agda call AgdaFiletype()
function! AgdaFiletype()
  inoremap <C-a> <cmd>execute "CornelisLoad"\|CornelisGoal<Cr>
  nnoremap <C-a> :execute "CornelisLoad"\|CornelisGoal<Cr>
  inoremap <C-s> <cmd>CornelisAuto<Cr>
  nnoremap <C-s> :CornelisAuto<Cr>
  inoremap <C-e> <cmd>CornelisMakeCase<Cr>
  nnoremap <C-e> :CornelisMakeCase<Cr>
  nnoremap <silent> <Leader>d :CornelisGoToDefinition<CR>
  nnoremap <silent> <Leader>n :CornelisNextGoal<CR>
  nnoremap <silent> <Leader>p :CornelisPrevGoal<CR>
endfunction
function! CornelisLoadWrapper()
  if exists(":CornelisLoad") ==# 2
    CornelisLoad
    CornelisGoal
  endif
endfunction
au BufReadPre *.agda call CornelisLoadWrapper()
au BufReadPre *.lagda* call CornelisLoadWrapper()
au BufWritePost *.agda call CornelisLoadWrapper()
au BufWritePost *.lagda* call CornelisLoadWrapper()
call cornelis#bind_input("==>", "≡⟨⟩")

" filetype settings
set shiftround expandtab softtabstop=2 tabstop=2 shiftwidth=2
autocmd FileType solidity setlocal shiftround expandtab softtabstop=4 tabstop=4 shiftwidth=4
autocmd FileType make,gitconfig setlocal noexpandtab
autocmd FileType lua setlocal iskeyword+=:
autocmd FileType markdown,mkd,md,tex,text setlocal spell spelllang=en_us
autocmd FileType qf set nobuflisted
autocmd WinEnter * if &previewwindow | set nobuflisted | endif

" vim bindings
let mapleader = "\<Space>"
set pastetoggle=<F2>
" refresh
nnoremap <silent> <Leader>r :let buf=bufnr('%')<CR>:bufdo e<CR>:syntax on<CR>:execute ":buffer ". buf<CR>
nnoremap <silent> <Leader>n :set relativenumber!<CR>
nnoremap <silent> <Leader>c :q<CR>
nnoremap <silent> <Leader>o :GFiles<CR>
nnoremap <silent> <Leader>w :w<CR>
nnoremap <silent> <Leader>q :bp\|bd #<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap ' :<C-u>marks<CR>:normal! `
nnoremap <silent> <C-L> :nohlsearch<CR>:mode<CR><C-L>
inoremap jk <Esc>

" application settings
if $VIM_CRONTAB == "true"
    set nobackup
    set nowritebackup
endif

" vim settings
set timeoutlen=420
set laststatus=2 " always display status lines
set hidden " allow switching buffers without saving
set wildmenu wildmode=list:longest,list:full wildignore=
    \.git,*.swp,*/tmp/*,*.so,*.swp,*.zip,*.o,*.a,
    \*.pyc,*.class,*.jar,*/node_modules/*,
    \*/vendor/* " bash-like command completion
set incsearch " incremental search
set tags=./tags;,tags;

" A E S T H E T I C settings
set background=dark
let base16colorspace=256
colorscheme $COLORSCHEME
set nowrap
set relativenumber number
set foldmethod=indent
autocmd BufWinEnter * call matchadd('ColorColumn', '\(\%80v\|\%100v\)', 100)
set listchars=tab:▸\ ,trail:·
set list
set secure modeline modelines=5
filetype plugin indent on
syntax on

" performance
set lazyredraw
set synmaxcol=256
syntax sync minlines=256
