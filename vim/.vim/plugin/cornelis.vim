let g:cornelis_max_width = 100
let g:cornelis_split_location = 'vertical'
au BufRead,BufNewFile *.agda call AgdaFiletype()
function! AgdaFiletype()
  inoremap <C-a> <cmd>CornelisLoad<Cr>
  nnoremap <C-a> :CornelisLoad<Cr>
  inoremap <C-s> <cmd>CornelisAuto<Cr>
  nnoremap <C-s> :CornelisAuto<Cr>
  inoremap <C-e> <cmd>CornelisMakeCase<Cr>
  nnoremap <C-e> :CornelisMakeCase<Cr>
  inoremap <C-o> <cmd>on\|CornelisLoad<CR>
  nnoremap <C-o> :on\|CornelisLoad<CR>
  nnoremap <Leader>d :CornelisGoToDefinition<CR>
  nnoremap <Leader>n :CornelisNextGoal<CR>
  nnoremap <Leader>p :CornelisPrevGoal<CR>
endfunction
function! CornelisLoadWrapper()
  if exists(":CornelisLoad") ==# 2
    CornelisLoad
  endif
endfunction
au BufReadPre *.agda call CornelisLoadWrapper()
au BufReadPre *.lagda* call CornelisLoadWrapper()
au BufWritePost *.agda call CornelisLoadWrapper()
au BufWritePost *.lagda* call CornelisLoadWrapper()
call cornelis#bind_input("==>", "≡⟨⟩")
call cornelis#bind_input("eqb", "≡⟨⟩")
call cornelis#bind_input("eq", "≡")
call cornelis#bind_input("neq", "≢")
