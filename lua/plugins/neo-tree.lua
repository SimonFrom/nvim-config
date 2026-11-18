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
      {
        "<leader>of",
        function()
          -- focus the tree, then open its fuzzy search popup (same as "/" in the tree)
          vim.cmd("Neotree focus filesystem")
          -- press the tree's own "/" mapping once the tree buffer is ready
          vim.schedule(function()
            if vim.bo.filetype == "neo-tree" then
              vim.api.nvim_feedkeys("/", "m", false)
            end
          end)
        end,
        desc = "Search files in file explorer",
      },
    },
    opts = {
      filesystem = {
        window = {
          fuzzy_finder_mappings = {
            -- Enter: open the selected file, clear the search, close the popup.
            -- The tree stays open. On a folder it just jumps to it in the tree.
            ["<cr>"] = function(state)
              local node = state.tree:get_node()
              if not node then
                return
              end
              require("neo-tree.ui.renderer").position.set(state, node:get_id())
              -- clearing the search restores the folders that were open before it;
              -- add every folder down to the selected item so it ends up unfolded
              local open = state.open_folders_before_search or {}
              local dir = vim.fs.dirname(node.path)
              while dir and #dir >= #state.path do
                if not vim.tbl_contains(open, dir) then
                  table.insert(open, dir)
                end
                dir = vim.fs.dirname(dir)
              end
              state.open_folders_before_search = open
              -- run neo-tree's built-in "close_clear_filter" (mapped to <C-CR>):
              -- unmounts the popup properly and resets the search
              vim.api.nvim_feedkeys(vim.keycode("<C-CR>"), "m", false)
              if node.type == "file" then
                local path = node.path
                vim.schedule(function()
                  require("neo-tree.utils").open_file(state, path)
                  -- put the tree's cursor on the file (focus stays in the editor)
                  vim.defer_fn(function()
                    pcall(require("neo-tree.ui.renderer").focus_node, state, path, true)
                  end, 100)
                end)
              end
            end,
          },
        },
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
