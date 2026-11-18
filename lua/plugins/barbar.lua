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
  opts = {
    icons = {
      button = false, -- no close (x) button; modified buffers still show ●
      -- slanted ends: each tab is a parallelogram leaning right  / tab /
      separator = { left = "\u{e0ba}", right = "\u{e0bc}" },
      inactive = { separator = { left = "\u{e0ba}", right = "\u{e0bc}" } },
      separator_at_end = false,
    },
  },
  config = function(_, opts)
    require("barbar").setup(opts)

    -- Tab colors. The slant glyphs are drawn in the tab's own background color
    -- on a transparent bg, so they work with the transparent colorscheme.
    -- Neutral greys so colored file icons stay visible; the active tab is marked
    -- by brighter bg, bright yellow text and a yellow underline ("border").
    local accent = "#FFD866"
    local colors = {
      Current = { bg = "#3E3D45", fg = accent, bold = true, underline = accent },
      Visible = { bg = "#2F2E35" },
      Alternate = { bg = "#26252B" },
      Inactive = { bg = "#26252B" },
    }
    local parts = {
      "", "Mod", "Index", "Number", "Icon", "Target", "Pin", "Btn", "ModBtn", "PinBtn",
      "ADDED", "CHANGED", "DELETED", "ERROR", "WARN", "INFO", "HINT",
    }
    local function apply()
      for state, c in pairs(colors) do
        for _, part in ipairs(parts) do
          local name = "Buffer" .. state .. part
          local cur = vim.api.nvim_get_hl(0, { name = name, link = false })
          local fg = (part == "" and c.fg) or cur.fg
          vim.api.nvim_set_hl(0, name, {
            fg = fg,
            bg = c.bg,
            bold = c.bold and part == "",
            underline = c.underline ~= nil,
            sp = c.underline,
          })
        end
        for _, sign in ipairs({ "Sign", "SignRight" }) do
          vim.api.nvim_set_hl(0, "Buffer" .. state .. sign, {
            fg = c.bg,
            bg = "NONE",
            underline = c.underline ~= nil,
            sp = c.underline,
          })
        end
      end
      -- barbar caches a colored copy of each file icon (e.g. DevIconLuaCurrent)
      -- with the old tab bg; rebuild them so the icon sits on the new bg
      require("barbar.utils.highlight").reset_cache() -- barbar caches colors too
      require("barbar.icons").set_highlights()
    end
    apply()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = apply })

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
