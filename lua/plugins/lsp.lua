-- Language servers = linting/diagnostics (+ completion via blink.cmp)
--   Lua        -> lua_ls
--   Python     -> ruff (linter) + basedpyright (type checking)
--   TypeScript -> ts_ls (type errors) + eslint (only active if project has an eslint config)
--   C#         -> omnisharp (needs dotnet)
return {
  {
    "mason-org/mason.nvim",
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
      ensure_installed = { "lua_ls", "ruff", "basedpyright", "ts_ls", "eslint", "omnisharp" },
      automatic_enable = true, -- calls vim.lsp.enable() for installed servers
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
