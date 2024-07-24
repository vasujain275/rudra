-- Import nvim-autopairs
local autopairs = require 'nvim-autopairs'

-- Configure autopairs
autopairs.setup {
  check_ts = true, -- enable treesitter
  ts_config = {
    lua = { 'string' }, -- don't add pairs in lua string treesitter nodes
    javascript = { 'template_string' }, -- don't add pairs in javscript template_string treesitter nodes
    java = false, -- don't check treesitter on java
  },
}

-- Import nvim-autopairs completion functionality
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

-- Import nvim-cmp plugin (completions plugin)
local cmp = require 'cmp'

-- Make autopairs and completion work together
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

-- Event handling for InsertEnter
vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
  callback = function()
    -- This is where you can add any additional setup or configuration if needed
  end,
})
