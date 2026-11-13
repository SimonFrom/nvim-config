return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    transparent_background = true, -- disables setting the background color.
    float = {
      transparent = true, -- enable transparent floating windows
      solid = false, -- use solid styling for floating windows, see |winborder|
    },
    custom_highlights = function(colors)
      return {
        LineNr = { fg = colors.overlay1 }, -- other line numbers
        CursorLineNr = { fg = colors.peach, style = { "bold" } }, -- current line number
      }
    end,
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
