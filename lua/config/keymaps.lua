local map = vim.keymap.set

-- general
map("n", "<leader>w", ":write<CR>", { desc = "Save file" })
map("n", "<leader>å", ":update<CR> :source<CR>", { desc = "Update config" })
map("n", "<leader>q", ":quit<CR>", { desc = "Quit" })

-- formatting
map("v", "<", "<gv", { desc = "Indent left" })
map("i", "<Tab>", "<C-t>", { desc = "Indent right" })
map("v", ">", ">gv", { desc = "Indent right" })
map("n", "<leader>ld", "yyp", { desc = "Copy line down" })
map("n", "<C-c>", "y", { desc = "Copy" })
map("i", "<C-c>", "y", { desc = "Copy" })
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

-- tabs
map("n", "<leader>nt", ":tabnew<CR>", { desc = "New tab" })
