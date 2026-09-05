local set = vim.opt

if vim.fn.executable("python") == 1 then
  -- force python into a venv if not already available
  local venvPath = vim.fn.stdpath("data") .. "/venv"
  ---@diagnostic disable-next-line: undefined-field
  if not vim.uv.fs_stat(venvPath) then
    vim.fn.system({
      "python",
      "-m",
      "venv",
      venvPath,
    })
    vim.fn.system({
      venvPath .. "/bin/python",
      "-m",
      "pip",
      "install",
      "pynvim",
    })
  end
  vim.g.python3_host_prog = venvPath .. "/bin/python"
end
set.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
-- set.guioptions^=c
-- set.guioptions-=T
-- set.guioptions-=t
-- set.guioptions-=r
-- set.guioptions+=R
set.updatetime = 300
set.showmode = true
-- allow backspacing over everything in insert mode
set.backspace = "indent,eol,start"
set.history = 50 --  keep 50 lines of command line history
set.ruler = true -- show the cursor position all the time
set.cursorline = false -- nocursorline
set.cursorcolumn = false -- display incomplete commands
set.incsearch = true -- " do incremental searching
set.encoding = "utf-8"
set.hidden = true
set.number = true
set.signcolumn = "yes:3"
-- set.wildchar='<Tab>'
set.wildmenu = true
set.wildmode = "longest:full,full"
set.wildoptions = "pum"
set.wildignorecase = true
set.wildignore:append({ "*.swp", "*.bak", "*.class", ".git/*", ".svn/*" })
set.wildignore:append({ "*.jpg", "*.png" })
set.wildignore:append({ "node_modules/*" })

-- set.pastetoggle='<F11>'

set.hlsearch = true
set.ignorecase = true
set.smartcase = true
set.inccommand = "split"
set.gdefault = true

-- wait time for mapped sequences
set.timeout = true

-- wait time for mapped keychords
set.ttimeout = true
set.ttimeoutlen = 500

set.undofile = true
set.undolevels = 1000

set.completeopt = "menu,menuone,noselect"
-- set.omnifunc = vim.lsp.omnifunc

set.winaltkeys = "no"
set.mouse = "a"

set.backup = false

set.switchbuf = "usetab"
set.showmatch = true
set.wrap = false

set.copyindent = true
set.smartindent = true
set.smarttab = true
set.expandtab = true
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4

set.visualbell = true
set.errorbells = false
set.list = true
set.listchars = "tab:».,trail:░,extends:→,nbsp:."
set.colorcolumn = "120"
vim.schedule(function()
  vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
end)

-- Open splits to the right by default
set.splitright = true
vim.g.colors = {
  "sonokai",
  "catppuccin-latte",
  "Tomorrow-Night",
  "Monokai",
  "molokai",
  "github",
  "kalisi,dark",
  "gruvbox,dark",
}

if vim.fn.has("mac") == 1 then
  vim.g.fonts = {
    "FantasqueSansM Nerd Font",
    "MonaspiceKr Nerd Font",
    "MonaspiceAr Nerd Font",
    "MonaspiceRn Nerd Font",
    "MonaspiceXe Nerd Font",
    "Iosevka Nerd Font",
    "Andale Mono",
    "Courier New",
    "IBM Plex Mono",
    "PT Mono",
    "Monaco",
  }
else
  vim.g.fonts = {
    "FantasqueSansMono Nerd Font",
    "Iosevka Nerd Font",
    "DejaVu Sans Mono",
    "Envy Code R",
    "Inconsolata",
    "Liberation Mono",
    "mononoki",
    "Nimbus Mono PS",
    "JetbrainsMonoNL Nerd Font Propo",
    "MonaspiceKr Nerd Font",
    "MonaspiceAr Nerd Font",
    "MonaspiceRn Nerd Font",
    "MonaspiceXe Nerd Font",
    "Hack",
    "SourceCodeVF",
  }
end

-- diagnostic config
vim.diagnostic.config({
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "󰋼",
      [vim.diagnostic.severity.HINT] = "󰌵",
    },
  },
  float = {
    border = "rounded",
    format = function(d)
      return ("%s (%s) [%s]"):format(d.message, d.source, d.code or d.user_data.lsp.code)
    end,
  },
  underline = true,
  jump = {
    on_jump = function()
      vim.diagnostic.open_float({ focus = false })
    end,
  },
})

if vim.g.neovide then
  print("init neovide settings")
  vim.g.neovide_box_drawing_mode = "native"
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"
  vim.opt.linespace = 0
  vim.g.neovide_no_multigrid = true
end
