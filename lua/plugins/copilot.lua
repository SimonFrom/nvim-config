return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      -- Inline ghost-text suggestions (like VS Code)
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          -- Tab is taken by blink.cmp's super-tab preset, so use Alt keys
          accept = "<M-l>", -- accept whole suggestion
          accept_word = "<M-w>", -- accept next word
          accept_line = "<M-j>", -- accept next line
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        gitcommit = true,
        yaml = true,
        help = false,
        ["."] = false,
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)

      -- Ctrl+Right: accept next word of the suggestion if one is visible,
      -- otherwise behave like a normal Ctrl+Right (jump a word)
      vim.keymap.set("i", "<C-Right>", function()
        local suggestion = require("copilot.suggestion")
        if suggestion.is_visible() then
          suggestion.accept_word()
        else
          vim.api.nvim_feedkeys(vim.keycode("<C-Right>"), "n", false)
        end
      end, { desc = "Copilot: accept word" })
    end,
  },
}
