-- Which Key configuration
local which_key = require 'which-key'

-- Setup Which Key
which_key.setup()

-- Document existing key chains
which_key.register {
  ['c'] = { name = '[C]ode' },
  ['d'] = { name = '[D]ocument' },
  ['r'] = { name = '[R]ename' },
  ['s'] = { name = '[S]earch' },
  ['w'] = { name = '[W]orkspace' },
  ['t'] = { name = '[T]oggle' },
  ['h'] = { name = 'Git [H]unk', mode = { 'n', 'v' } },
}
