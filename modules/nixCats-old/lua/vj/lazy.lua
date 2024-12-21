-- NOTE:
-- list of nix installed plugins lazy should look for rather than download
-- can be grabbed straight from require('nixCats').pawsible.allPlugins.{ start, opt }
local pluginList = {}
local lazypath = nil -- require('nixCats').pawsible.allPlugins.start["lazy.nvim"]
require('nixCatsUtils.lazyCat').setup(pluginList, lazypath,{ { import = 'vj.plugins' } }, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
