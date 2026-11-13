return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    ts.setup({
      -- prepended to runtimepath so it has priority
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    ts.install({
      "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",
      "bash", "python", "javascript", "typescript", "json", "html", "css",
    })

    -- enable highlighting + indent for any filetype that has a parser
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        if pcall(vim.treesitter.start, args.buf) then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
