-- Folder picker: browse directories with telescope-file-browser and open the
-- chosen one in neo-tree. Used by <leader>fd and the homecoming dashboard.
local M = {}

---@param opts? { position?: "left"|"right"|"float"|"current", start?: string }
function M.pick(opts)
  opts = opts or {}

  local function open_in_neotree(prompt_bufnr)
    local action_state = require("telescope.actions.state")
    local entry = action_state.get_selected_entry()
    local path = entry and entry.path or action_state.get_current_picker(prompt_bufnr).finder.path
    if vim.fn.isdirectory(path) == 0 then
      path = vim.fn.fnamemodify(path, ":h") -- a file was selected: use its folder
    end
    require("telescope.actions").close(prompt_bufnr)
    vim.cmd.cd(path) -- makes <C-p> / <C-g> search this folder too
    require("neo-tree.command").execute({
      dir = path,
      action = "focus",
      position = opts.position, -- "current" = open in the current window (replaces the dashboard)
    })
  end

  require("telescope").extensions.file_browser.file_browser({
    path = opts.start or "~/.config",
    files = false, -- folder browser: lists directories only
    hidden = true, -- show dot-folders
    attach_mappings = function(_, map)
      map({ "i", "n" }, "<A-n>", open_in_neotree)
      return true -- keep the default mappings
    end,
  })
end

return M
