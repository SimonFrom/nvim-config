-- Language servers = linting/diagnostics (+ completion via blink.cmp)
--   Lua        -> lua_ls
--   Python     -> ruff (linter) + basedpyright (type checking)
--   TypeScript -> ts_ls (type errors) + eslint (only active if project has an eslint config)
--   C#/Razor   -> roslyn via roslyn.nvim (needs dotnet; handles .cs, .razor, .cshtml)
return {
  {
    "mason-org/mason.nvim",
    opts = {
      -- extra registry that ships the Roslyn server (incl. Razor/Blazor support)
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
    },
  },
  {
    -- C# + Razor/Blazor LSP (Roslyn with Razor co-hosting; replaces omnisharp)
    -- install the server once with :MasonInstall roslyn
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor", "cshtml" },
    dependencies = { "mason-org/mason.nvim" },
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig", -- provides default server configs
      "saghen/blink.cmp",
    },
    opts = {
      ensure_installed = { "lua_ls", "ruff", "basedpyright", "ts_ls", "eslint" },
      -- calls vim.lsp.enable() for installed servers; omnisharp would clash with roslyn
      automatic_enable = { exclude = { "omnisharp" } },
    },
    config = function(_, opts)
      -- Advertise blink.cmp completion capabilities to every server
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      -- Make lua_ls aware of the Neovim runtime (no "undefined global vim")
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = { vim.env.VIMRUNTIME }, checkThirdParty = false },
          },
        },
      })

      require("mason-lspconfig").setup(opts)

      -- Show diagnostics inline (off by default since Neovim 0.11)
      vim.diagnostic.config({
        virtual_text = true,
        severity_sort = true,
        float = { border = "rounded", source = true },
      })

      vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
    end,
  },
}
