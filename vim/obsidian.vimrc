" ============================================================================
" Obsidian Vimrc Configuration
" Mirrors Neovim keymaps for Obsidian (via obsidian-vimrc-support plugin)
" Requires: Obsidian Vimrc Support community plugin
" ============================================================================

" ── Options ─────────────────────────────────────────────────────────────────
set relativenumber
set number
set scrolloff=5
set ignorecase
set smartcase
set hlsearch

" ── Unmap Defaults ──────────────────────────────────────────────────────────
" Clear Obsidian's default vim bindings that conflict
unmap <C-s>
unmap <C-p>

" ── Ex Command Mappings ─────────────────────────────────────────────────────
" These expose Obsidian commands as Ex commands usable in nmap/vmap/imap

exmap w obcommand editor:save
exmap q obcommand workspace:close-tab
exmap qall obcommand workspace:close-window

" Window / Split navigation
exmap splitHorizontal obcommand workspace:split-horizontal
exmap splitVertical obcommand workspace:split-vertical
exmap focusLeft obcommand editor:focus-left
exmap focusRight obcommand editor:focus-right
exmap focusTop obcommand editor:focus-top
exmap focusBottom obcommand editor:focus-bottom
exmap only obcommand workspace:close-other-tabs

" File explorer
exmap toggleFileExplorer obcommand file-explorer:toggle-focus
exmap revealFile obcommand file-explorer:reveal-file

" Search
exmap quickSwitcher obcommand quick-switcher:open
exmap globalSearch obcommand global-search:open

" Tab navigation
exmap nextTab obcommand workspace:next-tab
exmap prevTab obcommand workspace:previous-tab
exmap closeTab obcommand workspace:close-tab
exmap closeOtherTabs obcommand workspace:close-other-tabs
exmap pinTab obcommand workspace:pin-tab

" Undo / Redo (via editor commands)
exmap undo obcommand editor:undo
exmap redo obcommand editor:redo

" Obsidian Git plugin (requires obsidian-git community plugin)
exmap gitPush obcommand obsidian-git:push
exmap gitPull obcommand obsidian-git:pull
exmap gitCommit obcommand obsidian-git:commit-changes
exmap gitLog obcommand obsidian-git:open-git-view
exmap gitStatus obcommand obsidian-git:open-diff-view

" Outline / Backlinks
exmap outline obcommand outline:open
exmap backlinks obcommand backlink:open

" ── Save / Quit ─────────────────────────────────────────────────────────────
nmap <C-s> :w
imap <C-s> <Esc>:w
nmap <leader>q :q
nmap <leader>w :w
nmap <leader>x :wq

" ── Window / Split Navigation ──────────────────────────────────────────────
nmap <C-h> :focusLeft
nmap <C-l> :focusRight
nmap <C-j> :focusBottom
nmap <C-k> :focusTop

" ── Split Creation ─────────────────────────────────────────────────────────
nmap <leader>wh :splitVertical
nmap <leader>wj :splitHorizontal
nmap <leader>wk :splitHorizontal
nmap <leader>wl :splitVertical
nmap <leader>wo :only
nmap <leader>wq :closeTab
nmap <leader>we <C-w>=

" ── Buffer (Tab) Navigation ────────────────────────────────────────────────
nmap ]b :nextTab
nmap [b :prevTab
nmap <leader>bb :nextTab
nmap <leader>bd :closeTab
nmap <leader>bo :closeOtherTabs
nmap <leader>tp :pinTab

" ── File Explorer ──────────────────────────────────────────────────────────
nmap <leader>e :toggleFileExplorer
nmap <leader>ee :revealFile

" ── Find / Search ──────────────────────────────────────────────────────────
nmap <leader>ff :quickSwitcher
nmap <leader>fw :globalSearch
nmap <leader>fa :globalSearch

" ── Line Navigation ────────────────────────────────────────────────────────
" H and L to start/end of line (visual mode too)
nmap H ^
nmap L $
vmap H ^
vmap L $

" ── Search Centered ────────────────────────────────────────────────────────
nmap n nzz
nmap N Nzz

" ── Better j/k for wrapped lines ───────────────────────────────────────────
nmap j gj
nmap k gk

" ── Line Movement ──────────────────────────────────────────────────────────
nmap <A-j> :m .+1<CR>==
nmap <A-k> :m .-2<CR>==
vmap <A-j> :m '>+1<CR>gv=gv
vmap <A-k> :m '<-2<CR>gv=gv

" ── Paste Without Yanking ──────────────────────────────────────────────────
vmap p "_dP

" ── Swap Selection with Clipboard ──────────────────────────────────────────
vmap P "+ygv"_d"+P

" ── Indent / Unindent with Tab ─────────────────────────────────────────────
nmap <Tab> >>
nmap <S-Tab> <<
vmap <Tab> >gv
vmap <S-Tab> <gv

" ── Undo / Redo ────────────────────────────────────────────────────────────
nmap <leader>u :undo

" ── Git (Obsidian Git plugin) ──────────────────────────────────────────────
nmap <leader>gg :gitLog
nmap <leader>gp :gitPush
nmap <leader>gpl :gitPull
nmap <leader>gc :gitCommit
nmap <leader>gs :gitStatus

" ── Outline / Backlinks ────────────────────────────────────────────────────
nmap <leader>lo :outline
nmap <leader>lb :backlinks

" ── Tab Management ─────────────────────────────────────────────────────────
nmap <leader>tn :nextTab
nmap <leader>tp :prevTab
nmap <leader>tc :closeTab
nmap <leader>to :closeOtherTabs

" ── Select All ──────────────────────────────────────────────────────────────
nmap <C-a> ggVG
imap <C-a> <Esc>ggVG

" ── Visual Block Mode ──────────────────────────────────────────────────────
" Ctrl+v for visual block (standard vim)
" Already works in Obsidian vim

" ── Quick Actions ──────────────────────────────────────────────────────────
" Toggle between editor and preview
nmap <leader>mp :obcommand markdown:toggle-preview

" Open command palette
nmap <leader><leader> :obcommand command-palette:open
