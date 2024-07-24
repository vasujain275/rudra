-- Import rose-pine
local rose_pine = require 'rose-pine'

-- Configure rose-pine
rose_pine.setup {
  variant = 'auto', -- auto, main, moon, or dawn
  dark_variant = 'main', -- main, moon, or dawn
  dim_inactive_windows = false,
  extend_background_behind_borders = true,

  enable = {
    terminal = true,
    legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
    migrations = true, -- Handle deprecated options automatically
  },

  styles = {
    bold = true,
    italic = true,
    transparency = false,
  },

  groups = {
    border = 'muted',
    link = 'iris',
    panel = 'surface',

    error = 'love',
    hint = 'iris',
    info = 'foam',
    note = 'pine',
    todo = 'rose',
    warn = 'gold',

    git_add = 'foam',
    git_change = 'rose',
    git_delete = 'love',
    git_dirty = 'rose',
    git_ignore = 'muted',
    git_merge = 'iris',
    git_rename = 'pine',
    git_stage = 'iris',
    git_text = 'rose',
    git_untracked = 'subtle',

    h1 = 'iris',
    h2 = 'foam',
    h3 = 'rose',
    h4 = 'gold',
    h5 = 'pine',
    h6 = 'foam',
  },

  highlight_groups = {
    -- Comment = { fg = "foam" },
    -- VertSplit = { fg = "muted", bg = "muted" },
  },

  before_highlight = function(group, highlight, palette)
    -- Disable all undercurls
    -- if highlight.undercurl then
    --     highlight.undercurl = false
    -- end
    --
    -- Change palette colour
    -- if highlight.fg == palette.pine then
    --     highlight.fg = palette.foam
    -- end
  end,
}

-- Set colorscheme
vim.cmd 'colorscheme rose-pine'

-- Optionally, you can uncomment one of the following lines to use a specific variant:
-- vim.cmd("colorscheme rose-pine-main")
-- vim.cmd("colorscheme rose-pine-moon")
-- vim.cmd("colorscheme rose-pine-dawn")
