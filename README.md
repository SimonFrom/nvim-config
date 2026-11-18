<div align="center">

# ✨ nvim config

My personal Neovim setup: Kanagawa colors, LSP for Lua · Python · TypeScript · C#,
Copilot, and a file tree you can actually search.

![Neovim](https://img.shields.io/badge/Neovim-0.12+-57A143?style=flat-square&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/Made%20with-Lua-2C2D72?style=flat-square&logo=lua&logoColor=white)
![lazy.nvim](https://img.shields.io/badge/plugins-lazy.nvim-E6C384?style=flat-square)

</div>

---

## 📦 Install

```sh
# back up any existing config first
mv ~/.config/nvim ~/.config/nvim.bak

git clone https://github.com/SimonFrom/nvim-config.git ~/.config/nvim
nvim   # lazy.nvim installs every plugin on first launch
```

**Needs:** Neovim 0.12+, `git`, `make` (for telescope-fzf-native), a [Nerd Font](https://www.nerdfonts.com/)
(I use JetBrainsMono Nerd Font), Node.js (Copilot, TypeScript) and `dotnet` for C#.
Language servers and formatters are installed with `:Mason`. For C#, run `:MasonInstall roslyn` once.

---

## 🧩 Plugins

| Plugin | What it does |
| --- | --- |
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) | Colorscheme (dragon, transparent) |
| [homecoming.nvim](https://github.com/leo-alvarenga/homecoming.nvim) | Start screen / dashboard |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status line |
| [barbar.nvim](https://github.com/romgrk/barbar.nvim) | Buffer tabs (slanted, neutral colors) |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File tree |
| [nvim-file-operations](https://github.com/Crysthamus/nvim-file-operations) | LSP-aware rename / move from the file tree |
| [nvim-window-picker](https://github.com/s1n7ax/nvim-window-picker) | Pick which window a file opens in |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder for files, text, buffers |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | Faster sorting for Telescope |
| [telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim) | File / folder browser in Telescope |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting and indenting |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Language server configs |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | Installs language servers and formatters |
| [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim) | Starts installed language servers automatically |
| [roslyn.nvim](https://github.com/seblyng/roslyn.nvim) | C# / Razor language server |
| [blink.cmp](https://github.com/saghen/blink.cmp) | Autocompletion |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Snippet collection for blink.cmp |
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | GitHub Copilot inline suggestions |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatting (and format on save) |
| [mini.pairs](https://github.com/nvim-mini/mini.pairs) | Auto-close brackets and quotes |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git changes in the sign column, hunk actions |
| [neogit](https://github.com/NeogitOrg/neogit) | Git interface (status, commit, push) |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim) | Side-by-side diffs and file history |
| [love2d.nvim](https://github.com/S1M0N38/love2d.nvim) | Run LÖVE games from Neovim |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Popup that shows available keys |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File icons |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Lua helper library (dependency) |
| [nui.nvim](https://github.com/MunifTanjim/nui.nvim) | UI components (dependency) |

---

## ⌨️ Keybinds

**Leader key is <kbd>Space</kbd>.** Modes: `n` normal · `v` visual · `i` insert · `c` command line.

> 🔎 **To search:** press <kbd>Ctrl</kbd>+<kbd>F</kbd> and type a word like `save` or a key like `<leader>w`.
> Chrome, Edge and Firefox open the collapsed section that contains the match automatically.
> Inside Neovim, <kbd>Space</kbd> <kbd>?</kbd> shows every keybind too.

<details>
<summary><b>⚙️ General</b></summary>

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>w` | n | Save file |
| `<leader>q` | n | Quit |
| `<leader>å` | n | Save and reload the current config file |
| `<leader>nt` | n | New tab |
| `<leader>kc` | n / v | Comment line / selection |
| `<C-/>` | n / v | Comment line / selection |
| `<` / `>` | v | Indent left / right (keeps the selection) |
| `<Tab>` | i | Indent right |
| `<leader>ld` | n | Copy (duplicate) line down |
| `<C-Del>` | i | Delete word forward |
| `<A-Down>` / `<A-Up>` | n / v | Move line or selection down / up |
| `<C-d>` / `<C-Down>` | n | Scroll down half a page and center |
| `<C-u>` / `<C-Up>` | n | Scroll up half a page and center |

</details>

<details>
<summary><b>🔍 Search (built-in <code>/</code>)</b></summary>

| Key | Mode | Action |
| --- | --- | --- |
| `<Down>` / `<Up>` | c | While typing a `/` search: jump to next / previous match |
| `<CR>` | c | Go to the current match and clear the highlight |
| `<Esc>` | c | Cancel the search and go back |
| `<Down>` / `<Right>` | n | While matches are highlighted: next match |
| `<Up>` / `<Left>` | n | While matches are highlighted: previous match |
| `<CR>` | n | Stop at the match and clear the highlight |

</details>

<details>
<summary><b>🧠 LSP (code navigation)</b></summary>

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>df` | n | Go to definition (class, method, function) |
| `<C-]>` | n | Go to definition (built-in) |
| `<C-o>` / `<C-i>` | n | Jump back / forward |
| `grr` | n | List references |
| `gri` | n | Go to implementation |
| `grt` | n | Go to type definition |
| `grn` | n | Rename symbol |
| `gra` / `<leader>ca` | n | Code action |
| `gO` | n | Outline of the current file (classes, methods) |
| `K` | n | Hover documentation |
| `<leader>cd` | n | Show diagnostics for the line |

</details>

<details>
<summary><b>🌳 neo-tree (file tree)</b></summary>

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>e` | n | Toggle file tree |
| `<leader>o` | n | Switch focus between code and file tree |
| `<leader>of` | n | Focus the tree and search for a file |
| `/` | n (in tree) | Search for a file in the tree |
| `<Down>` / `<Up>` | i (in search) | Move between results |
| `<CR>` | i (in search) | Open file, clear search, unfold its folder |
| `<Esc>` | i (in search) | Cancel the search |

</details>

<details>
<summary><b>🔭 Telescope</b></summary>

| Key | Mode | Action |
| --- | --- | --- |
| `<C-p>` | n | Find files |
| `<C-g>` | n | Search text in files (live grep) |
| `<leader>fb` | n | Open buffers |
| `<leader>fh` | n | Search help |
| `<leader>fe` | n | File browser |
| `<leader>fd` | n | Pick a folder and open it in neo-tree |
| `<A-n>` | i / n (folder picker) | Open the selected folder in neo-tree |

</details>

<details>
<summary><b>📑 barbar (buffer tabs)</b></summary>

| Key | Mode | Action |
| --- | --- | --- |
| `<A-,>` / `<A-.>` | n | Previous / next buffer |
| `<A-<>` / `<A->>` | n | Move buffer left / right |
| `<A-1>` … `<A-9>` | n | Go to buffer 1–9 |
| `<A-0>` | n | Go to last buffer |
| `<A-q>` | n | Close buffer |

</details>

<details>
<summary><b>💬 blink.cmp (completion)</b></summary>

| Key | Mode | Action |
| --- | --- | --- |
| `<CR>` | i | Accept completion |
| `<Tab>` | i | Accept Copilot suggestion, else jump to next snippet field, else insert tab |
| `<C-space>` | i | Open menu / show docs |
| `<C-n>` / `<C-p>` / `<Down>` / `<Up>` | i | Next / previous item |
| `<C-e>` | i | Close menu |
| `<C-k>` | i | Toggle signature help |

</details>

<details>
<summary><b>🤖 Copilot</b></summary>

| Key | Mode | Action |
| --- | --- | --- |
| `<Tab>` / `<M-l>` | i | Accept whole suggestion |
| `<M-w>` / `<C-Right>` | i | Accept next word |
| `<M-j>` | i | Accept next line |
| `<M-]>` / `<M-[>` | i | Next / previous suggestion |
| `<C-]>` | i | Dismiss suggestion |

</details>

<details>
<summary><b>✨ conform (formatting)</b></summary>

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>lf` | n / v | Format buffer / selection |
| *(on save)* | — | Files are formatted automatically when saved |

</details>

<details>
<summary><b>🌿 Git (gitsigns, neogit, diffview)</b></summary>

| Key | Mode | Action |
| --- | --- | --- |
| `]h` / `[h` | n | Next / previous change (hunk) |
| `<leader>hs` | n | Stage hunk |
| `<leader>hr` | n | Reset hunk |
| `<leader>hp` | n | Preview hunk |
| `<leader>hb` | n | Blame line |
| `<leader>hd` | n | Diff this file |
| `<leader>gg` | n | Neogit status |
| `<leader>gc` | n | Git commit |
| `<leader>gd` | n | Open diff view |
| `<leader>gh` | n | File history |

</details>

<details>
<summary><b>🎮 love2d (LÖVE games)</b></summary>

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>vr` | n | Run game |
| `<leader>vw` | n | Watch (rerun on save) |
| `<leader>vs` | n | Stop game |
| `<leader>vo` | n | Output panel |
| `<leader>vi` | n | Info |

</details>

<details>
<summary><b>❓ which-key</b></summary>

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>?` | n | Show all keymaps |

</details>

---

## 📁 Layout

```
init.lua              entry point
lua/config/           options, keymaps, autocmds, lazy.nvim bootstrap
lua/plugins/          one file per plugin (or group of plugins)
lazy-lock.json        pinned plugin versions
```
