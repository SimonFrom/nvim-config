return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
      {
        "<leader>o",
        function()
          if vim.bo.filetype == "neo-tree" then
            vim.cmd("wincmd p") -- back to the previous (code) window
          else
            vim.cmd("Neotree focus")
          end
        end,
        desc = "Toggle focus: code <-> file explorer",
      },
    },
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,          -- show hidden items (dimmed) instead of hiding them
          hide_dotfiles = false,   -- show .dotfiles
          hide_gitignored = false, -- show gitignored files
          hide_hidden = true,     -- show hidden files (Windows attribute)
        },
      },
    },
  },
  {
    "Crysthamus/nvim-file-operations",
    -- branch = "compat" -- if you are on Neovim <= 0.10
    dependencies = {
      "nvim-neo-tree/neo-tree.nvim", -- makes sure that this loads after Neo-tree.
    },
    config = function()
      require("nvim-file-operations").setup()
    end,
  },
  {
    "s1n7ax/nvim-window-picker",
    version = "2.*",
    config = function()
      require("window-picker").setup({
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "neo-tree", "neo-tree-popup", "notify" },
            -- if the buffer type is one of following, the window will be ignored
            buftype = { "terminal", "quickfix" },
          },
        },
      })
    end,
  },
}
