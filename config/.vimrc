syntax on
filetype plugin indent on
silent! colorscheme sorbet

"Abbreviations
iabbrev bpry require 'pry'; binding.pry
iabbrev ipry require IEx; IEx.pry

map ,e :e <C-R>=expand("%:p:h") . "/" <CR>  "auto complete file names

command! -bar -range=% NotRocket :<line1>,<line2>s/:\?"\?\(\w\+\)"\?\s*=>/\1: /ge

"Save file
nnoremap <Leader>w :w<CR>
"Cycle to previous item in quickfix
nnoremap <Leader>a :cp<CR>
"Cycle to next item in quickfix
nnoremap <Leader>e :e %:h
nnoremap <Leader>f :cn<CR>
nnoremap <Leader>g :Ack <C-r><C-w><CR>
nnoremap <C-f> :e#<CR>
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
nnoremap - :e %:h<CR>
nnoremap <ESC><ESC> :noh<CR>

imap OB <ESC>ji

vnoremap <Leader>g "hy:Ack <C-r>h<CR>
vnoremap gs :sort u <CR>

set autoindent " Newline retains the preceding line's indentation
set backspace=indent,eol,start
set expandtab " Convert tabs to white spaces
set hidden " Remember undo history across buffer changes
set hlsearch " Highlight search results after search
set ignorecase
set list " Show whitespace markers
set listchars=tab:·\ ,trail:• " Specify whitespace symbols
set number " Show line numbers
set shiftwidth=0 " Tabstop's value
set smartcase
set softtabstop=-1 " Tabstop's value
set tabstop=2 " Set the tab size to 2 whitespaces

" Use undo file
" Create dir (cleared with entire /tmp dir)
silent !mkdir -p /tmp/.vimundo
set undodir=/tmp/.vimundo
set undofile

" Plugin Config
" ALE Configuration: {{{
  let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'c': ['clang-format'],
  \ 'css': ['prettier'],
  \ 'cmake': ['cmakeformat'],
  \ 'cpp': ['clang-format'],
  \ 'elixir': ['mix_format'],
  \ 'html': ['prettier'],
  \ 'javascript': ['prettier'],
  \ 'json': ['prettier'],
  \ 'python': ['black'],
  \ 'ruby': ['standardrb', 'rubocop'],
  \ 'scss': ['prettier'],
  \ 'sql': ['pgformatter'],
  \ 'typescript': ['prettier'],
  \ 'xml': ['xmllint'],
  \}

  let g:ale_linters = extend(
    \ copy(g:ale_fixers),
    \{
    \ 'sh': ['shellcheck'],
    \}
  \)

  let g:ale_completion_enabled = 1
  let g:ale_fix_on_save = 1
  let g:ale_linters_explicit = 1
  let g:deoplete#enable_at_startup = 1
  let g:ale_sign_error = "🚨"
  let g:ale_sign_warning = "😬"

  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
" }}}

" NERDTree Configuration: {{{
  let NERDTreeQuitOnOpen=1
" }}}

" Vim Commentary Configuration: {{{
  autocmd FileType cpp setlocal commentstring=//%s
" }}}

" Vim Jsx Configuration: {{{
let g:jsx_ext_required = 0 "Allow jsx syntax highlighting for .js files
" }}}

let g:markdown_fenced_languages = [
  \'html',
  \'vim',
  \'ruby',
  \'python',
  \'bash=sh',
  \'js=javascript',
\] " Syntax highlighting in markdown code blocks

" Vim Turbux: {{{
  let g:tslime_always_current_session = 1
  let g:tslime_always_current_window = 1
" }}}

"Command to delete file in vim
function! DeleteFile(...)
  if(exists('a:1'))
    let theFile=a:1
  elseif ( &ft == 'help' )
    echohl Error
    echo "Cannot delete a help buffer!"
    echohl None
    return -1
  else
    let theFile=expand('%:p')
  endif
  let delStatus=delete(theFile)
  if(delStatus == 0)
    echo "Deleted " . theFile
  else
    echohl WarningMsg
    echo "Failed to delete " . theFile
    echohl None
  endif
  return delStatus
endfunction

"delete the current file
com! Rm call DeleteFile()
"delete the file and quit the buffer (quits vim if this was the last file)
com! RM call DeleteFile() <Bar> q!

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
" Replace highlighted text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
