syntax on

set noshowmatch
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set cindent
set nu
set nowrap
set smartcase
set ignorecase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set colorcolumn=100
set noshowmode
" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'vim-airline/vim-airline'
Plug 'psliwka/vim-smoothie'
Plug 'easymotion/vim-easymotion'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'mattn/emmet-vim'
Plug 'stsewd/fzf-checkout.vim'

call plug#end()

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'
let g:gruvbox_material_visual = 'blue background'
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_menu_selection_background = 'blue'

set background=dark
let g:gruvbox_contrast_dark = 'medium'
colorscheme gruvbox-material

if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1
let mapleader = " "

nnoremap <C-p> :GFiles<CR>
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>phw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <Leader>pf :Files<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <A-[> :vertical resize -5<CR>
nnoremap <A-]> :vertical resize +5<CR>
nnoremap <Leader>rp :resize 100<CR>
nnoremap <Leader>ee oif err != nil {<CR>log.Fatalf("%+v\n", err)<CR>}<CR><esc>kkI<esc>
noremap K 5k
noremap J 5j
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>
vnoremap X "_d
nnoremap go o<Esc>k
nnoremap gO O<Esc>j
nnoremap <leader>gc :GCheckout<CR>


augroup focus
  autocmd!
  autocmd FocusLost,BufLeave * silent! wa
augroup END

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

command! -nargs=0 Prettier :CocCommand prettier.formatFile
inoremap <silent><expr> <C-space> coc#refresh()

" GoTo code navigation.
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<CR>
nnoremap <leader>gb  :<C-u>CocList buffers<CR>
nnoremap <leader>ac <Plug>(coc-codeaction)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <leader>gh <Plug>(coc-fix-current)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)
nnoremap <leader>cr :CocRestart<CR>
nmap <C-k> <C-u>
nmap <C-j> <C-d>
nmap <D-j> <C-d>
imap jk <Esc>
imap jj <Esc>
nnoremap <leader>q :q<cr>
nnoremap <leader>z :wq<cr>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()

fun! ToggleGStatus()
    if buflisted(bufname('.git/index'))
        bd .git/index
    else
        Gstatus
    endif
endfun
command! ToggleGStatus :call ToggleGStatus()
nmap <F3> :ToggleGStatus<CR>

map <C-n> :NERDTreeToggle<CR>

"GitGutter
nmap  ghp <Plug>(GitGutterPreviewHunk)
nmap  ghu <Plug>(GitGutterUndoHunk)
nmap  ghs <Plug>(GitGutterStageHunk)
xmap  ghs <Plug>(GitGutterStageHunk)

" Vim motion
" s{char}{char} to move to {char}{char}
hi link EasyMotionTarget yellow
hi link EasyMotionIncSearch red

nmap s <Plug>(easymotion-overwin-f2)
let g:EasyMotion_smartcase = 1
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
" <Leader>f{char} to move to {char}
nmap f <Plug>(easymotion-bd-fl)
nmap t <Plug>(easymotion-bd-tl)

let g:airline_section_y=''
let g:airline_section_z=''


nmap <leader>g; :diffget //3<CR>
nmap <leader>gj :diffget //2<CR>

"Abbreviation
ab clg console.log(

