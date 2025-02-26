return {
  {
    'saghen/blink.cmp',
    version = '*', -- Use a release tag (or build from source if needed)
    dependencies = {
      -- Optional: Provides snippet support (uses premade snippets)
      'rafamadriz/friendly-snippets',
      {
        'L3MON4D3/LuaSnip',
        name = 'luasnip',
        build = require('nixCatsUtils').lazyAdd((function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)()),
      },
    },
    opts = {
      -- Configure keymaps using Blink's special schema.
      keymap = {
        preset = 'default', -- Base mapping preset; your custom keys will merge with it.
        -- Custom mappings replicating your nvim-cmp configuration:
        ['<C-n>'] = { 'select_next', 'fallback' }, -- Next completion item
        ['<C-p>'] = { 'select_prev', 'fallback' }, -- Previous completion item
        ['<C-b>'] = {
          function(cmp)
            cmp.scroll_documentation_up(4)
          end,
          'fallback',
        }, -- Scroll docs up
        ['<C-f>'] = {
          function(cmp)
            cmp.scroll_documentation_down(4)
          end,
          'fallback',
        }, -- Scroll docs down
        ['<C-y>'] = { 'select_and_accept', 'fallback' }, -- Accept selected (or first) item
        ['<C-Space>'] = { 'show', 'fallback' }, -- Manually trigger the completion menu
        ['<C-l>'] = { 'snippet_forward', 'fallback' }, -- Expand snippet or jump to next placeholder
        ['<C-h>'] = { 'snippet_backward', 'fallback' }, -- Jump backwards in snippet placeholders

        -- Optional extra mappings (uncomment if you’d like to try them):
        -- ['<Up>'] = { 'select_prev', 'fallback' },         -- Use Up arrow for previous item
        -- ['<Down>'] = { 'select_next', 'fallback' },       -- Use Down arrow for next item
        ['<C-e>'] = {}, -- Disable <C-e> if you don't need it
        -- cmdline = {                                      -- Example cmdline mapping:
        --   ['<CR>'] = { 'accept_and_enter', 'fallback' },  -- Accept item and execute command in cmdline mode
        -- },
      },
      appearance = {
        use_nvim_cmp_as_default = true, -- Use nvim-cmp's highlight groups as fallback
        nerd_font_variant = 'mono', -- Adjust icon spacing for Nerd Font Mono
      },
      -- Define the default completion sources: LSP, file paths, snippets, and buffer text.
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
    -- Ensures that if you extend the default sources elsewhere they are merged.
    opts_extend = { 'sources.default' },
  },
}
