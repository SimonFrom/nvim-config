return {
  "romgrk/barbar.nvim",
  version = "^1.0.0",
  lazy = false,
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {},
  config = function(_, opts)
    require("barbar").setup(opts)

    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
    end

    map("<A-,>", "<Cmd>BufferPrevious<CR>", "Previous buffer")
    map("<A-.>", "<Cmd>BufferNext<CR>", "Next buffer")
    map("<A-<>", "<Cmd>BufferMovePrevious<CR>", "Move buffer left")
    map("<A->>", "<Cmd>BufferMoveNext<CR>", "Move buffer right")
    for i = 1, 9 do
      map("<A-" .. i .. ">", "<Cmd>BufferGoto " .. i .. "<CR>", "Go to buffer " .. i)
    end
    map("<A-0>", "<Cmd>BufferLast<CR>", "Last buffer")
    map("<A-q>", "<Cmd>BufferClose<CR>", "Close buffer")
  end,
}
