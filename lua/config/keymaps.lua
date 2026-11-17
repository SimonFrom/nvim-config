local map = vim.keymap.set

-- general
map("n", "<leader>w", ":write<CR>", { desc = "Save file" })
map("n", "<leader>å", ":update<CR> :source<CR>", { desc = "Update config" })
map("n", "<leader>q", ":quit<CR>", { desc = "Quit" })

-- commenting (uses Neovim's built-in gc)
map("n", "<leader>kc", "gcc", { remap = true, desc = "Comment line" })
map("x", "<leader>kc", "gc", { remap = true, desc = "Comment selection" })
map("n", "<C-/>", "gcc", { remap = true, desc = "Comment line" })
map("x", "<C-/>", "gc", { remap = true, desc = "Comment selection" })

-- formatting
map("v", "<", "<gv", { desc = "Indent left" })
map("i", "<Tab>", "<C-t>", { desc = "Indent right" })
map("v", ">", ">gv", { desc = "Indent right" })
map("n", "<leader>ld", "yyp", { desc = "Copy line down" })
map("i", "<C-Del>", '<C-o>"_dw', { desc = "Delete word forward" })

-- navigation
map("n", "<A-Down>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-Up>", ":m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
map("n", "<C-Up>", "<C-u>zz", { desc = "Scroll up and center" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-Down>", "<C-d>zz", { desc = "Scroll down and center" })

-- search: while matches are highlighted (after / or ?), arrows jump between
-- matches and Enter stops there and clears the highlight. Otherwise normal.
local function searching()
  return vim.v.hlsearch == 1 and vim.bo.buftype ~= "quickfix"
end
for _, key in ipairs({ "<Down>", "<Right>" }) do
  map("n", key, function() return searching() and "nzz" or key end, { expr = true, desc = "Next match / move" })
end
for _, key in ipairs({ "<Up>", "<Left>" }) do
  map("n", key, function() return searching() and "Nzz" or key end, { expr = true, desc = "Previous match / move" })
end
map("n", "<CR>", function()
  return searching() and "<Cmd>nohlsearch<CR>" or "<CR>"
end, { expr = true, desc = "Stop at match and clear highlight" })

-- same while still typing the search: Up/Down step through matches live,
-- Enter jumps to the current one and clears the highlight (Esc cancels)
local function in_search() return vim.fn.getcmdtype():match("[/?]") ~= nil end
map("c", "<Down>", function() return in_search() and "<C-g>" or "<Down>" end, { expr = true })
map("c", "<Up>", function() return in_search() and "<C-t>" or "<Up>" end, { expr = true })
map("c", "<CR>", function()
  return in_search() and "<CR><Cmd>nohlsearch<CR>" or "<CR>"
end, { expr = true })

-- tabs
map("n", "<leader>nt", ":tabnew<CR>", { desc = "New tab" })
