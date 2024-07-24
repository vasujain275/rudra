-- Import lazygit.nvim
local lazygit = require 'lazygit'

-- Set up lazygit.nvim with commands and keybindings
vim.api.nvim_create_user_command('LazyGit', function()
  lazygit.launch()
end, {})
vim.api.nvim_create_user_command('LazyGitConfig', function()
  lazygit.config()
end, {})
vim.api.nvim_create_user_command('LazyGitCurrentFile', function()
  lazygit.current_file()
end, {})
vim.api.nvim_create_user_command('LazyGitFilter', function()
  lazygit.filter()
end, {})
vim.api.nvim_create_user_command('LazyGitFilterCurrentFile', function()
  lazygit.filter_current_file()
end, {})

-- Keybinding for LazyGit
vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<cr>', { desc = 'Open lazy git' })

-- Ensure plenary.nvim dependency is loaded
require 'plenary'
