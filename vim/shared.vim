" ============================================================================
" Shared Vim Configuration
" Portable keymaps for IdeaVim and terminal Vim
" Sourced by: vim/ideavimrc, ~/.vimrc (terminal Vim)
" ============================================================================

" ── Leader ──────────────────────────────────────────────────────────────────
let mapleader=" "

" ── Options ─────────────────────────────────────────────────────────────────
set relativenumber
set number
set scrolloff=5
set ignorecase
set smartcase
set hlsearch
set incsearch
set viminfo='25
set clipboard+=unnamedplus,ideaput

" ── Plugins ─────────────────────────────────────────────────────────────────
set surround
set commentary
set NERDTree
set multiple-cursors
set highlightedyank
set which-key
set easymotion

" ── Search Centered ─────────────────────────────────────────────────────────
map n nzz
map N Nzz

" ── Better j/k for wrapped lines ────────────────────────────────────────────
map j gj
map k gk

" ── Paste Without Yanking ──────────────────────────────────────────────────
vmap p "_dP

" ── Swap Selection with Clipboard ──────────────────────────────────────────
function! s:SwapWithClipboard()
    let clip = @+
    if clip == ''
        return
    endif
    let zsave = @z
    normal! "zy
    let sel = @z
    let @z = clip
    normal! gv"_d"zP
    let @z = zsave
    let @+ = sel
    let @" = sel
endfunction
xnoremap P :<C-u>call <SID>SwapWithClipboard()<CR>

" ── Indent / Unindent with Tab ─────────────────────────────────────────────
nmap <Tab> >>
nmap <S-Tab> <<
vmap <Tab> >gv
vmap <S-Tab> <gv

" ── Line Navigation ────────────────────────────────────────────────────────
nmap H ^
nmap L $
vmap H ^
vmap L $

" ── Incremental Selection (Enter/Backspace) ─────────────────────────────────
sethandler <CR> a:vim
sethandler <BS> a:vim

" ── Flash / EasyMotion ──────────────────────────────────────────────────────
" s  → jump to any 2-char sequence
" S  → line-level jump
" gw → word-level jump
map s <Plug>(easymotion-sn)
map S <Plug>(easymotion-bd-jk)
map gw <Plug>(easymotion-bd-w)
map <leader>s <Plug>(easymotion-overwin-f2)

" ── Which-Key Groups ───────────────────────────────────────────────────────
" Help discoverability for leader key groups
map <leader>b <nop>
map <leader>d <nop>
map <leader>e <nop>
map <leader>f <nop>
map <leader>g <nop>
map <leader>l <nop>
map <leader>o <nop>
map <leader>q <nop>
map <leader>r <nop>
map <leader>t <nop>
map <leader>w <nop>
map <leader>x <nop>
