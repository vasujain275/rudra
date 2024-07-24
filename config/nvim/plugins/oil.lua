-- Import the oil.nvim plugin
local oil = require 'oil'

-- Configure oil.nvim
oil.setup {
  default_file_explorer = true,
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
    natural_order = true,
    is_always_hidden = function(name, _)
      return name == '..' or name == '.git'
    end,
  },
  win_options = {
    wrap = true,
  },
}

-- Set keymaps for oil.nvim
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open Parent Directory' })
vim.keymap.set('n', '<space>-', function()
  oil.toggle_float()
end, { desc = 'Open Parent Directory in floating Window' })

-- Optional: Ensure nvim-web-devicons is installed for icons
require 'nvim-web-devicons'
