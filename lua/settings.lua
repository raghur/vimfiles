local set=vim.opt
set.completeopt="menu,menuone,noselect"
-- set.guioptions^=c
-- set.guioptions-=T
-- set.guioptions-=t
-- set.guioptions-=r
-- set.guioptions+=R
set.updatetime=2000
set.showmode=true
-- allow backspacing over everything in insert mode
set.backspace="indent,eol,start"
set.history=50      --  keep 50 lines of command line history
set.ruler=true       -- show the cursor position all the time
set.cursorline=false -- nocursorline
set.cursorcolumn=false -- display incomplete commands
set.incsearch=true  -- " do incremental searching
set.encoding='utf-8'
set.hidden=true
set.number=true
set.signcolumn='number'
-- set.wildchar='<Tab>'
set.wildmenu=true
set.wildmode='longest,list:longest'
set.wildignore:append({'*.swp','*.bak','*.class','.git/*','.svn/*'})
set.wildignore:append({'*.jpg','*.png'})
set.wildignore:append({'node_modules/*'})
set.wildignorecase=true

-- set.pastetoggle='<F11>'

set.ignorecase=true
set.smartcase=true
set.timeout=true
set.timeoutlen=1000
set.ttimeoutlen=100

set.undofile=true
set.undodir=vim.fn.stdpath('state')..'vimbackups/.undo'
set.undolevels=1000

set.completeopt = 'menu,menuone,noselect'
set.omnifunc = 'syntaxcomplete#Complete'

set.winaltkeys='no'
set.mouse='a'

set.backup=false

set.switchbuf='usetab'
-- set.matchpairs+=<:>
set.showmatch=true
set.wrap=false
set.copyindent=true
set.smartindent=true
set.smarttab=true
set.expandtab=true
set.tabstop=4
set.softtabstop=4
set.shiftwidth=4
set.visualbell=true
set.errorbells=false
set.list=true
set.listchars='tab:».,trail:░,extends:→,nbsp:.'
set.inccommand='split'
set.hlsearch=true
set.gdefault=true
set.colorcolumn='120'
vim.schedule(function()
  vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
  if vim.fn.has('linux') > 0 then
    vim.g.clipboard = {
      name = "xsel",
      copy = {
        ["+"] = "xsel --nodetach -i -b",
        ["*"] = "xsel --nodetach -i -p",
      },
      paste = {
        ["+"] = "xsel -o -b",
        ["*"] = "xsel -o -b",
      },
      cache_enabled = 1,
    }
  end
end)
-- set.clipboard='unnamedplus'

-- Open splits to the right by default
set.splitright=true
vim.g.colors = {
  'catppuccin-latte',
  'Tomorrow-Night', 'Monokai', 'molokai', 'github', 'kalisi,dark', 'gruvbox,dark'}

if (vim.uv.os_uname().sysname == "Darwin") then
  vim.g.fonts = {
    'FantasqueSansM Nerd Font Mono',
    'MonaspiceKr Nerd Font Mono',
    'MonaspiceAr Nerd Font Mono',
    'MonaspiceRn Nerd Font Mono',
    'Iosevka Nerd Font Mono',
  }
else
  vim.g.fonts = {
    'FantasqueSansMono NF',
    'Iosevka Curly',
    'Courier New',
    'Cousine',
    'DejaVu Sans Mono',
    'Envy Code R',
    'Inconsolata',
    'Iosevka Term Curly',
    'Liberation Mono',
    'mononoki',
    'Nimbus Mono L',
    'Noto Mono',
    'Noto Sans Mono',
    'PT Mono',
    'Ubuntu Mono',
    'JetbrainsMonoNL Nerd Font Propo',
    'Hack'}
end
