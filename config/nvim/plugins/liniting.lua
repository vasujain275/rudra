-- Import nvim-lint
local lint = require 'lint'

-- Configure linters by file type
lint.linters_by_ft = {
  javascript = { 'eslint' },
  typescript = { 'eslint' },
  javascriptreact = { 'eslint' },
  typescriptreact = { 'eslint' },
  svelte = { 'eslint' },
  python = { 'pylint' },
}

-- Create an augroup for linting
local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

-- Create autocommands for linting
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})

-- Keybinding for triggering linting manually
vim.keymap.set('n', '<leader>l', function()
  lint.try_lint()
end, { desc = 'Trigger linting for current file' })

-- Event handling for BufReadPre and BufNewFile
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  callback = function()
    -- This is where you can add any additional setup or configuration if needed
  end,
})
