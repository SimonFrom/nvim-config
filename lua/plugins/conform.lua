-- Formatters (installed via :Mason)
--   Lua        -> stylua
--   Python     -> ruff (organize imports + format)
--   TypeScript -> prettier (needs npm)
--   C#         -> csharpier
return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>lf",
        function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_organize_imports", "ruff_format" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        cs = { "csharpier" },
      },
      formatters = {
        -- match your 2-space indent (stylua defaults to tabs)
        stylua = { prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" } },
      },
      -- Format on save; fall back to the LSP formatter if no tool is available
      format_on_save = { timeout_ms = 1000, lsp_format = "fallback" },
    },
  },
}
