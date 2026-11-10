return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      -- Inline ghost-text suggestions (like VS Code)
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          -- Tab is taken by blink.cmp's super-tab preset, so use Alt keys
          accept = '<M-l>',      -- accept whole suggestion
          accept_word = '<M-w>', -- accept next word
          accept_line = '<M-j>', -- accept next line
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        gitcommit = true,
        yaml = true,
        help = false,
        ['.'] = false,
      },
    },
  },
}
