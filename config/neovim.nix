{ pkgs, inputs, ... }:
let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
in
{
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      extraPackages = with pkgs; [
        lua-language-server
        gopls
        wl-clipboard
        luajitPackages.lua-lsp
        nil
        rust-analyzer
        yaml-language-server
        pyright
        marksman
      ];
      plugins = with pkgs.vimPlugins; [

        nvim-cmp 
        {
          plugin = nvim-cmp;
          config = toLuaFile ./nvim/plugin/autocomplete.lua;
        }
        cmp_luasnip
        cmp-nvim-lsp
        luasnip
        cmp-path
        friendly-snippets        

        {
          plugin = conform-nvim;
          config = toLuaFile ./nvim/plugin/autoformat.lua;
        }



        alpha-nvim
        auto-session
        bufferline-nvim
        dressing-nvim
        indent-blankline-nvim
        nui-nvim
        nvim-treesitter.withAllGrammars
        lualine-nvim
        nvim-autopairs
        nvim-web-devicons
        nvim-cmp
        nvim-surround
        nvim-lspconfig
        cmp-nvim-lsp
        cmp-buffer
        luasnip
        cmp_luasnip
        friendly-snippets
        lspkind-nvim
        comment-nvim
        nvim-ts-context-commentstring
        plenary-nvim
        neodev-nvim
        luasnip
        telescope-nvim
        todo-comments-nvim
        nvim-tree-lua
        telescope-fzf-native-nvim
        vim-tmux-navigator
      ];
      extraConfig = ''
        set noemoji
        nnoremap : <cmd>FineCmdline<CR>
      '';
      extraLuaConfig = ''
        ${builtins.readFile ./nvim/plugins/autocomplete.lua}
        ${builtins.readFile ./nvim/plugins/autoformat.lua}
        ${builtins.readFile ./nvim/plugins/autopairs.lua}
        ${builtins.readFile ./nvim/plugins/color-scheme.lua}
        ${builtins.readFile ./nvim/plugins/dashboard.lua}
        ${builtins.readFile ./nvim/plugins/formatting.lua}
        ${builtins.readFile ./nvim/plugins/git-signs.lua}
        ${builtins.readFile ./nvim/plugins/indent_line.lua}
        ${builtins.readFile ./nvim/plugins/init.lua}
        ${builtins.readFile ./nvim/plugins/lazygit.lua}
        ${builtins.readFile ./nvim/plugins/linting.lua}
        ${builtins.readFile ./nvim/plugins/lsp.lua}
        ${builtins.readFile ./nvim/plugins/mini-nvim.lua}
        ${builtins.readFile ./nvim/plugins/oil.lua}
        ${builtins.readFile ./nvim/plugins/rename.lua}
        ${builtins.readFile ./nvim/plugins/rust.lua}
        ${builtins.readFile ./nvim/plugins/telescope.lua}
        ${builtins.readFile ./nvim/plugins/treesitter.lua}
        ${builtins.readFile ./nvim/plugins/which-key.lua}
      '';
    };
  };
}
