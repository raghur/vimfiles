function! s:sendSelection()
    let visualmode = visualmode()
	let startLine = line("v")
	let endLine = line(".")
	call VSCodeNotifyRange("fsi.SendSelection", startLine, endLine, 1)
endfunction

if exists("g:vscode")
	let g:home=expand('<sfile>:p:h')."/"
	echom "home: ". g:home
	if empty(globpath(&runtimepath, 'autoload/plug.vim'))
		echohl WarningMsg
		echom "vim-plug is not installed; install it in an autoload directory on 'runtimepath'"
		echohl None
	else
		call plug#begin(g:home.'bundle')
		Plug 'tpope/vim-surround'
		Plug 'wellle/targets.vim'
		Plug 'sheerun/vim-polyglot'
		call plug#end()
		echom "loaded plugins"
	endif

	set ignorecase
    set clipboard+=unnamedplus
	let mapleader=" "
	nnoremap <leader>r <Cmd>:Tabfind<CR>
	nnoremap <leader>w <Cmd>:Write<CR>
	nnoremap <leader>t <Cmd>call VSCodeNotify('workbench.action.showAllSymbols')<CR>
	nnoremap <leader>[ <Cmd>call VSCodeNotify('editor.action.marker.next')<CR>
	nnoremap <leader>] <Cmd>call VSCodeNotify('editor.action.marker.prev')<CR>
	nnoremap <leader>P "0P
	vnoremap <leader>p "0p
	nnoremap <leader>a :b#<cr>
	nnoremap <leader>d <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<cr>
	xnoremap <leader><CR> <Cmd>call <SID>sendSelection()<CR>

	xmap gc  <Plug>VSCodeCommentary
	nmap gc  <Plug>VSCodeCommentary
	omap gc  <Plug>VSCodeCommentary
	nmap gcc <Plug>VSCodeCommentaryLine
	echom "loaded mappings"
endif
