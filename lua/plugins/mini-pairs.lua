return {
  {
    "nvim-mini/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
    },
    -- lazy.nvim calls require("mini.pairs").setup(opts) automatically
  },
}
