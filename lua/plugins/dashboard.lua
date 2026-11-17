return {
  {
    "leo-alvarenga/homecoming.nvim",
    lazy = false, -- important, see note below
    opts = {
      header_centered = true,
      header_hl_group = "Title",
      header_mb = 2,
      header = {
        " _   _            _   _ _",
        "| \\ | |          | | | (_)",
        "|  \\| | ___  ___ | | | |_ _ __ ___",
        "| . ` |/ _ \\/ _ \\| | | | | '_ ` _ \\",
        "| |\\  |  __/ (_) \\ \\_/ / | | | | | |",
        "\\_| \\_/\\___|\\___/ \\___/|_|_| |_| |_|",
      },

      item_gap = 0,
      item_hl_group = "Comment",
      item_selected_hl_group = "Normal",
      item_indent = 2,
      item_prefix_char = "",
      section_anchor = "header_half",
      sections = {
        {
          title = "> Files",
          items = {
            {
              label = " New file",
              action = function()
                vim.ui.input({ prompt = "Name: ", completion = "file" }, function(input)
                  if input == nil or input == "" then
                    return -- do nothing
                  end
                  vim.cmd.edit(vim.fn.fnameescape(input))
                end)
              end,
            },
            { label = " Find files", action = "Telescope file_browser" },
            {
              label = " Open folder",
              action = function()
                require("config.pick_dir").pick({ position = "current" })
              end,
            },
            { label = " Find text", action = "Telescope live_grep" },
            -- { label = " Apps", action = "Telescope app" },
          },
        },
        {
          title = "> Plugins",
          items = {
            { label = "󰊳 Update", action = "Lazy update" },
          },
        },
        {
          title = "> Exit",
          items = {
            { label = " Quit NeoVim", action = "qa" },
          },
        },
      },
      -- header = { "line 1", "line 2", ... },  -- optional ASCII art
      -- footer = "whatever you like",          -- or a function returning string/string[]
    },
  },
}
