-- Import the mini.nvim plugins
local mini_ai = require 'mini.ai'
local mini_surround = require 'mini.surround'
local mini_statusline = require 'mini.statusline'

-- Configure mini.ai for better Around/Inside textobjects
mini_ai.setup { n_lines = 500 }

-- Configure mini.surround for add/delete/replace surroundings
mini_surround.setup()

-- Configure mini.statusline for a simple and easy statusline
mini_statusline.setup()

-- Optional: Load other modules from mini.nvim as needed
-- Example:
-- local mini_trailspace = require('mini.trailspace')
-- mini_trailspace.setup()

-- Check out more at: https://github.com/echasnovski/mini.nvim
