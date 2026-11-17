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
          require("config.pick_dir").pick()
        end,
        desc = "Pick a directory and open it in neo-tree",
      },
    },
    config = function()
      require("telescope").load_extension("file_browser")
    end,
  },
}
