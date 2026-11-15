return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  -- telescope loads the first time one of these keys is pressed
  keys = {
    {
      "<C-p>",
      function()
        require("telescope.builtin").find_files()
      end,
      desc = "Telescope find files",
    },
    {
      "<C-g>",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Telescope live grep",
    },
    {
      "<leader>fb",
      function()
        require("telescope.builtin").buffers()
      end,
      desc = "Telescope buffers",
    },
    {
      "<leader>fh",
      function()
        require("telescope.builtin").help_tags()
      end,
      desc = "Telescope help tags",
    },
  },
  -- required to launch in the dashboard
  cmd = "Telescope",
  -- include hidden + gitignored files (but skip .git internals)
  opts = {
    defaults = {
      file_ignore_patterns = { "^%.git/", "/%.git/" },
    },
    pickers = {
      find_files = { hidden = true, no_ignore = true },
      live_grep = {
        additional_args = function()
          return { "--hidden", "--no-ignore" }
        end,
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      extensions = {
        file_browser = {
          theme = "ivy",
          hijack_netrw = false, -- neo-tree already handles netrw
          hidden = true, -- match your find_files setting
          mappings = {
            i = {},
            n = {},
          },
        },
      },
    },
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>fe", "<cmd>Telescope file_browser<cr>", desc = "Telescope file browser" },
      {
        "<leader>fd",
        function()
          local action_state = require("telescope.actions.state")
          local actions = require("telescope.actions")

          -- open the selected directory (or the folder you're currently in) in neo-tree
          local function open_in_neotree(prompt_bufnr)
            local entry = action_state.get_selected_entry()
            local path = entry and entry.path or action_state.get_current_picker(prompt_bufnr).finder.path
            if vim.fn.isdirectory(path) == 0 then
              path = vim.fn.fnamemodify(path, ":h") -- a file was selected: use its folder
            end
            actions.close(prompt_bufnr)
            vim.cmd.cd(path) -- optional: makes <C-p> / <C-g> search this folder too
            require("neo-tree.command").execute({ dir = path, action = "focus" })
          end

          require("telescope").extensions.file_browser.file_browser({
            path = "~/.config",
            files = false, -- folder browser: lists directories only
            hidden = true, -- show dot-folders
            attach_mappings = function(_, map)
              map({ "i", "n" }, "<A-n>", open_in_neotree)
              return true -- keep the default mappings
            end,
          })
        end,
        desc = "Pick a directory and open it in neo-tree",
      },
    },
    config = function()
      require("telescope").load_extension("file_browser")
    end,
  },
}
