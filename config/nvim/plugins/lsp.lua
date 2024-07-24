-- Import necessary plugins
local lspconfig = require 'lspconfig'
local fidget = require 'fidget'
local cmp_nvim_lsp = require 'cmp_nvim_lsp'

-- LSP servers and clients capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, cmp_nvim_lsp.default_capabilities())

-- Enable the following language servers
local servers = {
  clangd = {},
  rust_analyzer = {},
  biome = {},
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        workspace = {
          checkThirdParty = false,
          library = {
            '${3rd}/luv/library',
            unpack(vim.api.nvim_get_runtime_file('', true)),
          },
        },
      },
    },
  },
}

-- Setup each LSP server
for server, config in pairs(servers) do
  lspconfig[server].setup {
    settings = config.settings,
    filetypes = config.filetypes,
    capabilities = vim.tbl_deep_extend('force', capabilities, config.capabilities or {}),
  }
end

-- Setup fidget for LSP status updates
fidget.setup {}

-- Create an autocommand group for LSP-related key mappings and highlights
vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
  group = 'kickstart-lsp-attach',
  callback = function(event)
    local function map(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    map('K', vim.lsp.buf.hover, 'Hover Documentation')
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})
