function s:plugins()
	call plug#begin(g:home.'bundle')
	Plug 'tpope/vim-surround'
	Plug 'wellle/targets.vim'
	call plug#end()
	echom "loaded plugins"
endfunction

function s:mappings()
	let mapleader=" "
	nnoremap <leader>r <Cmd>:Tabfind<CR>
	nnoremap <leader>w <Cmd>:Write<CR>

	xmap gc  <Plug>VSCodeCommentary
	nmap gc  <Plug>VSCodeCommentary
	omap gc  <Plug>VSCodeCommentary
	nmap gcc <Plug>VSCodeCommentaryLine
	echom "loaded mappings"
endfunction

if exists("g:vscode")
	let g:home=expand('<sfile>:p:h')."/"
	echom "home: ". g:home
	if empty(glob(g:home . 'autoload/plug.vim'))
	  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	endif
	call s:plugins()
    set clipboard+=unnamedplus
	" call s:mappings()
	let mapleader=" "
	nnoremap <leader>r <Cmd>:Tabfind<CR>
	nnoremap <leader>w <Cmd>:Write<CR>

	xmap gc  <Plug>VSCodeCommentary
	nmap gc  <Plug>VSCodeCommentary
	omap gc  <Plug>VSCodeCommentary
	nmap gcc <Plug>VSCodeCommentaryLine
	echom "loaded mappings"
endif
