local set = vim.opt

local python_venv = vim.fs.joinpath(vim.fn.stdpath("data"), "venv")
local python_host = vim.fs.joinpath(
  python_venv,
  vim.fn.has("win32") == 1 and "Scripts/python.exe" or "bin/python"
)

if vim.fn.executable(python_host) == 1 then
  vim.g.python3_host_prog = python_host
end

vim.api.nvim_create_user_command("PythonProviderBootstrap", function()
  local python = vim.fn.exepath("python3")
  if python == "" then
    python = vim.fn.exepath("python")
  end
  if python == "" then
    vim.notify("Python 3 is required to bootstrap the Neovim provider", vim.log.levels.ERROR)
    return
  end

  local function run(args)
    local result = vim.system(args, { text = true }):wait()
    if result.code == 0 then
      return true
    end
    local message = result.stderr ~= "" and result.stderr or result.stdout
    vim.notify(message or "Python provider bootstrap failed", vim.log.levels.ERROR)
    return false
  end

  if not run({ python, "-m", "venv", python_venv }) then
    return
  end
  if not run({ python_host, "-m", "pip", "install", "pynvim" }) then
    return
  end

  vim.g.python3_host_prog = python_host
  vim.notify("Python provider ready at " .. python_host, vim.log.levels.INFO)
end, {
  desc = "Create Neovim's Python environment and install pynvim",
  force = true,
})
set.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
-- set.guioptions^=c
-- set.guioptions-=T
-- set.guioptions-=t
-- set.guioptions-=r
-- set.guioptions+=R
set.updatetime = 300
set.history = 50 -- keep 50 lines of command line history
set.number = true
set.signcolumn = "yes:3"
-- set.wildchar='<Tab>'
set.wildmode = "longest:full,full"
set.wildoptions = "pum"
set.wildignorecase = true
set.wildignore:append({ "*.swp", "*.bak", "*.class", ".git/*", ".svn/*" })
set.wildignore:append({ "*.jpg", "*.png" })
set.wildignore:append({ "node_modules/*" })

-- set.pastetoggle='<F11>'

set.ignorecase = true
set.smartcase = true
set.inccommand = "split"
set.gdefault = true

-- wait time for mapped keychords
set.ttimeoutlen = 500

set.undofile = true

set.completeopt = "menu,menuone,noselect"
-- set.omnifunc = vim.lsp.omnifunc

set.winaltkeys = "no"
set.mouse = "a"

set.switchbuf = "usetab"
set.showmatch = true
set.wrap = false

set.copyindent = true
set.smartindent = true
set.expandtab = true
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4

set.visualbell = true
set.list = true
set.listchars = "tab:».,trail:░,extends:→,nbsp:."
set.colorcolumn = "120"
vim.schedule(function()
  vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
end)

-- Open splits to the right by default
set.splitright = true
vim.g.colors = {
  { name = "sonokai" },
  { name = "catppuccin-latte", background = "light" },
  { name = "Tomorrow-Night" },
  { name = "Monokai" },
  { name = "molokai" },
  { name = "github" },
  { name = "kalisi", background = "dark" },
  { name = "gruvbox", background = "dark" },
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
      local lsp_data = d.user_data and d.user_data.lsp
      local code = d.code or (lsp_data and lsp_data.code)
      local source = d.source or "unknown"
      if code then
        return ("%s (%s) [%s]"):format(d.message, source, code)
      end
      return ("%s (%s)"):format(d.message, source)
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
