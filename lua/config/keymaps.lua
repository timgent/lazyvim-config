-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Exit insert mode with jk or kj (case insensitive)
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "kj", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "JK", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "Jk", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "jK", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "KJ", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "Kj", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "kJ", "<Esc>", { desc = "Exit insert mode" })

-- Copy relative file path
vim.keymap.set("n", "<leader>yp", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", path)
  vim.notify("Copied relative path: " .. path)
end, { desc = "Yank relative file path" })

-- Copy absolute file path
vim.keymap.set("n", "<leader>yP", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied absolute path: " .. path)
end, { desc = "Yank absolute file path" })
