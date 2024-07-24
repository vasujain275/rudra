local conform = require 'conform'

-- Setup conform.nvim
conform.setup {
  formatters_by_ft = {
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    javascriptreact = { 'prettier' },
    typescriptreact = { 'prettier' },
    svelte = { 'prettier' },
    css = { 'prettier' },
    html = { 'prettier' },
    json = { 'prettier' },
    yaml = { 'prettier' },
    markdown = { 'prettier' },
    graphql = { 'prettier' },
    liquid = { 'prettier' },
    lua = { 'stylua' },
    python = { 'isort', 'black' },
  },
  format_on_save = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  },
}

-- Keybinding for manual formatting
vim.keymap.set({ 'n', 'v' }, '<leader>mp', function()
  conform.format {
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  }
end, { desc = 'Format file or range (in visual mode)' })

-- Event handling for BufReadPre and BufNewFile
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  callback = function()
    -- This is where you can add any additional setup or configuration if needed
  end,
})
