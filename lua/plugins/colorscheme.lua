-- Kanagawa
return {
  "rebelot/kanagawa.nvim",
  lazy = false, -- load at startup, not on demand
  priority = 1000, -- load before other plugins so their highlights use these colors
  opts = {
    transparent = true, -- same as catppuccin's transparent_background
    theme = "wave", -- "wave" (default), "dragon" (darker) or "lotus" (light)
    overrides = function(colors)
      local palette = colors.palette
      return {
        -- same idea as your catppuccin custom_highlights
        LineNr = { fg = palette.fujiGray },
        CursorLineNr = { fg = palette.surimiOrange, bold = true },
        -- transparent floating windows, like your catppuccin float settings
        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        Comment = { fg = "#57F287", italic = true },
        ["@comment"] = { link = "Comment" }, -- treesitter comments use the same style
      }
    end,
  },
  config = function(_, opts)
    require("kanagawa").setup(opts)
    vim.cmd.colorscheme("kanagawa")
  end,
}

-- Catppuccin
-- return {
--   "catppuccin/nvim",
--   name = "catppuccin",
--   lazy = false,
--   priority = 1000,
--   opts = {
--     transparent_background = true, -- disables setting the background color.
--     float = {
--       transparent = true, -- enable transparent floating windows
--       solid = false, -- use solid styling for floating windows, see |winborder|
--     },
--     custom_highlights = function(colors)
--       return {
--         LineNr = { fg = colors.overlay1 }, -- other line numbers
--         CursorLineNr = { fg = colors.peach, style = { "bold" } }, -- current line number
--       }
--     end,
--   },
--   config = function(_, opts)
--     require("catppuccin").setup(opts)
--     vim.cmd.colorscheme("catppuccin")
--   end,
-- }
