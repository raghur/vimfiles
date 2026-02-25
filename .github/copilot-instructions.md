# Neovim Configuration — Copilot Instructions

## Architecture

This is a personal Neovim config built around **lazy.nvim** for plugin management. The entry point is `init.lua`, which loads modules in this order: `settings` → `commands` → lazy.nvim setup → `mappings`.

### Directory layout

| Path | Purpose |
|------|---------|
| `lua/settings.lua` | All `vim.opt` settings and global state (colors, fonts, diagnostics) |
| `lua/commands.lua` | Vim commands and autocommands (vimscript wrapped in `vim.cmd`) |
| `lua/mappings.lua` | All keymaps registered via `which-key` |
| `lua/plugins/` | lazy.nvim plugin specs, split by category (`lsp.lua`, `completion.lua`, `themes.lua`, `treesitter.lua`, `which-key.lua`, `plugins.lua`) |
| `lua/raghu/` | Per-plugin configuration modules (see convention below) |
| `after/ftplugin/` | Filetype-specific settings (Lua, Neorg, AsciiDoc) |
| `autoload/utils.vim` | Vimscript utility functions (`utils#createIfNotExists`, `utils#loglvl`, etc.) |
| `snippets/` | LuaSnip snippets in snipmate format |

## Key Conventions

### Plugin configuration pattern

When a plugin spec uses `config = require("raghu").configurePlugin`, the framework:
1. Runs the plugin's default `setup(opts)` if opts are present
2. Then looks for a module at `lua/raghu/<plugin-name>.lua` (dots in plugin name replaced by dashes) and calls its `.config()` function

To add custom config for a plugin named `foo.nvim`, create `lua/raghu/foo-nvim.lua` exporting `M.config = function() ... end`.

### Keymaps

All keymaps go through `which-key` using `wk.add(mappings)` in `lua/mappings.lua`. Each entry is a table with `{ "<keys>", action, desc = "...", mode = "..." }`.

- **Leader**: `<Space>`
- **LocalLeader**: `\`
- `jk` → `<Esc>` in insert mode
- Arrow keys are disabled in normal/insert/visual modes
- `c`/`C` do not yank (use black-hole register `"_`)

### LSP keymaps (all under `g` prefix)

| Key | Action |
|-----|--------|
| `gd` | Go to definition (snacks picker) |
| `gr` | References |
| `gs` | Document symbols |
| `gt` | Workspace symbols |
| `gl` | LSP finder (lspsaga) |
| `g.` | Code actions |
| `gc` | Rename |
| `gq` | Format buffer |
| `g[` / `g]` | Previous / next diagnostic |
| `gk` | Show line diagnostic float |
| `go` | Outline |

### File/buffer navigation (snacks.picker)

| Key | Action |
|-----|--------|
| `<leader><space>` | Smart file find (hidden) |
| `<leader>ff` | Find files relative |
| `<leader>/` | Grep |
| `<leader>b` | Buffers |
| `<leader>r` | Recent files |
| `<F1>` | Reveal current file in explorer |
| `<leader><F1>` | Toggle file explorer |
| `tg` | LazyGit |
| `tt` | Terminal (right split) |

### Logging

Enable logging at runtime with the `NVIM_LOG` environment variable:
- `NVIM_LOG=1 nvim` — debug level
- `NVIM_LOG=2 nvim` — info level

Global helpers `Info(...)` and `Dbg(...)` are available everywhere (set in `init.lua`).

### Config reload

`<leader>ir` reloads `mappings.lua`, `settings.lua`, and `commands.lua` without restarting Neovim. Individual files can be sourced with `<leader>i,`.

## Plugin Stack

| Category | Plugin |
|----------|--------|
| Package manager | lazy.nvim |
| LSP | nvim-lspconfig + mason + mason-lspconfig + lspsaga |
| Completion | nvim-cmp (active); blink.cmp spec exists but is commented out |
| Snippets | LuaSnip (snipmate format from `./snippets/`) |
| Formatting | conform.nvim (`stylua`, `black`/`isort`, `prettier`/`prettierd`, `jq`, `beautysh`) |
| Finder/Explorer | snacks.nvim (picker replaces telescope; explorer replaces netrw) |
| Surround | mini.surround — `ys`/`ds`/`cs` mappings |
| Folding | nvim-ufo — `zR`/`zM` to open/close all folds |
| Notes | Neorg — workspace at `~/Sync/scratch/`, open with `<leader>e` |
| Session | vim-session |
| Git | snacks.lazygit + snacks.picker git pickers |

## Completion Notes

The config has two completion engines. `nvim-cmp` is currently active (`plugin = cmp` at the bottom of `lua/plugins/completion.lua`). Switching to blink.cmp requires changing that line to `plugin = blink`. Both specs are fully configured in that file.

## GUI / Neovide

`lua/settings.lua` includes Neovide-specific settings under `if vim.g.neovide`. Font cycling is available via `<M-[>`/`<M-]>` and size adjustment via `<M-=>`/`<M-->`.
