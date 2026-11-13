vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.number = true
opt.relativenumber = false
opt.wrap = false
opt.swapfile = false
opt.cursorline = true
opt.termguicolors = true
opt.scrolloff = 25
opt.autoread = true
opt.signcolumn = "yes"
opt.clipboard:append("unnamedplus")
